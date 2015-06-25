require 'imdb'

class SeriesMaster
  def find(serie)
    Imdb::Search.new(serie).movies.count
  end

  def most_seasons_from(series_s)
    sorted = objectify_series(series_s).sort_by do |serie|
      serie.seasons.count
    end
    max = sorted.last.seasons.count
    selected = objectify_series(series_s).select { |serie| serie.seasons.count == max }
    series_titles = selected.map { |serie| get_title(serie) }
  end

  def most_episodes_from(series_s)
    series_o = objectify_series(series_s)
    series_seasons = Hash[series_o.map{ |serie| [get_title(serie), serie.seasons] }]
    series_seasons.each do |serie, seasons|
      series_seasons[serie] = seasons.inject(0) do |episodes, season|
        episodes + season.episodes.count # not working?
      end
    end
    series_seasons.max_by { |serie, episodes| episodes }[0]
  end

  def best_from(series_s)
    sorted = objectify_series(series_s).sort_by { |serie| serie.rating }
    get_title(sorted.last)
  end

  def top(n)
    return nil if n < 1
    return "Max 250" if n > 250
    top = Imdb::Top250.new.movies.first(n)
    Hash[top.map{ |serie| [get_title(serie).sub(/[0-9]\.\n\s+/, ''), serie.rating] }]
  end
  
  private

  def get_title(serie)
    serie.title.delete "\""
  end

  def objectify_series(series_s)
    series_o = []

    series_s.each do |serie|
      search = Imdb::Search.new(serie)
      serie_id = search.movies.first.id
      serie = Imdb::Serie.new(serie_id)
      series_o << serie
    end

    series_o
  end
end


### RSPEC TESTING ###
describe SeriesMaster do
  before do
    @master = SeriesMaster.new
  end

  describe "#find" do
    it "should return how many when results" do
      expect(@master.find('Grit')).to eq(223)  
    end

    it "should return 0 when no results" do
      expect(@master.find('nfdskhiruknjvfd')).to eq(0)
    end
  end

  describe "#most_seasons_from" do
    it "should return Friends" do
      expect(@master.most_seasons_from(%w{ Friends The\ Office Breaking\ Bad })).to eq(['Friends'])
    end

    it "should return all series with max seasons" do
      expect(@master.most_seasons_from(%w{ Black\ Mirror Breaking\ Bad Homeland })).to eq(['Breaking Bad', 'Homeland'])
    end
  end

  describe "#most_episodes_from" do
    it "should return Breaking Bad" do
      expect(@master.most_episodes_from(%w{ Breaking \Bad Black\ Mirror })).to eq("Breaking Bad")
    end
  end

  describe "#best_from" do
    it "should return Breaking Bad" do
      expect(@master.best_from(["Breaking Bad", "Pacific Blue", "The Affair"])).to eq("Breaking Bad") 
    end
  end

  describe "#top" do
    it "should return top 3" do
      expect(@master.top(3)).to eq({"Cadena perpetua" => 9.3, "El padrino" => 9.2, "El padrino. Parte II" => 9.1 })   
    end

    it "should return nil" do
      expect(@master.top(0)).to eq(nil)
    end

    it "should return error message" do
      expect(@master.top(251)).to eq("Max 250")
    end
  end
end