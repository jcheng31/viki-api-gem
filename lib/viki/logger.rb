require 'logger'

class Viki::Logger < Logger
  def self.info(text)
    super(INFO, "[Viki API] #{text}")
  end

  def self.error(text)
    super(ERROR, "[Viki API] #{text}")
  end

  def self.fatal(text)
    super(FATAL, "[Viki API] #{text}")
  end

  def self.warn(text)
    super(WARN, "[Viki API] #{text}")
  end
end