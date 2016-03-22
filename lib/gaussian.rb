class gaussianElimination
  def gaussianElimination(matrix, vector)
  0.upto(matrix.length - 2) do |pivotIdx|
      # Find the best pivot. This is the one who has the largest absolute value
      # relative to his row (scaled partial pivoting). This step can be omitted
      # to improve speed at the cost of increased error.
      iteration  = 1
      maxRelVal = 0
      maxIdx = pivotIdx
      (pivotIdx).upto(matrix.length - 1) do |row|
        relVal = matrix[row][pivotIdx] / matrix[row].map{ |x| x.abs }.max
        if relVal >= maxRelVal
          maxRelVal = relVal
          maxIdx = row
        end
      end

      # Swap the best pivot row into place.
      matrix[pivotIdx], matrix[maxIdx] = matrix[maxIdx], matrix[pivotIdx]
      vector[pivotIdx], vector[maxIdx] = vector[maxIdx], vector[pivotIdx]
      pivot = matrix[pivotIdx][pivotIdx]

      # Loop over each row below the pivot row.
      (pivotIdx+1).upto(matrix.length - 1) do |row|
        # Find factor so that [this row] = [this row] - factor*[pivot row]
        # leaves 0 in the pivot column.
        factor = matrix[row][pivotIdx]/pivot
        # We know it will be zero.
        matrix[row][pivotIdx] = 0.0
        # Compute [this row] = [this row] - factor*[pivot row] for the other cols.
        (pivotIdx+1).upto(matrix[row].length - 1) do |col|
            matrix[row][col] -= factor*matrix[pivotIdx][col]
        end
      vector[row] -= factor*vector[pivotIdx]
      end
      puts "Pivot value: #{pivot}"
      linear_system_display(matrix,vector)
    end
    return [matrix,vector]
  end
end
