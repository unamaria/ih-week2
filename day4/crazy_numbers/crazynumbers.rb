class Numbermaster

  def positive_or_negative(numbers)
    positives = numbers.select { |number| number > 0 }
    negatives = numbers.select { |number| number < 0 }
    if positives.length > negatives.length
      positives
    elsif positives.length < negatives.length
      negatives
    end
  end

  def statistics(numbers)
    return nil unless numbers.any?
    statistics = []
    statistics[0] = mode(numbers)
    statistics[1] = median(numbers)
    statistics[2] = mean(numbers) 
    statistics[3] = numbers.length

    statistics
  end

  def fibonacci(n)
    if n < 1
      nil
    else
      fibonacci_aux(n)
    end
  end

  private

  def fibonacci_aux(n)
    return 0 if n == 0
    return 1 if n == 1

    @fibonacci_cache ||= {}
    @fibonacci_cache[n] ||= fibonacci_aux(n-1) + fibonacci_aux(n-2)
  end

  def mean(numbers)
    (numbers.reduce(:+) / numbers.length.to_f).round(1)
  end

  def median(numbers)
    i = numbers.length / 2
    result = 0
    if numbers.length.odd?
      result = numbers[i]
    else
      result = ((numbers[i-1].to_f + numbers[i].to_f) / 2).to_f
    end
  end

  def mode(numbers)
    numbers.group_by{|n| n}.max_by{|k, v| v.size}.first
  end

end

### RSPEC TESTS ###
describe Numbermaster do
  before do
    @n_master = Numbermaster.new
  end

  describe "#positive_or_negative" do
    it "should return [2,5,7]" do
      expect(@n_master.positive_or_negative([2,5,7,-2])).to eq([2,5,7])
    end

    it "should return [-5,-7,-2]" do
      expect(@n_master.positive_or_negative([2,-5,-7,-2])).to eq([-5,-7,-2])
    end

    it "should return nil if lengths are equal" do
      expect(@n_master.positive_or_negative([7,9,2,-5,-7,-2])).to eq(nil)
    end
  end

  describe "#statistics" do
    context "when testing mode" do
      it "should return 3" do
        expect(@n_master.statistics([1,2,3,3,3,4])).to eq([3,3.0,2.7,6])
      end 
    end 

    context "when testing median" do
      it "should return mean of middle values when even length" do
        expect(@n_master.statistics([1,2,3,4])).to eq([1,2.5,2.5,4])
      end
      it "should return middle value when odd length" do
        expect(@n_master.statistics([1,2,3,4,5])).to eq([1,3,3,5])
      end  
    end

    context "when testing mean" do
      it "should return mean" do
        expect(@n_master.statistics([1,2,3,4,5,6])).to eq([1,3.5,3.5,6])
      end
    end 

    context "when testing array length" do
      it "should return 4" do
        expect(@n_master.statistics([1,2,3,4])).to eq([1,2.5,2.5,4])
      end
      it "should return nil" do
        expect(@n_master.statistics([])).to eq(nil)
      end  
    end
  end

  describe "#fibonacci" do
    it "should return 5" do
      expect(@n_master.fibonacci(5)).to eq(5)
    end
  end
end
