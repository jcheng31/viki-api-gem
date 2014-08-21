class Viki::Srt < Viki::Core::Base
  IMPORT_SRT='import_srt'
  path '/videos/:video_id/subtitles/import_srt', name: IMPORT_SRT

  def self.import(options = {}, body = {}, &block)
    self.create(options.merge(named_path: IMPORT_SRT), body, &block)
  end
end