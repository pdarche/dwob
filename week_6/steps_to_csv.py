import json  
import csv   
import sys   

infilename = sys.argv[1]  
tofilename = sys.argv[2]

infile = open(infilename, "r") 

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

