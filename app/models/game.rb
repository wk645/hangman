class Game


WORDS = ["abstract", "water", "turing", "glasses", "ribald"]

	def initialize
		@turn = 7
		@correct_guess = []
		@user = User.new
		@wins = @user.wins
		@losses = @user.losses
	end

	def greeting
		puts "Hello! Welcome to Hangman! What's your name?"
		@user.name = gets.chomp
		puts "The objective of this game is to guess the hidden word before you run out of turns and die."
		puts "Would you like to play?"
		user_response = gets.chomp
		if user_response.downcase == "yes"
			something
		else
			exit
		end
	end

	def display_word
		@word = WORDS.rand
		puts "Your word is #{@word.length} letters long."
	end

	def pick_a_letter
		puts "Pick a letter from A to Z."
		@guess = gets.chomp
	end

	def guess_correctly?
		@word.include?(@guess)
	end

	def correct_guess?
		if guess_correctly?
			puts "You guessed correctly. The letter you guessed is slot number #{@word.index(@guess) + 1} in the word."
			@correct_guess << @guess
		else
			@turn -= 1
			puts "You did not guess correctly. You have #{@turn}(s) remaining."
		end
	end

	def won?
		if @word.sort == @correct_guess.sort
			puts "You win!"
			@wins +=1
		end
	end

	def lost?
		if @turn = 0
			puts "You're out of turns. You've been hanged. Would you like to try again with a new life?"
		end
		@losses +=1
	end




end