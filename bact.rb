require 'rubygems'
require 'date'

started = DateTime.now

num = 1
sec=0

while sec < 10000
   num = num*2
   sec += 1
end

dec = num.size
bact = num.to_s.chars.to_a
bact.inspect

bact_number = "#{bact[0]}.#{bact[1]}E#{dec.to_s}"

#puts "Time passed: #{sec} seconds, bacterios number: #{bact_number} "

mm, ss = sec.divmod(60)            #=> [4515, 21]
hh, mm = mm.divmod(60)           #=> [75, 15]
dd, hh = hh.divmod(24)           #=> [3, 3]

puts "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]

#puts "Passed time is #{hours} hours, #{minutes} minutes and #{seconds} seconds"

#sleep(5)
hours,minutes,seconds,frac = Date.send(:day_fraction_to_time,DateTime.now-started)

#puts "Script took #{hours} hours, #{minutes} minutes and #{seconds} seconds"

puts  Time.at(Time.now.tv_sec + 3600)