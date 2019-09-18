# frozen_string_literal: true

def root(a, b, c)
  roots = []
  d = b**2 - 4 * (a * c)
  if d > 0
    roots.push (-b + d) / (2 * a)
    roots.push (-b - d) / (2 * a)
  elsif d == 0
    roots.push -b / (2 * a)
  else
    roots = 'No roots'
  end
  { 'disc' => d.to_f, 'roots' => roots }
end

puts 'Enter the quadratic equation coefficients:'
print 'A = '
a = gets.to_f
print 'B = '
b = gets.to_f
print 'C = '
c = gets.to_f
result = root(a, b, c)
puts "Discriminant = #{result['disc']}; Roots = #{result['roots'].join(', ')}"
