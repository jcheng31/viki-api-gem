module Viki
  module Spec
    module Stub
      def async_stub(name)
        rspec_stub = stub(name)
        AsyncStubs.stub(self, name)
        rspec_stub
      end

      def self.remove_async_stub
        FutureExecution.reset!
        AsyncStubs.reset!
      end

      def keep_old_method_ref(name, ref_name)
        singleton_class.send(:alias_method, ref_name, name)
      end

      def singleton_class
        class << self; self end
      end

      class AsyncStubs
        def self.stub(object, name)
          add(object, name) unless self.stubbed?(object, name)
        end

        def self.add(object, name)
          ref_name = "hey_#{name}"
          object.keep_old_method_ref(name, ref_name)
          object.define_singleton_method name do |*args, &blk|
            FutureExecution.add(object.name, name) do
              self.send(ref_name, *args, &blk)
            end
          end
          mark_as_stubbed(object, name)
        end

        def self.mark_as_stubbed(object, name)
          @stubs ||= Set.new
          @stubs.add("#{object.name}_#{name}")
        end

        def self.stubbed?(object, name)
          return false if @stubs.nil?
          @stubs.include?("#{object.name}_#{name}")
        end

        def self.reset!
          @stubs = nil
        end
      end

      class FutureExecution
        def self.add(receiver_name, method_name, &method)
          override_viki_run
          add_new_future_execution(receiver_name, method_name, method)
        end

        def self.override_viki_run
          return false if @hooked
          object = self
          store_real_viki_run
          Viki.define_singleton_method :run do
            object.execute_all
            AsyncStubs.reset!
            object.reset!
          end
          @hooked = true
        end

        def self.add_new_future_execution(receiver_name, method_name, method)
          @store ||= Hash.new { |h, k| h[k] = [] }
          @store["#{receiver_name}_#{method_name}"] << method
        end

        VIKI_RUN_REF = :run_ref

        def self.store_real_viki_run
          class << Viki
            alias_method VIKI_RUN_REF, :run
          end
        end

        def self.execute_all
          @store.values.each { |methods| methods.each(&:call) }
        end

        def self.reset!
          @hooked = nil
          @store = nil
          restore_real_viki_run
        end

        def self.restore_real_viki_run
          class << Viki
            if self.method_defined?(VIKI_RUN_REF)
              alias_method :run, VIKI_RUN_REF
            end
          end
        end
      end
    end
  end
end
