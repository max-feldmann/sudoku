require_relative "tile"

class Board
    attr_reader :grid

    # -------------- GENERATION/INITIALISATION OF THE BOARD ----------------------------------

    def self.empty_grid # produces an empty gird 9 X 9
        Array.new(9) do
            Array.new(9) {Tile.new(0)}
        end
    end

    def self.get_rows_from_file(filename) # read in files and get individual rows in an array (rows => ["123", "456"])
        rows = File.readlines(filename).map(&:chomp)
        return rows
    end

    def self.map_rows(filename) #  transform into two-dim array ["123", "456"] #=> [[1,2,3], [4,5,6]]
        rows = get_rows_from_file(filename) # call get_rows to produce rows from file

        mapped_rows = []    
        rows.each do |row|  # go through each row (row => 123)
            nums = row.split("")    # split row and store in num (num => ["1", "2", "3"])
            mapped_rows << nums.map(&:to_i) # make elements of nums to integers (num => [1,2,3]) and push to mapped_rows
        end

        mapped_rows 
    end

    def self.produce_tiles(filename) # make every element of Arr a tile-instance [[1,2,3],[4,5,6]] => [[#<value = 1, given = false> and so on]] || Initialise new board with that
        rows = map_rows(filename) # get the mapped rows (rows => [[1,2,3], [4,5,6]])
        
        tiles = []      
        rows.each do |row|       
            tiles << row.map {|number| Tile.new(number)} # go through all elements of rows, capturing each row. map row to create new array made of Tiles with the rows individual value as init. push  mapped row to tiles-array
        end

        self.new(tiles) # create new instance of board with "tiles" as value. tiles is 2D grid of Tile-Instances with length of the files rows
    end

    def initialize (grid = Board.empty_grid)
        #initialise Board with a grid. Empty grid as default value.
        @grid = grid
    end

    # ----------------- ACTUAL BOARD METHODS ------------------------------------


end

b = Board.produce_tiles("puzzles/sudoku1.txt")

vals =  
b.grid.each do |row|
    row.map {|tile| tile.value} 
    #row.each do |tile|
    #vals << tile.value.to_s
    #end
end

p b.grid
p vals
p vals.length