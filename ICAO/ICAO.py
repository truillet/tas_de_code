#! /usr/bin/python
# -*- coding: utf8 -*-
#
# Exercice -  ICAO code
#

import os

def speak_ICAO(txt):
	# define dictionnary
	key = {'a':'alpha', 'b':'bravo', 'c':'charlie', 'd':'delta', 'e':'echo', 'f':'foxtrot','g':'golf', 'h':'hotel', 'i':'india', 'j':'juliett', 'k':'kilo','l':'lima','m':'mike','n':'november','o':'oscar','p': 'papa','q':'quebec','r':'romeo', 's':'sierra', 't':'tango', 'u':'uniform', 'v':'victor','w':'whiskey','x':'x-ray','y':'yankee','z':'zulu',' ':' '}
	
	txt_code = ''

	# For each letter, find its corresponding in ICAO alphabet
	for i in range(len(txt)):
		txt_code = txt_code + key[txt[i]] + ' ' 

	# os.system("espeak -ven \"" + txt_code + "\" 2>/dev/null") # use external tool under Linux
	os.system("SayStatic " + txt_code) # use external tool in windows
	return(txt_code);


# *******************************************
def main():
	texte = input('Enter a text: ').lower()
	ICAO_text = speak_ICAO(texte)
	print("ICAO text: " + ICAO_text)

if __name__ == '__main__':
	main()
