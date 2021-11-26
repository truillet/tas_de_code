#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# installation
#	sudo apt install flac
#	sudo pip3 install pyaudio
#	sudo pip3 install SpeechRecognition
# 	sudo pip3 install ivy-python

from ivy.ivy import IvyServer
import speech_recognition as sr

class SRAgent(IvyServer):
	def __init__(self, name):
		IvyServer.__init__(self,'SRAgent')
		self.name = name
		self.start('127.255.255.255:2010')
		self.bind_msg(self.handle_cmd, '^sragent (.*)')
		self.r = sr.Recognizer()

	def handle_cmd(self, agent, arg):
		print ("[Agent %s] GOT CMD from %r" %(self.name, agent))
		# self.send_msg('sragent Event=Nothing_To_Do')

a= SRAgent("SRagent");
try:
	with sr.Microphone() as source:
		a.r.adjust_for_ambient_noise(source) # calibrate once
		while(True):
			print("You can speak now: ")
			audio = a.r.listen(source)
			try:
				a.send_msg("sragent Text=" + a.r.recognize_google(audio)) # show_all=True
			except sr.UnknownValueError:
				a.send_msg("sragent Event=Speech_Rejected")
			except sr.RequestError as e:
				a.send_msg("sragent Info=Error")

except KeyboardInterrupt:
    pass
