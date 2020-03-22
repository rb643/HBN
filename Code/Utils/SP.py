import numpy as np
import math
from sys import argv
import matplotlib.pyplot as plt
import pylab as p

sp = np.loadtxt(argv[1])

col = np.arange(0,len(sp),1)

plt.plot(np.arange(0,len(sp),1),sp)
p.xlabel("Frame #")
p.ylabel("Spike Percentage (%)")
plt.savefig('QC_SP.png')
