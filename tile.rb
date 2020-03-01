
require 'colorize'

class Tile
    
    attr_reader :value

    def initialize(value)
        @given = false
        @given = true if value == 0
        @value = value
    end

    def color
        if given?
            :blue
        else
            :red
        end
    end

    def given?
        @given
    end

    def to_s
        value == 0 ? " " : value.to_s.colorize(color)
    end

    def value=(new_val)
        if given?
            puts "Sorrio, you can´t change the value of a tile that was given, cheater :|"
        else
            @value = new_val
        end
    end


end