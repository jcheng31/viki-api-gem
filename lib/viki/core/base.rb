module Viki::Core
  class Base
    class InvalidOption < RuntimeError
      def initialize(field, value)
        super("Invalid value for '#{field}' field: #{value}")
      end
    end
    class InsufficientOptions < RuntimeError
    end

    PATH_TOKENS_REGEX = /\/:(\w+)/
    END_OF_PATH_REGEX = /(\/\w+)(\.\w+)?$/

    class << self
      attr_accessor :_paths, :_ssl

      def use_ssl
        @_ssl = true
      end

      def path(path)
        @_paths ||= []
        @_paths.push path
      end

      def uri(params = {})
        path = select_best_path(_paths, params)
        path, params = process_ids(path, params)
        params = process_user_country(params)
        uri = Addressable::URI.join("http#{"s" if @_ssl}://#{Viki.domain}", path)
        query_values = {}
        query_values.merge! uri.query_values if uri.query_values
        query_values.merge! params
        query_values[:app] = Viki.app_id

        token = Viki.user_token && Viki.user_token.call
        query_values[:token] = token if token && !token.empty?

        uri.query_values = query_values
        uri
      end

      def signed_uri(params = {}, body = nil)
        Viki.signer.sign_request(uri(params).to_s, body)
      end

      def fetch(url_options = {}, &block)
        uri = signed_uri(url_options)
        Viki.logger.info "#{self.name} fetching from the API: #{uri}"
        fetcher = Viki::Core::Fetcher.new(uri)

        fetcher.queue &block
        fetcher
      end

      def fetch_sync(url_options = {})
        response = nil
        fetch(url_options) { |r| response = r }
        Viki.run
        response
      end

      def create(url_options = {}, body = {}, &block)
        uri = signed_uri(url_options, body)
        Viki.logger.info "#{self.name} creating to the API: #{uri}"
        creator = Viki::Core::Creator.new(uri, body)
        creator.queue &block
        creator
      end

      def create_sync(url_options = {}, body = {})
        response = nil
        create(url_options, body) { |r| response = r }
        Viki.run
        response
      end

      def update(url_options = {}, body = {}, &block)
        uri = signed_uri(url_options, body)
        Viki.logger.info "#{self.name} updating to the API: #{uri}"
        creator = Viki::Core::Updater.new(uri, body)
        creator.queue &block
        creator
      end

      def update_sync(url_options = {}, body = {})
        response = nil
        update(url_options, body) { |r| response = r }
        Viki.run
        response
      end

      def destroy(url_options = {}, body = {}, &block)
        uri = signed_uri(url_options)
        Viki.logger.info "#{self.name} destroying to the API: #{uri}"
        destroyer = Viki::Core::Destroyer.new(uri, body)
        destroyer.queue &block
        destroyer
      end

      def destroy_sync(url_options = {}, body = {})
        response = nil
        destroy(url_options, body) { |r| response = r }
        Viki.run
        response
      end

      private

      def select_best_path(paths, params)
        return paths.first if paths.length == 1
        params_keys = params.keys.map(&:to_s)

        paths.sort_by do |path|
          url_params = path.scan(PATH_TOKENS_REGEX).flatten
          -(url_params & params_keys).length
        end.first
      end

      def process_ids(path, params)
        to_replace = path.scan(PATH_TOKENS_REGEX).flatten
        to_replace.each do |id_field|
          value = params.delete(id_field.to_sym)
          raise Viki::Core::Base::InsufficientOptions unless value
          path = path.gsub(":#{id_field}", value)
        end

        resource_id = params.delete(:id)
        if resource_id
          path = path.gsub END_OF_PATH_REGEX, "\\1/#{resource_id}\\2"
        end

        [path, params]
      end

      def process_user_country(params)
        user_country = Viki.user_country.call
        params["watchable_in"] = user_country if user_country
        params
      end
    end
  end
end
