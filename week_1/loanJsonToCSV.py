import json
import csv
import StringIO as StringIO

loans = open('microloans.json')
loans = loans.read()
loans = json.loads(loans)
f = open('loans.txt', 'w')

header = 'name, amount, status, activity, sector, use, country, town \n'

for loan in loans["loans"]:
	header += loan["name"].replace(',', '').replace('.', '') + ', ' + str(loan["loan_amount"]) + ', ' + loan["status"] + ', ' + loan["activity"].replace(',', '').replace('.', '') + ', ' + loan["sector"] + ', ' + loan["use"].replace(',','').replace('.', '')  + ', ' + loan["location"]["country"] + loan["location"]["country"] + '\n'

f.write(header)
print header
