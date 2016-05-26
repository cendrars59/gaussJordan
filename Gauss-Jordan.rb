##################################################################################################
###################################################################################################
# The purposes of the application are
# - to rezolve linear system with the Gaussian elemination method
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
require 'bundler/setup'
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

###############################################
#  Method to verify if value is not greater
#  than max :passed
###############################################
def value_greater_than_max?(value,max)

  value > max

end


###############################################
#  Method to capture the entry to set parameters
#  :passed
###############################################
def set_parameter(type)

  input = HighLine.new
  parameter = ""
  parameter = input.ask "Please give the number of #{type}"
  return parameter.to_i

end

###############################################
#  Method to gather the entries to initialize
#  the system :passed
###############################################
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

###############################################
#  Method to verify if the number of var is
#  not greater than the number of equations:passed
###############################################
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
  puts ""
  puts "******************************"
  puts ""

  if lsystem.calculated_determinant != 0
  puts "Matrix determimant #{lsystem.calculated_determinant.to_r}. System can be resolved"  
  lsystem.gaussian
  else
    "Matrix determimant equal to 0. System can not be resolved"  
  end 
end
