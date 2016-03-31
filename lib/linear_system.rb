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

  @@results_directory ='../results'


  attr_accessor :parameters, :matrix, :vector


  def initialize(parameters)

    @parameters = parameters
    @matrix = []
    # to complete
    @results_file =  File.new("#{@parameters[:equations_number]}equat_and_#{@parameters[:var_number]}var_#{Time.now}.txt", "w+")

  end


  ###############################################
  #  Linear system values gathering
  ###############################################
  def equations_setting

    i = 0
      @parameters[:equations_number].times do |equation|
        line = []
        puts "Please enter parameters for the equation #{i+1}"
        j = 0
        (@parameters[:var_number]).times do |parameter|
          inputx = HighLine.new
          xi = inputx.ask "Please give the coeff for "+ "X#{j+1}".green
          line.push xi.to_f
          j +=1
        end
        inputy = HighLine.new
        y = inputy.ask "Please give the value of y for the equation #{i+1}"
        line.push y.to_f
        @matrix << line
        i += 1
      end

  end



  ###############################################
  #  Convert the 2 dimension Array into Matrix
  ###############################################
  def convert_array_to_matrix


  end

   ###############################################
   #  Verify that matrix detreminant is not equal
   #  to 0 and the system can be resolved
   ###############################################
   def check_det(matrix)

     if matrix.determinant == 0
       puts "The det is null mother fucker"
     end

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
