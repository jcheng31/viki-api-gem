module JsonFixtures
  def json_fixture(fixture)
    file = File.join(File.dirname(__FILE__), "../fixtures/#{fixture}.json")
    File.read(file)
  end
end