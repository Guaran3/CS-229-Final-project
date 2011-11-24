

import os
import random
from toRecord import rawdata
from math import sqrt

class kmeans:
    
    def __init__(self, data, clusters = 16, convergence = .001):
        self.conv = convergence
        self.numclusters = clusters
        self.data = data.rssvec
        self.clusters = random.sample(self.data, clusters)
        self.oldclusters = [[0 for i in range(100)] for j in self.clusters]
        self.used = []

    def iterate(self):
        newclusters = [[0 for i in range(100)] for j in self.clusters]
        count = [0 for j in self.clusters]
        for inpv in self.data:
            index = self.findClosest(inpv)
            newclusters[index] = addv(newclusters[index], inpv)
            count[index] += 1
            print min(count),
        self.oldclusters = self.clusters
        for i in range(len(self.clusters)):
            if count[i] is 0:
                print i
        self.clusters = map(lambda x, y: map(lambda z: z/float(y), x), newclusters, count)

    def findClosest(self, inpv):
        distances = map(lambda x: edist(inpv, x), self.clusters)
        minv = max(distances)
        minindex = 0
        for i in range(len(distances)):
            if distances[i] < minv:
                minv = distances[i]
                minindex = i
                if distances[i] is 0:
                    self.used.append(i)
        return minindex
    
    def getDelta(self):
        return max([max(map(lambda x,y: abs(x-y), vec1, vec2)) for vec1, vec2 in zip(self.clusters, self.oldclusters)])
        
    def getMeans(self):
        iteration = 1
        self.iterate()
        while self.getDelta() > self.conv:
            print 'Current Delta is: ' + str(self.getDelta())
            print 'On Iteration: ' + str(iteration)
            self.iterate()
            iteration += 1
        print 'Final Delta is: ' + str(self.getDelta())

def addv(vec1, vec2):
    return map(lambda x,y: x+y, vec1, vec2)

def edist(vec1, vec2):
    total = 0.0
    for first,second in zip(vec1,vec2):
        total = total + (first - second) **2
    return sqrt(total)
