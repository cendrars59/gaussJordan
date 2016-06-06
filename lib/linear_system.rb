###############################################
#  Vendor dependencies
###############################################
require 'colorize'
require 'terminal-table'
require 'highline'
require 'matrix'

###############################################
#  Lib dependencies
###############################################
require_relative "gaussjordan"
require_relative "displayable"


class LinearSystem

  ###############################################
  #  Module dependencies
  ###############################################
  include GaussJordan

  

  attr_accessor :parameters, :matrix, :equat


  def initialize(parameters)
    @parameters = parameters
    @matrix = []
    @equat = Matrix.build(@parameters[:equations_number],@parameters[:var_number]){rand}
  end


  ###############################################
  #  Linear system values gathering
  ###############################################
  def equations_setting

    i = 0
      @parameters[:equations_number].times do |equation|
        line = []
        line2 = []
        puts "Please enter parameters for the equation #{i+1}"
        j = 0
        (@parameters[:var_number]).times do |parameter|
          inputx = HighLine.new
          xi = inputx.ask "Please give the coeff for "+ "X#{j+1}".green
          line.push xi.to_f
          line2.push xi.to_f
          j +=1
        end
        Matrix.rows(@equat.to_a << line2)
        inputy = HighLine.new
        y = inputy.ask "Please give the value of y for the equation #{i+1}"
        line.push y.to_f
        @matrix << line
        i += 1
      end

  end



   ###############################################
   #  Verify that matrix detreminant is not equal
   #  to 0 and the system can be resolved
   ###############################################
   def calculated_determinant
      # A arrondir à digit puis à mettre sous forme fractionnelle 
     @equat.determinant
   end 
   



   ###############################################
   #  Gaussian resolution of the system
   ###############################################
   def gaussian

      temp_matrix = @matrix
      temp_matrix = GaussJordan::calc(temp_matrix)
      Displayable::results_table(GaussJordan::get_results(temp_matrix))

   end

   private

   ###############################################
   #  Method to convert a value in integer or fractional
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
