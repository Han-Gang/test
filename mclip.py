import clipboard
import time
import winsound
oldtext = ""

frequency = 2500  # Set Frequency To 2500 Hertz
duration = 600  # Set Duration To 1000 ms == 1 second
while (True):
	time.sleep(0.02)

#clipboard.copy("abc")  # now the clipboard content will be string "abc"
	text = clipboard.paste()  # text will have the content of clipboard
	if text != oldtext:
		winsound.Beep(frequency, duration)
		try:
			print "============================"
			print text
		except:
			print "UnicodeEncodeError: 'gbk' codec can't encode character"
			
		
		oldtext = text

		
