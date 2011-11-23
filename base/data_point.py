import os

class data_point:
    
    def __init__(self, input_text):
        raw = input_text.split()
        self.location = int(raw.pop(0))
        self.rss_vectors = dict([tuple(map(int, vectors.split(':'))) for vectors in raw])

    def get_rss(self, idnum):
        return self.rss_vectors.get(idnum, -100)

