import matplotlib.pyplot as plt
import numpy as np

# Carregar os dados
data = np.loadtxt("Co-CFC.dos")
E = data[:, 0]
DOS_up = data[:, 1]
DOS_down = -data[:, 2]  # inverte para plotar simetricamente

# Plot
plt.figure(figsize=(6, 5))
plt.plot(E, DOS_up, label='Spin up', color='blue')
plt.plot(E, DOS_down, label='Spin down', color='red')
plt.axvline(x=0, color='black', linestyle='--', label='E_Fermi')
plt.xlabel("Energy (eV)")
plt.ylabel("Density of States (states/eV)")
plt.title("DOS - Co (FCC)")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
