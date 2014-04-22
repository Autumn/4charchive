require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open(ARGV[0]))

id = doc.css("div .thread").attr("id").value

Dir.mkdir id unless File.exists? id
Dir.chdir id

posts = doc.css("div .postContainer")
files = []
posts.each do |post|
  a = post.css("div .file a")[0]
  if a != nil
    files.push a.attr("href")
  end 
end

files.each do |file|
  if not File.exists? file
    system "wget #{file.sub(/^\/\//, "")}" 
  end
end
