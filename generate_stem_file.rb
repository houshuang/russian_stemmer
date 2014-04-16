# Generates a list of all Russian stems found in target text more than five times, sorted by
# inverse generalized frequency

require './russian_stemmer'

rus = Russian_Stemmer.new("russki_subs.txt")
rus.stems_by_frequency(5).each {|k, v| puts k}