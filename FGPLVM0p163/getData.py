#! /usr/bin/python

from urllib import urlopen
import pprint
import sys
from cPickle import load,dump

f = urlopen('http://glassmap.com/server/http/getAllWifiVectors.php')
rawstring = f.read()
f.close()

raw = eval(rawstring[19:-1])

data = {}
for entry in raw:
    key = (entry['unixtimestamp'], entry['latitude'], entry['longitude'], entry['errorradius'])
    entrytuple = (entry['mac'], entry['strength'])
    if data.get(key, None) == None:
        data[key] = [entrytuple]
    else:
        data[key] += [entrytuple]


#pp = pprint.PrettyPrinter()
#pp.pprint(data)
dump(data,open('parsedData.pkl', 'wb'))

f = open('parsedData.txt', 'w')

for key,value in data.iteritems():
    strlist = []
    for k in key:
        strlist.append(k + ' ')
    strlist.append(':: ')
    value.sort()
    for vmac,vstr in value:
        strlist.append(vmac + ':' + vstr + ' ')
    strlist.append('\n')
    f.write(''.join(strlist))

f.close()
