##################################################################################################
###################################################################################################

#
#
#
#
#
#
###################################################################################################
###################################################################################################


##################################################################################################
#  Vendor Dependencies
###################################################################################################

require 'terminal-table'
require 'bigdecimal'

##################################################################################################
#  LinearSystem class
###################################################################################################

class LinearSystem

  attr_accessor :parameters, :matrix, :vector

  def initialize(parameters)

    @parameters = parameters
    @matrix = []
    @vector = []

  end

  ##################################################################################################
  #  Linear system values gathering : Passed
  ###################################################################################################
  def equations_setting
    i = 0
      @parameters[:equations_number].times do |equation|
        line = []
        puts "Please enter parameters for the equation #{i+1}"
        j = 0
        @parameters[:var_number].times do |parameter|
          inputx = HighLine.new
          xi = inputx.ask "Please give the coeff for "+ "X#{j+1}".green
          line.push xi.to_f
          j +=1
        end
        @matrix.push line
        inputy = HighLine.new
        y = inputy.ask "Please give the value of y for the equation #{i+1}"
        @vector[i] = y.to_f
        i += 1
      end
  end

  ##################################################################################################
  #  Linear system results restitution features
  ###################################################################################################

  ###############################################
  #  Results display of the linear system : Passed
  ###############################################
  def results_table

     rows = []
     rows << ["Var", "Values"]
     rows << [" " ," "]
     count = 1
     @vector.each do |value|
       rows << ["X#{count}".green,"#{value.to_f}".red]
       count +=1
     end
     table = Terminal::Table.new :title =>"Calculated solution".yellow , :rows => rows
     puts table

   end


   ###############################################
   #  Convert Linear system values into equation to display : passed
   ###############################################
   def convert_matrix_to_system

     equation_system =[]
     i = 0
      line = ""
       @matrix.each do |line|
         equation = "|"
         j = 0
         line.each do |value|

           equation = equation + "| "+"#{value}".light_blue + "*X#{j+1} ".green
           j += 1
         end
         equation = equation + "|| #{@vector[i]}".yellow
         equation_system  << equation
         i += 1
       end
      return equation_system

   end


   ##################################################################################################
   #  Linear system calculation features
   ###################################################################################################


   ###############################################
   #  Verify that matrix detreminant is not equal to 0 and the system can be resolved
   ###############################################
   def check_det(matrix)

     if matrix.determinant == 0
       puts "The det is null mother fucker"
     end

   end


   ###############################################
   #  Gauss Jordan linear system resolution
   ###############################################
   def gaussianElimination

       0.upto(@matrix.length - 2) do |pivotIdx|
          # Find the best pivot. This is the one who has the largest absolute value
          # relative to his row (scaled partial pivoting). This step can be omitted
          # to improve speed at the cost of increased error.
          maxRelVal = 0
          maxIdx = pivotIdx
          (pivotIdx).upto(@matrix.length - 1) do |row|
            relVal = @matrix[row][pivotIdx] / @matrix[row].map{ |x| x.abs }.max
            if relVal >= maxRelVal
                maxRelVal = relVal
                maxIdx = row
            end
          end

        # Swap the best pivot row into place.
        @matrix[pivotIdx], matrix[maxIdx] = @matrix[maxIdx], @matrix[pivotIdx]
        @vector[pivotIdx], vector[maxIdx] = @vector[maxIdx], @vector[pivotIdx]

        pivot = @matrix[pivotIdx][pivotIdx]
        # Loop over each row below the pivot row.
        (pivotIdx+1).upto(@matrix.length - 1) do |row|
          # Find factor so that [this row] = [this row] - factor*[pivot row]
          # leaves 0 in the pivot column.
          factor = @matrix[row][pivotIdx]/pivot
          # We know it will be zero.
          @matrix[row][pivotIdx] = 0.0
          # Compute [this row] = [this row] - factor*[pivot row] for the other cols.
          (pivotIdx+1).upto(@matrix[row].length - 1) do |col|
              @matrix[row][col] -= factor*@matrix[pivotIdx][col]
          end
          @vector[row] -= factor*vector[pivotIdx]

        end

        return [@matrix,@vector]
    end
   end

   # Assumes 'matrix' is in row echelon form.
  def backSubstitution
    (@matrix.length - 1).downto( 0 ) do |row|
        tail = @vector[row]
        (row+1).upto(@matrix.length - 1) do |col|
          tail -= @matrix[row][col] * @vector[col]
          @matrix[row][col] = 0.0
        end
        @vector[row] = tail / @matrix[row][row]
        @matrix[row][row] = 1.0
    end
  end


  # Create a backup for verification.
  def gaussian
    matrix_backup = Marshal.load(Marshal.dump(@matrix))
    vector_backup= @vector.dup
    gaussianElimination
    backSubstitution
  end






   private

   ###############################################
   #  Method to convert a value in integer or fractional :passed
   ###############################################
   def to_numeric(anything)
      num = BigDecimal.new(anything.to_s)
      if num.frac == 0
        num.to_i
      else
        num.to_r
      end
   end

end
