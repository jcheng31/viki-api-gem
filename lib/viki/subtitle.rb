class Viki::Subtitle < Viki::Core::Base
  IMPORT_SRT= 'import_srt'
  cacheable
  path '/videos/:video_id/subtitles/:language'
  path '/videos/:video_id/subtitles/import_srt.json', name: IMPORT_SRT
  default format: 'srt'

  def self.import_srt(options = {}, &block)
    self.create(options.merge(named_path: IMPORT_SRT), &block)
  end
end
