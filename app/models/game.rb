require 'pry'

class Game

WORDS = ["abstract", "water", "turing", "glasses", "ribald", "bagpipes", "fervid", "gazebo", "klutz", "ostracize", "phlegm", "yacht", "squawk", "quip", "matrix", "astoria", "brooklyn"]

	def initialize
		@turns = 7
		@correct_guess = []
		@user = User.new
		@wins = @user.wins
		@losses = @user.losses
	end

	def greeting
		puts "Hello! Welcome to Hangman! What's your name?"
		@user.name = gets.chomp.capitalize
		puts "Hi, #{@user.name}! The objective of this game is to guess the hidden word before you run out of turns and die."
	end
		
	def play?
		puts "You currentlty have #{@wins} wins and #{@losses} losses. Would you like to play? y/n"
		user_response = gets.chomp
		if user_response == "y"
			puts "Great! If you would like to exit the game at any time, type exit and press enter."
			@turns = 7
			display_word
		elsif user_response == "n"
			puts "OK, goodbbye!"
			exit
		else
			puts "please enter 'y' or 'n'"
			play?
		end
	end

	def display_word
		@word = WORDS.sample.split(//)
		puts "Your word is #{@word.length} letters long."
	end

	def pick_a_letter
		puts "Pick a letter from A to Z, or guess the entire word."
		@guess = gets.chomp
	end

	def guess_correctly?
		@word.include?(@guess)
	end

	def correct_guess?
		if @guess.split(//).sort == @word.sort
			puts "You win! The word is '#{@word.join}'."
			@wins +=1
			@correct_guess.clear
			play?

		elsif guess_correctly?
			indexes = @word.each_index.select { |i| @word[i] == @guess}
			indexes = indexes.map {|i| i + 1}
			indexes.size.times do
				@correct_guess << @guess
			end
			puts "You guessed correctly. The letter you guessed is in slot number(s) #{indexes.join(', ')} in the word."
		else
			@turns -= 1
			puts "You did not guess correctly. You have #{@turns} turn(s) remaining."
		end
	end

	def won_or_lost?
		if @word.sort.uniq == @correct_guess.sort.uniq
			puts "You win! The word is '#{@word.join}'."
			@wins +=1
			@correct_guess.clear
			play?
		elsif
			@turns == 0
			puts "You're out of turns. You've been hanged. Would you like to try again with a new life?"
			@losses +=1
			play?
		end
	end

	def full_game
		greeting
		play?
		until won_or_lost? 
			pick_a_letter
			correct_guess?
			won_or_lost?
		end
	end
end