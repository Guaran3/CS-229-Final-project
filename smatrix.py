#! /usr/bin/python

class smatrix(object):
    
    def __init__(self):
        self.width = 0
        self.height =0
        self.rows = []

    def add(self, (x,y,val)):
        while x >= self.height:
            self.rows.append([])
            self.height +=1
        if y >= width:
            self.width = y +1
        if val != 0:
            self.rows[x].append( (y,val) )

    def get(self, x, y):
        if x >= self.height or y >= self.width:
            raise BoundsError('Not within Matrix bounds')
        else:
            self.rows[x].sort()
            for yy,vals in self.rows[x]:
                if y = yy:
                    return vals
            return 0

    def getRow(self, x):
        if x >= self.height:
            raise BoundsError('Not within Matrix bounds')
        result = []
        current = self.rows[x].sort()
        counter = 0
        (y, val) = current[counter]
        for i in xrange(self.height):
            if y == i:
                result.append(val)
                counter += 1
                if counter < len(current):
                    (y,val) = current[i]
            else: 
                result.append(0)
        return result



class BoundsError(exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)

