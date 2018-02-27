
  def categorize_cells(inputted_checked_cells)
    @living_cells = inputted_checked_cells                                      #categorize living cells (all checked checkboxes)
    @died_cells = []                                                             #categorize died cells (all other on the gameboard)
    ROWS.times do |row|
      COLUMNS.times do |column|
        cell = "#{row}_#{column}"
        if !@living_cells.include?(cell)
          @died_cells << cell
        end
      end
    end
    [@living_cells, @died_cells]
  end

  def decide_the_next_iteration(living_cells, died_cells)
    @next_iteration = []
    living_cells.each do |living_cell|                                  #for living cells
      @neighbours = []
      @living_neighbours_count = 0                                               #because the first neighbour is the middle cell (our living cell)
      find_neighbours(living_cell)
      count_living_neighbours(living_cell)
      if @living_neighbours_count == 2 || @living_neighbours_count == 3
        @next_iteration << living_cell
      end
    end
    died_cells.each do |died_cell|                                      #for died cells
      @neighbours = []
      @living_neighbours_count = 0
      find_neighbours(died_cell)
      count_living_neighbours(died_cell)
      if @living_neighbours_count == 3
        @next_iteration << died_cell
      end
    end
    @next_iteration
  end


def count_living_neighbours(cell)
  @living_neighbours_count = 0
  @neighbours.each do |neighbour|                                              # @neighbours is an array for every living cell
    neighbour.each do |n|
      if @living_cells.include?(n)
        @living_neighbours_count += 1
      end
    end
  end
  @living_neighbours_count
end

def find_neighbours(cell)
  cell_row, cell_column = cell.split("_")
  top_neighbour = "#{cell_row.to_i-1}_#{cell_column.to_i}"
  bottom_neighbour = "#{cell_row.to_i+1}_#{cell_column.to_i}"
  left_neighbour = "#{cell_row.to_i}_#{cell_column.to_i-1}"
  right_neighbour = "#{cell_row.to_i}_#{cell_column.to_i+1}"
  top_left_neighbour = "#{cell_row.to_i-1}_#{cell_column.to_i-1}"
  top_right_neighbour = "#{cell_row.to_i-1}_#{cell_column.to_i+1}"
  bottom_left_neighbour = "#{cell_row.to_i+1}_#{cell_column.to_i-1}"
  bottom_right_neighbour = "#{cell_row.to_i+1}_#{cell_column.to_i+1}"
  @neighbours << [top_neighbour, bottom_neighbour, left_neighbour, right_neighbour, top_left_neighbour, top_right_neighbour, bottom_left_neighbour, bottom_right_neighbour]
end
