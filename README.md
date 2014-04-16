Project files for a small project to create an Anki deck from subtitles to a Russian Coursera course. Documented in blog post (upcoming).

Flow:
 - open page listing course videos on Coursera (for example [https://class.coursera.org/historyofec-001/lecture]()) in your browser, and save the HTML file
 - process the HTML file with `parse_subtitles.py` to generate a dump of all subtitles
 - process subtitles with `generate_stem_file.rb` to generate a list of frequent stems (occurring more than 5 times)
 - edit the file to remove words you already know well
 - copy the list of Russian words you want to learn to Google Translate. Copy the resulting list of English words into a new text file.
 - use `combine_ru_en.rb` to combine the two language files, and add example sentences, generating a file that you can import into Anki

All code here is released under Creative Commons 0/Public Domain. It's intended as an illustration to a blog post, not as a robust and well designed library, but feel free to steal anything that you might find helpful.

Stian Håklev 2014, shaklev@gmail.com, http://reganmian.net/blog