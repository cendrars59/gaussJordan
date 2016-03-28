# GaussJordan
module GaussJordan
  def self.calc(a)
    a.length.times do |k|
      pivot = a[k][k]
      i = k

      i.upto(a[k].length - 1) do |j|
        a[k][j] /= pivot
      end

      a.length.times do |j|
        if (j != k)
          d = a[j][k]
          l = k
          l.upto(a[k].length - 1) do |m|
            a[j][m] -= d * a[k][m]
          end
        end
      end
      graph(a)
    end
    a
  end

  def self.graph(a)
    a.each do |i|
      puts i.join(' ')
    end
  end
end


a = []
a[0] = [1.0, 2.0, 3.0, 9.0]
a[1] = [2.0, 3.0, 4.0, 13.0]
a[2] = [1.0, 5.0, 7.0, 18.0]

puts a[0].class


GaussJordan.graph(a)

# 1.0 -2.0 -2.0 2.0 5.0
# 2.0 -2.0 -3.0 3.0 10.0
# -1.0 6.0 3.0 -2.0 2.0
# 1.0 4.0 0.0 -1.0 -10.0

GaussJordan.graph(GaussJordan.calc(a))

# 1.0 0.0 0.0 0.0 9.0
# 0.0 1.0 0.0 0.0 -2.0
# 0.0 0.0 1.0 0.0 15.0
# 0.0 0.0 0.0 1.0 11.0
