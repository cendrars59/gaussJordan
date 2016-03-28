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
#  Vendor dependencies
###################################################################################################
require 'matrix'
require 'colorize'
require 'terminal-table'
require 'highline'

##################################################################################################
#  Lib dependencies
###################################################################################################
require_relative 'lib/linear_system'

##################################################################################################
#  Application parameters initialzation
##################################################################################################
parameters = {}
@equation_max_number = 4
@var_max_number = 4

##################################################################################################
# Methods related to gathering of the parameters to create the linear system
##################################################################################################
def value_greater_than_max?(value,max)

  value > max

end

def set_parameter(type)

  input = HighLine.new
  parameter = ""
  parameter = input.ask "Please give the number of #{type}"
  return parameter.to_i

end

def initilization_linear_system(parameters)

  parameters[:equations_number] = set_parameter("equations")
  while value_greater_than_max?(parameters[:equations_number],@equation_max_number)
    puts "You can not exceed the max value for equations, the max is #{@equation_max_number}"
    parameters[:equations_number] = set_parameter("equations")
  end

  parameters[:var_number]= set_parameter("variables")
  while value_greater_than_max?(parameters[:var_number],@var_max_number)
    puts "You can not exceed the max valur for variables, the max is #{@var_max_number}"
    parameters[:var_number]= set_parameter("variables")
  end

end

def linear_system_cannot_be_resolved?(parameters)

  parameters[:equations_number]< parameters[:var_number]

end




##################################################################################################
#
# Main application
#
##################################################################################################



initilization_linear_system(parameters)

if linear_system_cannot_be_resolved?(parameters)
  puts "System invalid"
else

  lsystem = LinearSystem.new(parameters)
  lsystem.equations_setting
  lsystem.gaussian
  lsystem.results_table

end
