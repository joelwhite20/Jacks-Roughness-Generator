"""
Finds to the size of the array corresponding to the indices equal to the
surface height
"""
import numpy as np
def indexfinder(y,sh):
    vec = ((y<(sh+.0001)) & (y>(sh-.0001)))
    jvec = np.where(vec == 1)[0]
    j = np.size(jvec)
    return j, jvec
