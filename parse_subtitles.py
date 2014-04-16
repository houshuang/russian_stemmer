# Given an HTML page from the lecture listing of a Coursera course (use save HTML from the browser),
# downloads and concatenates all subtitle files, and outputs them to standard output.

# example usage: python parse_subtitles.py lectures.html > coursera_subs.txt

from bs4 import BeautifulSoup
import sys
import requests

lechtml = open(sys.argv[1]).read()

soup = BeautifulSoup(lechtml)

lectures = [tag['href'] for tag in soup.findAll('a', attrs={'title': "Subtitles (text)"})]
text = ''
for l in lectures:
	text = text + requests.get(l).text

print(text)