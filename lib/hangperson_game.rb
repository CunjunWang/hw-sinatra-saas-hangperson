class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(guess_letter)
    ## if the letter is guessed before
    if @word.include? guess_letter
      if include_letter?(@guesses, guess_letter)
        false
      end
      @guesses = @guesses + guess_letter
      true
    else
      if include_letter?(@wrong_guesses, guess_letter)
        false
      end
      @wrong_guesses = @wrong_guesses + guess_letter
      true
    end
  end

  def include_letter?(str, letter)
    (str.include? letter) or (str.include? letter.upcase) or (str.include? letter.downcase)
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
