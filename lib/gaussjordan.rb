##################################################################################################
###################################################################################################
#
#
#
#  GaussJordan
#
#
#
###################################################################################################
####################################################################################################

###############################################
#  Lib dependencies
###############################################
require_relative "displayable"

module GaussJordan

  ###############################################
  #  Module dependencies
  ###############################################
  include Displayable

  ###############################################
  #  Method to proceed to the Gaussian Eleminitation
  # and display the transformed matrix at each iteration
  ###############################################
   def self.calc(matrix)

     matrix.length.times do |k|
       pivot = matrix[k][k]
       puts "Pivot value: "+"#{pivot}".red
       i = k

       i.upto(matrix[k].length - 1) do |j|
         matrix[k][j] /= pivot
       end
      matrix.length.times do |j|
         if (j != k)
           d = matrix[j][k]
           l = k
           l.upto(matrix[k].length - 1) do |m|
             matrix[j][m] -= d * matrix[k][m]
           end
         end
         puts
         Displayable::display_system(Displayable::convert_matrix_to_system(matrix))
         puts

     end
    end
     matrix
   end

   ###############################################
   #  Gathering the solution value of the system
   ###############################################
   def self.get_results(matrix)
     results = []
     matrix.each do |line|
       results.push line.last
     end
    return results
   end


end
