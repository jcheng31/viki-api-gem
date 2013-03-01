module SrtFixtures
  def srt_fixture(fixture)
    file = File.join(File.dirname(__FILE__), "../fixtures/#{fixture}.srt")
    File.read(file)
  end
end
