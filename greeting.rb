def hello
  greet = ARGV.first
  ARGV.each_with_index do |arg, i|
    puts "#{greet} #{arg}" unless i == 0
  end
end

hello
