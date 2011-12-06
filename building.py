#! /usr/bin/python

from urllib import urlopen
import pprint
import sys
from cPickle import load,dump

data = load(open('parsedData.pkl','rb'))
lat = 42
latup = lat+1
long = -72
longup = long+1

filtered = {}

counter = 0

for entry in data.keys():
	if float(entry[1]) > lat and float(entry[1]) < latup and float(entry[2]) < longup and float(entry[2]) > long:
		counter = counter + 1
		filtered[entry] = data[entry]
		
print counter

dump(filtered,open('filtered.pkl','wb'))

f = open('filtered.txt', 'w')

for key,value in filtered.iteritems():
    strlist = []
    for k in key:
        strlist.append(k + ' ')
    value.sort()
    for vmac,vstr in value:
        strlist.append(str(vmac) + ':' + vstr + ' ')
    strlist.append('\n')
    f.write(''.join(strlist))

f.close()