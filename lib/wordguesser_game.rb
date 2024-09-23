class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
 
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
    
  # Get a word from remote "random word" service
  # Word Guesser Game constuctor
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    # Validate input
    raise ArgumentError, "Input must be a single letter" if letter.nil? || letter.empty? || letter.length > 1
    raise ArgumentError, "Input must be a letter" if !letter.match?(/[a-zA-Z]/)
    
    letter.downcase!

    # Check if the letter has already been guessed
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    # Check if the letter is in the word
    if @word.include?(letter)
      @guesses += letter unless @guesses.include?(letter)
      return true
    else
      @wrong_guesses += letter unless @wrong_guesses.include?(letter)
      return true
    end
    @word_with_guesses = word_with_guesses
  end

  def guess_several_letters(letters)
    letters.each { |letter| guess(letter) }
  end

  def guess_several_letters(game, letters)
    game.guess_several_letters(letters)
  end

  def word_with_guesses
    display = ""
    @word.chars.each do |letter|
      if @guesses.include?(letter)
        display += letter
      else
        display += "-"
      end
    end
    display 
  end

  def check_win_or_lose
    if self.word_with_guesses == @word
      :win
    elsif self.word_with_guesses != @word && @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end


end
