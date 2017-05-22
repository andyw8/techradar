if defined? Spring
  puts "Spring causes SimpleCov to misreport, pass DISABLE_SPRING=1 to bypass"
  puts "See https://github.com/colszowka/simplecov#want-to-use-spring-with-simplecov"
  exit(1)
end

require "coveralls"

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  track_files "**/*.rb"
end
