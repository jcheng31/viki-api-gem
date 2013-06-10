class Viki::Logger
  attr_accessor :logger
  def initialize(logger)
    @logger = logger
  end

  def method_missing(log_level, text)
    return unless logger
    logger.send(log_level, "[Viki API] #{text}")
  end
end