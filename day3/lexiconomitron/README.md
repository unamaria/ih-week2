# The Lexiconomotron

We are going to create an awesome class called Lexiconomitron. This class is the goddamn master when it comes to phrases, words, and this kind of stuff, and it has a Ruby interface so we can speak to it. This class only has one downside: it loves the letter T, so it devoures them (uppercase and lowercase!). If it has to return, let’s say “trigonometry”, it only gives “rigonomery” back.

## Iteration 1: Hungry for T

Create the Lexiconomitron class. Write a method called `eat_t` to pass the following test:

```
describe Lexiconomitron do 
  describe "#eat_t" do
    it "removes every letter t from the input" do
      @lexi = Lexiconomitron.new
      expect(@lexi.eat_t("great scott!")).to eq("grea sco!")
    end
  end
end
```

## Iteration 2: Shazam

One of the methods of this Ruby interface is one called “shazam”. It takes an array of words (for example [“This”, “is”, “a”, “boring”, “test”]). With this array, it reverses the letters within the words (that is, [“sihT”, “si”, “a”, “gnirob”, “tset”]) and ends up returning only the first and last words. But Lexiconomitron eats Ts, so it returns [“sih, “se”].

Write a test for the `shazam` method. Instead of creating a new instance of the Lexiconomitron class for each test, add a `before` method that does it for you.

Write the `shazam method to pass the test.

## Iteration 3: Oompa loompa

Another method of Lexiconomitron is called “oompa_loompa”. Also taking an array of words (boy, it loves words), lets say for example [“if”, “you”, “wanna”, “be”, “my”, “lover”], it takes the ones which size is three characters of less in the same order, so: [“if”, you”, “be”, “my”]. After passing the eat-all-t-letters filter, it’s… the same!

Write some tests for this method, exploring different scenarios and spec data. Then write the method to pass it.
