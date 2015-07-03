start = Time.now

Cell.starting_cells
Cell.assign_and_subtract_from_total_resources

ends = Time.now

p ends - start