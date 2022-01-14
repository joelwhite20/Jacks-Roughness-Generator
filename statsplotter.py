import matplotlib.pyplot as plt
import numpy as np

def plotter(Nvec,pts,pts_p,pts_uwp,pts_p_ua):

    fig, ax = plt.subplots(3,sharex = 'all')

    ypert = pts_p_ua[Nvec,1]
    Nbins = 100

    ax[0].set_title('Unadjusted')
    ax[1].set_title('Unweighted')
    ax[2].set_title('Weighted')


    for i in [0,1,2]:
        ax[i].grid()

    ax[0].hist(pts_p_ua[Nvec,1],bins = Nbins)
    ax[1].hist(pts_uwp[Nvec,1],bins = Nbins)
    ax[2].hist(pts_p[Nvec,1],bins = Nbins)

    plt.tight_layout()
    plt.show()

    plt.savefig('Histogram.png',format='png')
