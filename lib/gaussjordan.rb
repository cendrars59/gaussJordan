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


module GaussJordan
   def self.calc(matrix)
     matrix.length.times do |k|
       pivot = matrix[k][k]
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
         temp_sys = convert_matrix_to_system(matrix)
         display_system(temp_sys)
       end
       #temp_sys = convert_matrix_to_system(matrix)
       #display_system(temp_sys)
     end
     matrix
   end

   ###############################################
   #  Convert Linear system values into equation to display : To test
   ###############################################

   def self.display_system(equation_system)

     equation_system.each do |equation|
       puts equation
     end

   end



   ###############################################
   #  Convert Linear system values into equation to display : To test
   ###############################################
   def self.convert_matrix_to_system(matrix)
     #init var
     equation_system =[]
     i = 0

     matrix.each do |line|
       #adding the equation description
       equation_label = "equation number #{i+1}"
       equation_system.push equation_label

       equation = " "
       j = 0
       while j < line.length - 2
         equation = equation + " "+"#{matrix[i][j]}".light_blue + "*X#{j+1}".green+" + "
         j += 1
       end
       equation = equation + "#{matrix[i][j]}".light_blue + "*X#{j+1}".green+" ="
       j += 1
       equation = equation + "#{matrix[i][j]}".yellow
       equation_system.push equation
       i += 1
    end
      equation_system
   end

end


# a = []
# a[0] = [1.0, 2.0, 3.0, 9.0]
# a[1] = [2.0, 3.0, 4.0, 13.0]
# a[2] = [1.0, 5.0, 7.0, 18.0]
#
# puts a[0].class
#
#
# GaussJordan.graph(a)
#
# # 1.0 -2.0 -2.0 2.0 5.0
# # 2.0 -2.0 -3.0 3.0 10.0
# # -1.0 6.0 3.0 -2.0 2.0
# # 1.0 4.0 0.0 -1.0 -10.0
#
# GaussJordan.graph(GaussJordan.calc(a))
#
# # 1.0 0.0 0.0 0.0 9.0
# # 0.0 1.0 0.0 0.0 -2.0
# # 0.0 0.0 1.0 0.0 15.0
# # 0.0 0.0 0.0 1.0 11.0
