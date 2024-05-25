import numpy as np

def s(angle):
    return np.sin(angle)

def c(angle):
    return np.cos(angle)

def transf(theta, d, a, alpha, deg=True):
    if deg:
        theta = np.deg2rad(theta)
        alpha = np.deg2rad(alpha)

    l1 = [c(theta), -s(theta)*c(alpha), s(theta)*s(alpha), a*c(theta)]
    l2 = [s(theta), c(theta)*c(alpha), c(theta)*s(alpha), a*s(theta)]
    l3 = [0, s(alpha), c(alpha), d]
    l4 = [0, 0, 0, 1]
    
    return np.array(([l1, l2, l3, l4]))

class Link:
    def __init__(self, theta, d, a, alpha) -> None:
        self.theta = theta or 0
        self.d = d or 0
        self.a = a or 0
        self.alpha = alpha or 0
    
        self._matrix = transf(self.theta, self.d, self.a, self.alpha)

class LinkChain:
    def __init__(self, link_chain) -> None:
        self.link_chain = link_chain

    def update(self, qs):
        for i in range(len(self.link_chain)-1):
            self.link_chain[i+1] = np.matmul((self.link_chain[i], transf()))