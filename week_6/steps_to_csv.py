import json  # Import the library that lets us work with JSON
import csv   # Import the library that lets us read/write CSVs
import time  # We're going to need to deal with a quick time conversion in here
import sys   # Import sys so we can get the filename args       

infilename = sys.argv[1]  
tofilename = sys.argv[2]

infile = open(infilename, "r") # Open up the file.  "r" says we want to read from it (as opposed to write)

data = infile.readlines()
data = json.loads(data[0])
data = data["activities-log-steps"]

csvwriter = csv.writer(open(tofilename, "w"))

csvwriter.writerow(["date", "steps"])

for date in data:
	value = date["value"]
	date = date["dateTime"]
	newrow = [ date, value ]

	csvwriter.writerow(newrow)

