
class LinearSystem

  attr_accessor :parameters, :matrix, :vector

  def initialize(parameters)
    @parameters = parameters
    @matrix = Matrix
    @vector = Vector
  end

  def equations_setting 
    i = 0
      @parameters[:equations_number].to_i.times do |equation|
        puts "Please enter parameters for the equation #{i+1}"
        j = 0
        @parameters[:var_number].to_i.times do |parameter|
          input = HighLine.new
          @matrix[i,j]= input.ask "Please give the coeff for "+ "X#{i+1}".green

          j +=1
        end
        i += 1
      end
  end

  def get_matrix_values(value,i,j)
    @matrix[i,j] = value
  end

  def get_matrix_values(value,i)
    @vector[i] = value
  end

  def check_det(matrix)
    if matrix.determinant == 0
      puts "The det is null mother fucker"
    end
  end


end
