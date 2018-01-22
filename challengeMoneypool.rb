#Ruby program that parses an internet xml file and check how many lines
#each character has
#Daniel Gaytan dnigaytan07@gmail.com

require 'nokogiri'
require 'open-uri'

def count_lines(speaker_hash,speeches)
	speeches.each do |speech|
		#Grabs all the lines that speech tag has itself
		lines =  speech.css("LINE")
		#sum the lines of the current speech to the speaker key value
		speaker_hash[speech.css("SPEAKER").text.to_s] = speaker_hash[speech.css("SPEAKER").text.to_s].to_i + lines.length()
	end
	return speaker_hash
end

#reads the whole xml file 
xml_file = Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"))

speaker_hash = Hash.new(0)

#grabs all the speech tags and their children
speeches = xml_file.css("SPEECH")

speaker_hash = count_lines(speaker_hash,speeches)

#print out the all keys and values of speaker_hash
speaker_hash.to_a.each do |speaker|
	puts "#{speaker[1]} => #{speaker[0]}" + "\n"
end