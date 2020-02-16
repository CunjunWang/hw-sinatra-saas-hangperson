class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = build_guessed_word(word)
  end

  def guess(guess_letter)
    if guess_letter == '' or guess_letter == nil
      raise ArgumentError.new "Cannot guess an empty letter"
    end

    unless guess_letter.match(/[a-zA-Z]/)
      raise ArgumentError.new "Please guess a letter."
    end

    ## if the letter is guessed before
    if @word.include? guess_letter.downcase
      if include_letter?(@guesses, guess_letter)
        return false
      end

      @guesses = @guesses + guess_letter
      @word.each_char.with_index do |char, index|
        if guess_letter == char
          @word_with_guesses[index] = guess_letter
        end
      end

      true
    else
      if include_letter?(@wrong_guesses, guess_letter)
        return false
      end
      @wrong_guesses = @wrong_guesses + guess_letter
      true
    end
  end

  def include_letter?(str, letter)
    str = str.downcase
    # puts "str = " + str
    letter = letter.downcase
    # puts "letter = " + letter
    str.include? letter
  end

  def build_guessed_word(word)
    guess_word = ""
    word.chars do |_|
      guess_word += "-"
    end
    guess_word
  end

  def check_win_or_lose
    if @word == @word_with_guesses
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
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
