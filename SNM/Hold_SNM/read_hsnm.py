import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from scipy.interpolate import interp1d

VDD = 1.8
CORNERS = ["tt", "ss", "ff", "sf", "fs"]
TEMPS = ["27", "85", "0", "-40"]
RESULTS_DIR = "sim_results_hsnm"


def load_wrdata(path, tol=1e-9):
    data = np.loadtxt(path)
    if data.ndim == 1:
        data = data.reshape(1, -1)

    ncols = data.shape[1]
    x = data[:, 0]

    if ncols >= 4:
        col0, col1, col2, col3 = data[:, 0], data[:, 1], data[:, 2], data[:, 3]

        pattern_A = np.allclose(col0, col1, atol=tol) and np.allclose(col1, col2, atol=tol)
        pattern_B = np.allclose(col0, col2, atol=tol) and np.allclose(col2, col3, atol=tol)

        if pattern_A and not pattern_B:
            y = col3
        elif pattern_B and not pattern_A:
            y = col1
        elif pattern_A and pattern_B:
            y = col3
        else:
            candidates = {1: col1, 2: col2, 3: col3}
            ranges = {k: np.ptp(v) for k, v in candidates.items()}
            non_dup = {k: v for k, v in ranges.items() if not np.allclose(candidates[k], col0, atol=tol)}
            best_col = max(non_dup, key=non_dup.get) if non_dup else 3
            y = candidates[best_col]
    else:
        y = data[:, 2]

    return x, y


def find_crossings(x_common, yA, yB, vdd=1.8, edge_margin=0.05):
    diff = yA - yB
    sign = np.sign(diff)
    idx = np.where(np.diff(sign) != 0)[0]
    crossings = []
    for i in idx:
        x0, x1 = x_common[i], x_common[i + 1]
        d0, d1 = diff[i], diff[i + 1]
        if d1 == d0:
            continue
        xc = x0 - d0 * (x1 - x0) / (d1 - d0)
        if xc < edge_margin or xc > (vdd - edge_margin):
            continue
        crossings.append(xc)
    return np.array(crossings)


def max_inscribed_square_side(xA, yA, xB, yB, x_lo, x_hi, n=400):
    fA = interp1d(xA, yA, bounds_error=False, fill_value=np.nan)
    fB = interp1d(xB, yB, bounds_error=False, fill_value=np.nan)

    if x_hi <= x_lo:
        return 0.0, np.nan, np.nan

    x_mid = (x_lo + x_hi) / 2
    yA_mid, yB_mid = fA(x_mid), fB(x_mid)
    if np.isnan(yA_mid) or np.isnan(yB_mid):
        probe = np.linspace(x_lo, x_hi, 5)
        yA_p, yB_p = fA(probe), fB(probe)
        valid = ~np.isnan(yA_p) & ~np.isnan(yB_p)
        if not valid.any():
            return 0.0, np.nan, np.nan
        a_above = np.nanmean(yA_p[valid] - yB_p[valid]) > 0
    else:
        a_above = yA_mid > yB_mid

    x_starts = np.linspace(x_lo, x_hi, n)
    max_side = 0.0
    best = (np.nan, np.nan)
    side_candidates = np.linspace(x_hi - x_lo, 0.001, n)

    for side in side_candidates:
        if side <= max_side:
            continue
        found = False
        for x0 in x_starts:
            x1 = x0 + side
            if x1 > x_hi:
                break
            xx = np.linspace(x0, x1, 25)
            yA_xx = fA(xx)
            yB_xx = fB(xx)
            if np.isnan(yA_xx).any() or np.isnan(yB_xx).any():
                continue
            if a_above:
                top_limit = yA_xx.min()
                bot_limit = yB_xx.max()
            else:
                top_limit = yB_xx.min()
                bot_limit = yA_xx.max()
            avail = top_limit - bot_limit
            if avail >= side:
                max_side = side
                y_center = (top_limit + bot_limit) / 2
                best = (x0 + side / 2, y_center)
                found = True
                break
        if found:
            break

    return max_side, best[0], best[1]


def process_corner_temp(corner, temp):
    file1 = os.path.join(RESULTS_DIR, f"curve_hold_1_{corner}_t{temp}.txt")
    file2 = os.path.join(RESULTS_DIR, f"curve_hold_2_{corner}_t{temp}.txt")

    if not os.path.exists(file1) or not os.path.exists(file2):
        return None, None, None

    q1, qb1 = load_wrdata(file1)
    qb2_swept, q2_measured = load_wrdata(file2)
    q2, qb2 = q2_measured, qb2_swept

    o1 = np.argsort(q1); q1, qb1 = q1[o1], qb1[o1]
    o2 = np.argsort(q2); q2, qb2 = q2[o2], qb2[o2]

    x_lo_all = max(q1.min(), q2.min())
    x_hi_all = min(q1.max(), q2.max())
    x_common = np.linspace(x_lo_all, x_hi_all, 4000)

    fA = interp1d(q1, qb1, bounds_error=False, fill_value=np.nan)
    fB = interp1d(q2, qb2, bounds_error=False, fill_value=np.nan)
    yA_c = fA(x_common)
    yB_c = fB(x_common)

    valid = ~np.isnan(yA_c) & ~np.isnan(yB_c)
    x_common, yA_c, yB_c = x_common[valid], yA_c[valid], yB_c[valid]

    crossings = find_crossings(x_common, yA_c, yB_c)
    if len(crossings) == 0:
        return None, None, None

    mid_idx = np.argmin(np.abs(crossings - (x_lo_all + x_hi_all) / 2))
    x_split = crossings[mid_idx]

    side_0, xc0, yc0 = max_inscribed_square_side(q1, qb1, q2, qb2, x_lo_all, x_split)
    side_1, xc1, yc1 = max_inscribed_square_side(q1, qb1, q2, qb2, x_split, x_hi_all)

    hsnm_worst = min(side_0, side_1) * 1000.0

    return side_0 * 1000.0, side_1 * 1000.0, hsnm_worst


def main():
    print(f"{'Corner':<8} | {'Temp (°C)':<10} | {'Lobe 0 (mV)':<12} | {'Lobe 1 (mV)':<12} | {'Worst-Case HSNM':<15}")
    print("-" * 65)

    for corner in CORNERS:
        for temp in TEMPS:
            s0, s1, worst = process_corner_temp(corner, temp)
            if worst is not None:
                print(f"{corner:<8} | {temp:<10} | {s0:<12.1f} | {s1:<12.1f} | {worst:<15.1f}")
            else:
                print(f"{corner:<8} | {temp:<10} | {'FAILED':<12} | {'FAILED':<12} | {'FAILED':<15}")


if __name__ == '__main__':
    main()
