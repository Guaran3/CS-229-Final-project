

import os
import random
from toRecord import rawdata
from math import sqrt
from multiprocessing import Array, Pool, Process, Manager

class kmeans:
    
    def __init__(self, data, clusters = 16, convergence = .001):
        self.conv = convergence
        self.data = data.rssvec
        self.clusters = (random.sample(self.data, clusters))
        self.oldclusters = ([[0 for i in range(100)] for j in self.clusters])
        self.count = ([0 for j in self.clusters])

    def iterate(self):
        self.oldclusters[:] = [[0 for i in range(100)] for j in self.clusters]
        self.count[:] = [0 for j in self.clusters]
        map(self.updatevalues, self.data)
        #for inpv in self.data:
        #    self.updatevalues(inpv)
        #    index = self.findClosest(inpv)
        #    self.oldclusters[index] = addv(self.oldclusters[index], inpv)
        #    self.count[index] += 1
        #self.pool.map(self.updatevalues, self.data)
        self.oldclusters,self.clusters = (self.clusters, 
                        (map(lambda x, y: map(lambda z: z/float(y), x), 
                         self.oldclusters, self.count)))

    def updatevalues(self, inpv):
        index = self.findClosest(inpv)
        self.oldclusters[index] = addv(self.oldclusters[index], inpv)
        self.count[index] += 1
   
    def findClosest(self, inpv):
        distances = map(lambda x: edist(inpv, x), self.clusters[:])
        minv = max(distances)
        minindex = 0
        mincount = max(self.count)
        for i in range(len(distances)):
            if distances[i] <= minv and self.count[i] <= mincount:
                minv = distances[i]
                minindex = i
                mincount = self.count[i]
        return minindex
    
    def getDelta(self):
        return (max([max(map(lambda x,y: abs(x-y), vec1, vec2)) for vec1, vec2 
                in zip(self.clusters, self.oldclusters)]))
        
    def getMeans(self):
        iteration = 1
        self.iterate()
        delta = self.getDelta()
        while delta > self.conv:
            print 'Current Delta is: ' + str(delta)
            print 'On Iteration: ' + str(iteration)
            self.iterate()
            delta = self.getDelta()
            iteration += 1
        print 'Final Delta is: ' + str(delta)

def addv(vec1, vec2):
    return map(lambda x,y: x+y, vec1, vec2)

def edist(vec1, vec2):
    total = 0.0
    for first,second in zip(vec1,vec2):
        total = total + (first - second) **2
    return sqrt(total)
