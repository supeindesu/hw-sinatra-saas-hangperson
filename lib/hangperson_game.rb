class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(my_word)
    @word = my_word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    case letter
      when nil
        raise ArgumentError
      when ""
        raise ArgumentError
      when /[^a-zA-Z]/
	      raise ArgumentError
      else
        if @word.include? letter.downcase
          if @guesses.include? letter.downcase
            false
          else
            @guesses += letter.downcase
            true
          end
        else
          if @wrong_guesses.include? letter.downcase
            false
          else
            @wrong_guesses += letter.downcase
            true
          end
        end
    end
  end
  
  def word_with_guesses()
    difference = (@word.split(//)-@guesses.split(//)).uniq
    output = ""
    @word.split(//).each do |letter|
      if ! difference.include? letter
        output += letter
      else 
        output += "-"
      end
    end
    output
  end

  def check_win_or_lose()
    difference = (@word.split(//)-@guesses.split(//)).uniq
    if difference.empty?
      :win
    elsif @wrong_guesses.length > 6
      :lose
    else 
      :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
