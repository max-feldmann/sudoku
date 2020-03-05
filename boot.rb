require_relative 'sudoku.rb'
#require 'byebug'

class Boot
    
    attr_reader :sudoku_game
    def initialize(filename)
#        debugger
        sudoku_game = Sudoku.new(filename)
    end

    def welcome
        puts "Hey there, Welcome to Sudoku!"
        puts
        puts "Do you want to start the game?"
        puts
        puts "[y] to start || [n] to quit"
        puts
        start_or_quit?(gets.chomp.downcase)
    end

    def start_or_quit?(answer)
        if answer == "y"
            board.run
        else
            puts "Sad, bye bye!"
            return
        end
    end
end

b = Boot.new("puzzles/sudoku1_almost.txt")
b.welcome