# Example usage:
require 'pp'
require 'matrix'
require 'colorize'
require 'terminal-table'
require 'highline'
#require_relative 'lib/gaussian'
require_relative "lib/linear_system"



def check_det(matrix)
  if matrix.determinant == 0
    puts "The det is null mother fucker"
  end
end

def linear_system_can_be_resolved

end

def initilization_linear_system(parameters)
  input1 = HighLine.new
  parameters[:equations_number]= input1.ask "Please give the number of equations"
  input2 = HighLine.new
  parameters[:var_number] = input2.ask "Please give the number of vars"
  return parameters
end


def menu

  puts "Enter your choice"
  # Get the choice

  # According the choice enter into the feature

end

def linear_system_display(matrix,vector)
  to_display = matrix.zip(vector).compact
  to_display.to_a.each {|r| puts r.inspect.green}
end


# Assumes 'matrix' is in row echelon form.
def backSubstitution(matrix, vector)
  (matrix.length - 1).downto( 0 ) do |row|
    tail = vector[row]
    (row+1).upto(matrix.length - 1) do |col|
      tail -= matrix[row][col] * vector[col]
      matrix[row][col] = 0.0
    end
    vector[row] = tail / matrix[row][row]
    matrix[row][row] = 1.0
  end
end


# Display management of the linear system
def results_table(vector)
   rows = []
   rows << ["Var", "Values"]
   rows << [" " ," "]
   count = 1
   vector.each do |value|
     #rows << "X#{count} ".green + "= " +  .red
     rows << ["X#{count}".green,"#{value.to_r}".red]
     count +=1
   end
   table = Terminal::Table.new :title =>"Calculated solution".yellow , :rows => rows
   puts table
 end


# parameters initialzation

equation_max_number = 4
var_max_number = 4
parameters = {}
initilization_linear_system(parameters)
lsystem = LinearSystem.new(parameters)
lsystem.equations






# A system of equations: matrix * X = vector
# matrix =
# [
#     [1.0, 1.0, 1.0],
#     [1.0, 2.0, 2.0],
#     [1.0, 2.0, 3.0],
# ]
#
# #puts matrix.methods
# #puts Matrix.methods
#
#
# vector = [1.0, 2.0, 3.0]
#
#
#
# # Create a backup for verification.
# matrix_backup = Marshal.load(Marshal.dump(matrix))
# vector_backup= vector.dup
#
# # Gaussian elemination to put the system in row echelon form.
# gaussianElimination(matrix, vector)
# # Back-substitution to solve the system.
# backSubstitution(matrix, vector)
#
#
# #Display of the results
# results_table(vector)
#
#
#
# # Verify the result.
# pass = true
#
# 0.upto(matrix_backup.length - 1) do  |eqn|
# sum = 0
# 0.upto(matrix_backup[eqn].length - 1) do |term|
#     sum += matrix_backup[eqn][term] * vector[term]
# end
# if (sum - vector_backup[eqn]).abs > 0.0000000001
#     pass = false
#     break
# end
# end
#
# if pass
#   puts "Verification PASSED."
# else
#   puts "Verification FAILED."
# end
