require 'pry'
class Lexiconomitron
  def eat_t(sentence)
    sentence.delete "t"
  end

  def shazam(words)
    [words.first, words.last].map { |word| eat_t(word).reverse }
  end

  def oompa_loompa(words)
    # binding.pry
    words.select { |word| word.size <= 3 }.map { |word| eat_t(word) }
  end
end

#### RSPEC TESTS ####
describe Lexiconomitron do 
  before do
    @lexi = Lexiconomitron.new
  end

  describe "#eat_t" do
    it "should remove every letter t from the input" do
      expect(@lexi.eat_t("great scott!")).to eq("grea sco!")
    end
  end

  describe "#shazam" do
    it "should return first and last words reversed and no t's" do
      expect(@lexi.shazam(%w{this is a boring test})).to eq(%w{sih se})
    end
  end

  describe "#oompa_loompa" do
    it "should return words with three or less characters" do
      expect(@lexi.oompa_loompa(%w{do you wanna be my lover})).to eq(%w{do you be my})
    end

    it "should return words with three or less characters after eating t's" do
      expect(@lexi.oompa_loompa(%w{do you want to be my lover truc})).to eq(%w{do you o be my})
    end
  end
end