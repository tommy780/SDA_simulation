import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import leastsq

'''
To read the normalized experimental concentration of FAM
'''
data = pd.read_csv('detection.csv')
y = np.asarray(data.iloc[:, [2]]).reshape(-1)
x_len = y.shape[0]

'''
initiate the 
[T S I J F W1 W2]
k1 k2 k3 k4 k5
'''
T0 = 50.0
S0 = 50.0
I0 = 0.0
J0 = 200.0
F0 = 0.0
W10 = 0.0
W20 = 0.0
ini = [[T0, S0, I0, J0, F0, W10, W20]]

'''
simulate process
'''
def differ(k1, k2, k3, k4, k5, ini, time):
    T = np.linspace(0, 0, time)
    S = np.linspace(0, 0, time)
    I = np.linspace(0, 0, time)
    J = np.linspace(0, 0, time)
    F = np.linspace(0, 0, time)
    W1 = np.linspace(0, 0, time)
    W2 = np.linspace(0, 0, time)

    T[0], S[0], I[0], J[0], F[0], W1[0], W2[0] = ini

    for i in range(time - 1):
        vT = -k1 * T[i] * S[i] + k2 * I[i] * J[i] + k3 * I[i] * W1[i]
        vS = -k1 * T[i] * S[i] - k4 * S[i] * J[i] - k5 * S[i] * W1[i]
        vI = k1 * T[i] * S[i] - k2 * I[i] * J[i] - k3 * I[i] * W1[i]
        vJ = -k2 * I[i] * J[i] - k4 * S[i] * J[i]
        vF = k1 * T[i] * S[i] + k4 * S[i] * J[i] + k5 * S[i] * W1[i]
        vW1 = k2 * I[i] * J[i] - k3 * I[i] * W1[i] + k4 * S[i] * J[i] - k5 * S[i] * W1[i]
        vW2 = k3 * I[i] * W1[i] + k5 * S[i] * W1[i]
        T[i + 1] = T[i] + vT
        S[i + 1] = S[i] + vS
        I[i + 1] = I[i] + vI
        J[i + 1] = J[i] + vJ
        F[i + 1] = F[i] + vF
        W1[i + 1] = W1[i] + vW1
        W2[i + 1] = W2[i] + vW2
    return F

'''
To define the error function
'''
def funcerror(p, y):
    return y - differ(p[0], p[1], p[2], p[3], p[4], ini[0], x_len)

'''
To set the initial values
'''
p0 = [1e-3, 1e-3, 1e-3, 1e-8, 1e-14]

'''
To minimize the MSE
'''
plsq = leastsq(funcerror, p0, args=(y))
print(plsq[0])

'''
To visualize the result
'''
plt.figure()
x = np.linspace(0, x_len * 2, x_len)
plt.plot(x, y, 'c*', label='experimental', color='C1', linewidth=3)
sim = differ(plsq[0][0], plsq[0][1], plsq[0][2], plsq[0][3], plsq[0][4], ini[0], x_len)
plt.plot(x, sim, label='simulative', color='C0', linewidth=3)
plt.xlabel('Time: min')
plt.ylabel('Concentration: nM')
plt.title('Kinetic simulation')
plt.legend()
plt.show()
