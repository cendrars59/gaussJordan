
##################################################################################################
#  Vendor dependencies
###################################################################################################
require 'colorize'
require 'terminal-table'
require 'highline'

##################################################################################################
#  Lib dependencies
###################################################################################################
require_relative "gaussjordan"

class LinearSystem

  ##################################################################################################
  #  Module dependencies
  ###################################################################################################
  include GaussJordan

  attr_accessor :parameters, :matrix, :vector

  def initialize(parameters)

    @parameters = parameters
    @matrix = []
    @results_file =  File.new("#{@parameters[:equations_number]}equations_and_#{@parameters[:var_number]}variables.txt", "w+")

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

  ##################################################################################################
  #  Linear system results restitution features
  ###################################################################################################

  ###############################################
  #  Results display of the linear system : To refactor
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
   #  Convert Linear system values into equation to display : To refactor
   ###############################################
   def convert_matrix_to_system

     equation_system =[]
     i = 0
     line = ""
     @matrix.each do |line|
         equation = "|"
         j = 0
         line.each do |value|
           while j < line.length - 2
           equation = equation + "| "+"#{value}".light_blue + "*X#{j+1} ".green
           end 
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

   def gaussian

      GaussJordan::calc(@matrix)

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
