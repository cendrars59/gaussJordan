###############################################
#  Vendor dependencies
###############################################
require 'colorize'
require 'highline'

module Displayable

  ###############################################
  #  Display each equation of the linear system
  ###############################################
  def self.display_system(equation_system)

    equation_system.each do |equation|
      puts equation
    end

  end

  ###############################################
  #  Convert Linear system values into equation
  # to display
  ###############################################
  def self.convert_matrix_to_system(matrix)


    equation_system =[]
    i = 0
    matrix.each do |line|
      equation = "Equation number #{i+1} : "
      j = 0
      while j < line.length - 2
        equation = equation + " "+"#{matrix[i][j]}".light_blue + "*X#{j+1}".green+" + "
        j += 1
      end
      equation = equation + "#{matrix[i][j]}".light_blue + "*X#{j+1}".green+" = "
      j += 1
      equation = equation + "#{matrix[i][j]}".yellow
      equation_system.push equation
      i += 1
   end
   equation_system

  end



  ###############################################
  #  Results display of the linear system : To refactor
  ###############################################
  def self.results_table(results)

     rows = []
     rows << ["Var", "Values"]
     rows << [" " ," "]
     count = 1
     results.each do |result|
       rows << ["X#{count}".green,"#{result.round(2)}".red]
       count +=1
     end
     table = Terminal::Table.new :title =>"Calculated solution".yellow , :rows => rows
     puts table

  end
end
