import os
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d

CORNERS = ["tt", "ss", "ff", "sf", "fs"]
TEMPS = ["27", "85" , "0" , "-40"]
RESULTS_DIR = "sim_results_wsnm"

def calculate_wsnm_for_files(f1_path, f2_path):
    if not os.path.exists(f1_path) or not os.path.exists(f2_path):
        return None

    dc1 = np.loadtxt(f1_path)
    dc2 = np.loadtxt(f2_path)

    xr = dc1[:, 1]
    yr = dc1[:, 3]
    xb = dc2[:, 1]
    yb = dc2[:, 0]

    idx = np.argsort(xr)
    xr, yr = xr[idx], yr[idx]

    idx = np.argsort(xb)
    xb, yb = xb[idx], yb[idx]

    fred = interp1d(xr, yr, bounds_error=False, fill_value=np.nan)
    fblue = interp1d(xb, yb, bounds_error=False, fill_value=np.nan)

    xmin = max(xr.min(), xb.min())
    xmax = min(xr.max(), xb.max())

    best_side = 0.0

    for x0 in np.linspace(xmin, xmax, 4000):
        yr0 = fred(x0)
        if np.isnan(yr0):
            continue

        for side in np.linspace(0.001, 1.2, 2500):
            x1 = x0 + side
            if x1 > xmax:
                break
            yb1 = fblue(x1)
            if np.isnan(yb1):
                continue

            y_top = yr0 + side
            if abs(yb1 - y_top) < 2e-3:
                if side > best_side:
                    best_side = side

    return best_side

def main():
    print(f"{'Corner':<8} | {'Temp (°C)':<10} | {'Write SNM (V)':<15}")
    print("-" * 38)

    for corner in CORNERS:
        for temp in TEMPS:
            f1 = os.path.join(RESULTS_DIR, f"dc1_{corner}_t{temp}.txt")
            f2 = os.path.join(RESULTS_DIR, f"dc2_{corner}_t{temp}.txt")

            val = calculate_wsnm_for_files(f1, f2)
            if val is not None and val > 0:
                print(f"{corner:<8} | {temp:<10} | {val:.4f} V")
            else:
                print(f"{corner:<8} | {temp:<10} | {'FAILED':<15}")

if __name__ == '__main__':
    main()
