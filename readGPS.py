#! /usr/bin/python

from urllib import urlopen
from cPickle import load,dump
import sys

class GMdata(object):
    
    def __init__(self):
        self.Xvals = []
        self.Yvals = []
        self.data = {}
        fh = None

    def getDataFromGM(self, url= 'http://glassmap.com/server/http/getAllWifiVectors.php'):
        fh = urlopen(url)
        rawstring = fh.read()
        fh.close()
        self.__processGMdata(rawstring)

    def __processGMdata(self, rawstring):
        #skipping the useless characters....
        raw = eval(rawstring[19:-1])
        macdict = {}
        data = {}
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
        self.data = data

    def saveToPkl(self, filename = 'parsedData.pkl'):
        dump(self.data, open(filename, 'wb'))

    def getDataFromFile(self, filename = 'parsedData.pkl'):
        self.data = load(open(filename, 'rb'))
        
    def saveToTxt(self, filename = 'parsedData.txt'):
        f = open(filename, 'w')

        for key,value in self.data.iteritems():
            strlist = []
            for k in key:
                strlist.append(k + ' ')
            value.sort()
            for vmac,vstr in value:
                strlist.append(str(vmac) + ':' + vstr + ' ')
            strlist[-1] = '\n'
            f.write(''.join(strlist))
        f.close()

    def getX(self):
        if self.Xvals:
            return self.Xvals
        else:
            updateXY()
            return self.Xvals

    def getY(self):
        if self.Yvals:
            return self.Yvals
        else:
            updateXY()
            return self.Yvals


    def updateXY(self, includeTime = True, includeError = True):
        
        if dataset == 'raw':
            data = self.data
            self.fradius = -1
        else:
            data = self.filtered
        self.Yvals = []
        self.Xvals = []
        for key,value in data.iteritems():
            value.sort()

            (time, lat, lon, err) = key
            key = []
            if includeTime:
                key.append(int(time))
            key.append(float(lat))
            key.append(float(lon))
            if includeError:
                key.append(int(err))

            for val in value:
                self.Yvals.append(tuple(key))
                (mac, strength) = val
                self.Xvals.append( (mac, int(strength)) )

       



class FilteredData(GMdata):

    def __init__(self):
        GMdata.__init__()
        self.filtered = {}
        self.lat = None
        self.lon = None
        self.fradius = -1
        self.onFiltered = False

    def saveFilteredPkl(self, filename = 'FilteredData.pkl'):
        backup = self.data
        self.data = self.filtered
        GMdata.saveToPkl(filename)
        self.data = backup

    
    def saveFilteredTxt(self, filename = 'FilteredData.pkl'):
        backup = self.data
        self.data = self.filtered
        GMdata.saveToTxt(filename)
        self.data = backup

    def getUX(self):
        if not onFiltered:
            GMdata.getX()
        else:
            GMdata.updateXY()
            self.onFiltered = False
            return self.Xvals

    def getUY(self):
        if not onFiltered:
            GMdata.getY()
        else:
            GMdata.updateXY()
            self.onFiltered = False
            return self.Yvals

    def getFX(self):
        if onFiltered: 
            return self.Xvals
        else:
            backup = self.data
            self.data = self.filtered
            GMdata.updateXY()
            self.data = backup
            self.onFiltered = True
            return self.Xvals
    
    def getFY(self):
        if onFiltered: 
            return self.Yvals
        else:
            backup = self.data
            self.data = self.filtered
            GMdata.updateXY()
            self.data = backup
            self.onFiltered = True
            return self.Yvals
    


    def filterData(self, lat, lon, rad=1):
        self.filtered = {}
        self.fradius = rad
        self.lat = lat
        self.lon = lon
        for key,value in self.data.iteritems():
            (time, klat, klon, err) = key

            if lat - rad < klat < lat + rad and lon - rad < klon < lon + rad:
                self.filtered[key] = value
     
            
if __name__ == '__main__':
    toSave = GMdata()
    toSave.getDataFromGM()
    toSave.saveToPkl()
    toSave.saveToTxt()

