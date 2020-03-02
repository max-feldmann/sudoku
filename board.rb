require_relative "tile"

class Board
    # -------------- SETUP/INITIALISATION OF THE BOARD ----------------------------------

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

    # ----------------- RENDER & ACCESS BOARD ------------------------------------

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        grid.each_with_index do |row, i|
            puts "#{i} #{row.map(&:to_s).join(" ")}"
        end
    end

    def [](pos) # Access board at given position
      row, col = pos
      grid[row][col]
    end
    
    def []=(pos, value) # set value on board at given position
      row, col = pos
      tile = grid[row][col]
      tile.value = value
    end

    def columns # transpose [[1,2,3], [4,5,6]].transpose => [[1,4], [2,5],[3,6]]
        grid.transpose
    end

    def rows # returns grid
        grid
    end


    def square(idx)
        # "Square-Algorithm" explained
        # takes advantage of division by non-floats => 0-2 will return 0. 3-5 will return 1. 6-9 will return 3
        # takes advantage of modulo behaviour. => 0 % 3 = 0 | 1 % 3 = 1 | 2 % 3 = 2 | 3 % 3 = 0 | 4 % 3 = 1 and so on
        # so for first iteration of squares, we pass idx = 0 and get x,y = 0,0. 2nd we pass 1 and get x,y = 0, 1. 0,0/0,1/0,2/1,0/1,1/1,2/2,0/2,1/2,2
        # x and y are the multiplied by 3 to get the "starting points" => 0,0/0,3/0,6/3,0/3,3/3,6/6,0/6,3/6,6
            # each loop now. for idx = 0 we go from x = 0 up to and including x = 2
            # for y its the same
            # we capture the tiles from grid at indices 0,0 to 2,2 and shovel them to tiles.
            # tiles contains 9 positions now and is returned
        # now we get idx = 1 and the routine starts again.
        tiles = []
        x = (idx / 3) * 3
        y = (idx % 3) * 3
    
        (x...x + 3).each do |i|
          (y...y + 3).each do |j|
            tiles << self[[i, j]]
          end
        end
    
        tiles
    end
    
    def squares
        # numbers 0 to 8 are passed to square, which return a 9-piece set of tiles (aka a square)
        # (0..8) is turned to an array. that array is then turned to a 2D array, where every nubmer becomes on of said tiles
        (0..8).to_a.map { |i| square(i) }
    end

    # --------------- CHECK IF BOARD IS SOLVED -----------------
    def is_it_a_solved_set?(tiles)
        nums = tiles.map(&:value)
        nums.sort == (1..9).to_a
    end

    def is_the_whole_board_solved?
        rows.all?{|row| is_it_a_solved_set?(row)} &&
            columns.all?{|column| is_it_a_solved_set?(column)} &&
            squares.all?{|square| is_it_a_solved_set?(square)}
    end




    private

    attr_reader :grid
end


# ----------- STUFF TO TEST & PLAY AROUND ---------------

b = Board.produce_tiles("puzzles/sudoku1.txt")


b.render