require_relative "board"
require_relative "tile"

class Sudoku

    def initialize(filename)
        @board = Board.produce_tiles(filename)
    end

    #----------GAME-LOGIC------------

    def play_turn
        pos = get_position
        val = get_value
        board[pos]= val
        board.render
    end

    def run
        play_turn until solved?
        board.render
        puts "See you next time!"
    end

    #------------GET VAL & POSITION -----------

    def get_position #=> Returns a Position [0,0]
        # if valid position, returns an Array with the position
        position = nil

            until valid_position?(position)
                puts "Enter a Position (e.g. 0 0 or 4 5)"
                position = parse_position(gets.chomp)
            end

            position
    end

    def get_value #=> Returns a Value > Integers 1-9
        value = nil

        until valid_value?(value)
            puts "Enter a Value (Numbers 1-9)"
            value = parse_value(gets.chomp)
        end

        value
    end

    # ----------------VALIDATE VALUE & POSITION ---------------

    def valid_position?(position) #=> Return true if pos is correct (-> 0 0)
        position.is_a?(Array) &&
            position.length == 2 &&
            position.all? {|x| (0..8).to_a.include?(x)}
    end

    def valid_value?(value) #=> Returns true if val is correct (nums 1-9)
        value.is_a?(Integer) &&
            value.between?(1, 9)
    end

    def parse_position(position) #=> Returns position in the form of [0,0] (1Dim Array length 2, w/ 2 integers)
        position.split(" ").map {|char| char.to_i}
    end
    
    def parse_value(value) #=> returns value as an integer
        value.to_i
    end

    #-----------UTILITY----------
    def solved?
        board.solved?
    end

    private
    attr_reader :board

end


#---------START A GAME-----

# Change puzzle-name in class call to change puzzle

s = Sudoku.new("puzzles/sudoku1_almost.txt")
s.run