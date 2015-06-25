class Varys
  def say_my_name!
    "I am Varys, and I'm here to say what you want to hear."
  end

  def say_cersei_rocks!
    "Cersei rocks!"
  end

  def say_joffrey_rocks!
    "Joffrey rocks!"
  end

  def reverse_large(words)
    all_strings = words.map(&:to_s)    
    all_strings.select do |word| 
      word.length >=5 
    end.map { |word| word.reverse }
  end

  def friday_numbers(numbers)
    if friday? 
      numbers.select { |n| n < 0 }
    else 
      numbers.select { |n| n >= 0 }
    end
  end 

  private

  def friday?
    Time.now.friday?
  end
end


#### RSPEC TESTS ####
describe Varys do
  before do
    @varys = Varys.new
  end

  describe "#reverse_large" do
    it "should return %w{orrub ateuqar agirtni}" do
      expect(@varys.reverse_large(%w{bar burro cara raqueta intriga})).to eq(%w{orrub ateuqar agirtni})
    end

    it "should convert other types to strings" do
      expect(@varys.reverse_large(["bar", "burro", "cara", "raqueta", "intriga", 31972, :cacatua])).to eq(%w{orrub ateuqar agirtni 27913 autacac})
    end

    it "should ignore nils" do
      expect(@varys.reverse_large(["orrub", "ateuqar", "agirtni", nil])).to eq(%w{burro raqueta intriga})
    end
  end

  describe "#friday_numbers" do
    it "should return below 0 (Friday)" do
      allow(@varys).to receive(:friday?).and_return(true)
      expect(@varys.friday_numbers([5.4, 3.8, 9.0, 0.2, -1.4, -3.2, 0])).to eq([-1.4, -3.2])
    end

    it "should return above or equal 0 (not Friday)" do
      allow(@varys).to receive(:friday?).and_return(false)
      expect(@varys.friday_numbers([5.4, 3.8, 9.0, 0.2, -1.4, -3.2, 0])).to eq([5.4, 3.8, 9.0, 0.2, 0])
    end
  end
end
