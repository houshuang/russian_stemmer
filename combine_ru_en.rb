# Combine two text files, one with a single Russian word on each line, and the other
# with a single corresponding English word on each line (for example the result of copying
# a list of Russian words into Google Translate). Also uses the word stemmer to find corresponding
# conjugations of each stem, and uses this to find example sentences from the text file.
# Generates a file suitable for Anki export with five fields: Russian, English, and max three example sentences
# (some can be empty) with the target word highlighted

require './russian_stemmer'

a = File.open("russian_filtered.txt").read
b = File.open("english_filtered.txt").read
c = File.open("russki_subs.txt").read
A = a.split("\n")
B = b.split("\n")
C = c.gsub(".\n", "||").gsub("\n", " ").split("||")

Rus = Russian_Stemmer.new("russki_subs.txt")

def get_sentences(word)
	sent = []
	Rus.wordvars[word].uniq.each do |w|
		found = C.grep(Regexp.new("#{w.strip}"))
		found.each do |f|
			sent << f.gsub(w, "<font color='red'>#{w}</font>").strip
		end
	end
	(sent.uniq + ["","",""]).flatten[0..2]
end

A.each_with_index do |word, i|
	puts "#{word.strip}\t#{B[i].strip}\t#{get_sentences(word).join("\t")}".gsub("\"", "")
end