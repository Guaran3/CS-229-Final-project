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
macdict = {}
counter = 1
for entry in raw:
    key = (entry['unixtimestamp'], entry['latitude'], entry['longitude'], entry['errorradius'])
    if entry['mac'] not in macdict:
        macdict[entry['mac']] = counter
        counter += 1
    entrytuple = (macdict[entry['mac']], entry['strength'])
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
    value.sort()
    for vmac,vstr in value:
        strlist.append(str(vmac) + ':' + vstr + ' ')
    strlist.append('\n')
    f.write(''.join(strlist))

f.close()
