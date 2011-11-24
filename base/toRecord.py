""" This is to turn the input files into a record format (ie a big 
    matrix so that computation is easier). We have right now 2
    different kinds of records. The first is the training data, that 
    has possible ground truth locations, and the second is test data
    that has that column missing. 
"""
import os

class rawdata:
    
    def __init__(self, isTrain = True):
        self.isTrain = isTrain
        if self.isTrain:
            self.location = []
        self.rssvec = []

    def getdata(self, inputfile):
        if(not os.path.exists(inputfile)): 
            raise AttributeError, inputfile + ' could not be found'
        fp = open(inputfile)
        raw = [[tuple(map(float, vectors.split(':'))) for vectors in line.split()] for line in fp]
        try:
            if self.isTrain:
                for vector in raw:
                    a, = vector.pop(0)
                    self.location.append(a)
            for vector in raw:
                rss = dict(vector)
                rvec = []
                for i in range(100):
                    rvec.append(rss.get(i+1,-100))
                self.rssvec.append(rvec)
        finally:
            fp.close()
