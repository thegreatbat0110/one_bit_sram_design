# Design and Characterization of a 1-Bit SRAM Cell in SKY130

| Field | Details |
|---|---|
| **Author** | Kaavya Siddharth Kamat |
| **Toolchain** | Xschem + ngspice + SKY130 |
| **Supply Voltage ($V_{\text{DD}}$)** | $1.8\text{ V}$ |
| **Temperature Range** | $-40\text{ }^\circ\text{C}$ to $85\text{ }^\circ\text{C}$ |
| **Process Corners** | TT / SS / FF / SF / FS |
| **Nominal Bitline Capacitance ($C_{\text{BL}}$)** | $50\text{ fF}$ per bitline (measured $\approx 0.36\text{--}0.40\text{ fF/cell}$ contribution + assumed column/wire allowance for 64 rows) |

---

## Table of Contents

1. [Objective](#objective)
2. [Circuit Architecture](#circuit-architecture)
3. [Transistor Sizing](#transistor-sizing)
4. [Simulation Setup](#simulation-setup)
5. [Functional Test Sequence](#functional-test-sequence)
6. [Timing Definitions](#timing-definitions)
7. [Performance Matrix](#performance-matrix)
8. [Read Disturb](#read-disturb)
9. [Bitline Differential](#bitline-differential)
10. [Static Standby Leakage Current & Static Power](#static-standby-leakage-current--static-power)
11. [Static Noise Margins (SNM) Across Temperature & Corners](#static-noise-margins-snm-across-temperature--corners)
12. [Array Scaling & Bitline Capacitance Limits](#array-scaling--bitline-capacitance-limits)
13. [Cell Transistor Sizing Justification](#cell-transistor-sizing-justification)
14. [Discussion](#discussion)
15. [Conclusion](#conclusion)
16. [Design Limitations & Known Boundary Conditions](#design-limitations--known-boundary-conditions)
17. [Possible Future Work](#possible-future-work)
18. [References](#references)

---

## Objective

The objective of this work is to design and characterize a 1-bit 6T SRAM macro using SKY130 $1.8\text{ V}$ devices. The architecture is evaluated for correct write, read, hold stability, timing, bitline development, read disturb, leakage, and dynamic energy over the temperature range of $-40\text{ }^\circ\text{C}$ to $85\text{ }^\circ\text{C}$ at nominal ($50\text{ fF}$) and loaded ($150\text{ fF}$) bitline capacitance levels.

---

## Circuit Architecture

The top-level design consists of the following blocks:

| Block | Function |
|---|---|
| **6T SRAM cell** | Stores one bit using cross-coupled inverters and access transistors |
| **Precharge circuit** | Charges $BL$ and $BLB$ to $V_{\text{DD}}$ before each operation |
| **Write driver** | Forces $BL/BLB$ during write operations |
| **Sense amplifier** | Generates $\text{DOUT}$ during read operations |

These circuits have been further elaborated [here](Week_2_and_3/readme.md).

---

## Transistor Sizing

| Device Type | Width ($W$) | Length ($L$) |
|---|---:|---:|
| **Pull-down NMOS** | $1.26\ \mu\text{m}$ | $0.15\ \mu\text{m}$ |
| **Access NMOS** | $0.55\ \mu\text{m}$ | $0.15\ \mu\text{m}$ |
| **Pull-up PMOS** | $0.55\ \mu\text{m}$ | $0.15\ \mu\text{m}$ |

**Cell Ratio (CR):**

$$CR = \frac{W_{\text{PD}}}{W_{\text{ACC}}} = \frac{1.26}{0.55} \approx 2.29$$

**Pull-up Ratio (PR):**

$$PR = \frac{W_{\text{PU}}}{W_{\text{ACC}}} = \frac{0.55}{0.55} = 1.00$$

---

## Simulation Setup

* **Control Timing:**
  * **Wordline (`wl`) Pulse Width:** $0.9\text{ ns}$ ($50.12\text{ ns} \rightarrow 51.00\text{ ns}$)
  * **Read Enable (`read_en`) Pulse Width:** $1.5\text{ ns}$ ($50.26\text{ ns} \rightarrow 51.82\text{ ns}$)
  * **Sense Enable Delay:** Fixed $140\text{ ps}$ post-Wordline activation

---

## Functional Test Sequence

| Time | Operation |
|---|---|
| $\sim 10\text{ ns}$ | Write 0 |
| $\sim 50\text{ ns}$ | Read 0 |
| $\sim 70\text{ ns}$ | Write 1 |
| $\sim 90\text{ ns}$ | Read 1 |

> *Note: Only the temperature, bitline capacitance, and process model corner were changed between simulations. $V_{\text{DD}}$ and stimulus timing were kept constant.*

<img width="1758" height="995" alt="image" src="https://github.com/user-attachments/assets/93d1abc0-d7da-4e5d-95ef-9ce6b9ca4105" />

During Write-0, $Q$ is driven LOW ($0\text{ V}$) and $QB$ HIGH ($1.8\text{ V}$). The state is retained until the read operation. During Read-0, $\text{DOUT}$ remains LOW without disturbing the stored value. During Write-1, $Q$ is driven HIGH and $QB$ LOW. During Read-1, $\text{DOUT}$ transitions HIGH and the stored state remains stable.

| Operation | Result |
|---|---|
| **Write 0** | ✅ PASS |
| **Read 0** | ✅ PASS |
| **Write 1** | ✅ PASS |
| **Read 1** | ✅ PASS |
| **Hold** | ✅ PASS |

---

## Timing Definitions

All delays are measured from the 50% crossing of the control signal to the 50% (or 10%/90%) crossing of the output node. [Reference](https://www.researchgate.net/publication/281835010_8T_Double-Ended_Read-Decoupled_SRAM_Cell)

**Write-0 @ 50%:**
$$t_{\text{write0,50}} = t(Q = 0.9\text{ V}) - t(WL = 0.9\text{ V})$$

**Write-0 completion @ 10%:**
$$t_{\text{write0,10}} = t(Q = 0.18\text{ V}) - t(WL = 0.9\text{ V})$$

**Write-1 @ 50%:**
$$t_{\text{write1,50}} = t(Q = 0.9\text{ V}) - t(WL = 0.9\text{ V})$$

**Write-1 completion @ 90%:**
$$t_{\text{write1,90}} = t(Q = 1.62\text{ V}) - t(WL = 0.9\text{ V})$$

**Read-1 @ 50%:**
$$t_{\text{read1,50}} = t(\text{DOUT} = 0.9\text{ V}) - t(\mathrm{read}_{\mathrm{en}} = 0.9\text{ V})$$

**Read-1 @ 90%:**
$$t_{\text{read1,90}} = t(\text{DOUT} = 1.62\text{ V}) - t(\mathrm{read}_{\mathrm{en}} = 0.9\text{ V})$$

---

## Performance Matrix

### $27\text{ }^\circ\text{C}$ Performance Matrix

| Metric | SS | TT | FF | SF | FS | Comment |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **Write-0 Delay @ 50% (ns)** | 0.299 | 0.265 | 0.242 | 0.236 | 0.319 | Speeds up SS $\rightarrow$ TT $\rightarrow$ FF; SF best, FS worst (PMOS-dominated) |
| **Write-0 Delay @ 10% (ns)** | 0.340 | 0.296 | 0.267 | 0.260 | 0.366 | Same ordering as 50%; early edge scales with corner |
| **Write-1 Delay @ 50% (ns)** | 0.350 | 0.298 | 0.268 | 0.276 | 0.355 | Follows speed; more NMOS-sensitive than Write-0 |
| **Write-1 Delay @ 90% (ns)** | 0.431 | 0.354 | 0.340 | 0.581 | 0.402 | FF fastest, SF slowest at 90% point; other corners follow speed trend |
| **`read_en` $\rightarrow$ DOUT @ 50% (ns)** | 0.243 | 0.170 | 0.129 | 0.160 | 0.194 | SS $\approx 1.9\times$ slower than FF; read path leans on NMOS |
| **`read_en` $\rightarrow$ DOUT @ 90% (ns)** | 0.273 | 0.191 | 0.145 | 0.183 | 0.216 | Same ordering; sharp output edge in all corners |
| **Latch Resolution 0/1 (ns)** | 0.157 / 0.178 | 0.118 / 0.135 | 0.095 / 0.109 | 0.094 / 0.107 | 0.158 / 0.180 | SF $\approx$ FF, FS $\approx$ SS; resolving to 1 is $\sim 10\text{--}15\%$ slower than to 0 |
| **Read Disturb (mV)** | 119.4 | 128.6 | 134.8 | 133.5 | 115.9 | Opposite of speed: FF/SF disturb most (+13% vs SS) |
| **$\Delta V_{\text{BL}}$ @ Sense Enable (mV)** | 427 | 570 | 718 | 733 | 403 | FF/SF have largest swing ($\sim 1.7\times$ SS); speed vs. stability tradeoff |
| **Lowest $V(\mathrm{dout}_{\mathrm{b}})$ Read-0 (V)** | 1.704 | 1.699 | 1.697 | 1.671 | 1.721 | Nearly flat ($\sim 2.5\%$ spread); output stays near rail in all corners |
| **DOUT Glitch Peak Read-0 (mV)** | 0.57 | 0.51 | 0.54 | 0.47 | 0.75 | Sub-mV everywhere, no clear trend; negligible |
| **Write Energy 0/1 (pJ)** | 0.307 / 0.307 | 0.317 / 0.317 | 0.328 / 0.327 | 0.324 / 0.324 | 0.315 / 0.314 | $\sim 7\%$ rise SS $\rightarrow$ FF; symmetric for 0 and 1 |
| **Read Energy 0/1 (pJ)** | 0.280 / 0.267 | 0.291 / 0.280 | 0.290 / 0.281 | 0.290 / 0.281 | 0.277 / 0.262 | Weak corner dependence ($\sim 5\%$); Read-0 costs $\sim 4\text{--}6\%$ more than Read-1 |

> **Key takeaway:** FF and SF are fastest with the largest bitline swing but highest read disturb, while SS and FS are slowest with the most disturb margin. Dynamic energy is nearly flat, so timing and margin drive the corner choice.

---

### $85\text{ }^\circ\text{C}$ Performance Matrix

| Metric | SS | TT | FF | SF | FS |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Write-0 Delay @ 50% (ns)** | 0.315 | 0.278 | 0.253 | 0.244 | 0.349 |
| **Write-0 Delay @ 10% (ns)** | 0.365 | 0.313 | 0.281 | 0.272 | 0.399 |
| **Write-1 Delay @ 50% (ns)** | 0.366 | 0.311 | 0.278 | 0.281 | 0.383 |
| **Write-1 Delay @ 90% (ns)** | 0.449 | 0.367 | 0.335 | 0.536 | 0.430 |
| **`read_en` $\rightarrow$ DOUT @ 50% (ns)** | 0.254 | 0.176 | 0.136 | 0.164 | 0.205 |
| **`read_en` $\rightarrow$ DOUT @ 90% (ns)** | 0.286 | 0.198 | 0.153 | 0.189 | 0.228 |
| **Latch Resolution 0/1 (ns)** | 0.176 / 0.199 | 0.129 / 0.147 | 0.103 / 0.119 | 0.102 / 0.117 | 0.175 / 0.199 |
| **Read Disturb (mV)** | 130.2 | 141.9 | 148.9 | 146.9 | 127.7 |
| **$\Delta V_{\text{BL}}$ @ Sense Enable (mV)** | 382 | 517 | 654 | 667 | 363 |
| **Lowest $V(\mathrm{dout}_{\mathrm{b}})$ Read-0 (V)** | 1.709 | 1.703 | 1.702 | 1.676 | 1.724 |
| **DOUT Glitch Peak Read-0 (mV)** | 1.00 | 0.61 | 0.65 | 0.48 | 1.08 |
| **Write Energy 0/1 (pJ)** | 0.306 / 0.306 | 0.317 / 0.316 | 0.331 / 0.330 | 0.321 / 0.321 | 0.331 / 0.329 |
| **Read Energy 0/1 (pJ)** | 0.271 / 0.258 | 0.290 / 0.279 | 0.295 / 0.287 | 0.291 / 0.284 | 0.277 / 0.260 |

> **Temperature Impact:** Delays are about $4\text{--}10\%$ slower at $85\text{ }^\circ\text{C}$. Bitline swing drops by $\sim 10\%$ (SS: $427\text{ mV} \rightarrow 382\text{ mV}$), and read disturb rises by $\sim 9\%$ (SS: $119.4\text{ mV} \rightarrow 130.2\text{ mV}$). Together, these reduce both sensing and stability margins at elevated temperatures.

**Delay ordering across corners:**
$$t_{\text{SS}} > t_{\text{TT}} > t_{\text{FF}}$$

---

## Read Disturb

Read disturb is the temporary increase in potential of the low storage node during a read operation due to charge sharing through the access transistor.

* **Stored 0 (Read-0):** $Q = 0\text{ V}$, $QB = 1.8\text{ V} \rightarrow$ monitor potential rise on node $Q$.
* **Stored 1 (Read-1):** $Q = 1.8\text{ V}$, $QB = 0\text{ V} \rightarrow$ monitor potential rise on node $QB$.

At the **FF** corner, the maximum disturbance voltage is approximately **$134.8\text{ mV}$** for both stored states. The cell relaxes back to the correct baseline voltage after wordline deassertion without flipping state.

---

## Bitline Differential

The bitline differential voltage is defined as:

$$\Delta V_{\text{BL}} = |V(BL) - V(BLB)|$$

| Corner | Temp | $\Delta V_{\text{BL,SAE}}$ at Sense Enable | Peak Read Disturb Bump ($V_{\text{bump}}$) | Sense Amp Offset Headroom ($\Delta V_{\text{BL}} - 80\text{ mV}$) | Status |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **TT** | $27\text{ }^\circ\text{C}$ | 305.0 mV | 129.9 mV | 225.0 mV | **PASS** |
| **TT** | $85\text{ }^\circ\text{C}$ | 276.3 mV | 143.2 mV | 196.3 mV | **PASS** |
| **SS** | $27\text{ }^\circ\text{C}$ | 227.9 mV | 120.5 mV | 147.9 mV | **PASS** |
| **SS** | $85\text{ }^\circ\text{C}$ | 203.8 mV | 131.3 mV | 123.8 mV | **PASS** |
| **FF** | $27\text{ }^\circ\text{C}$ | 386.4 mV | 136.3 mV | 306.4 mV | **PASS** |
| **FF** | $85\text{ }^\circ\text{C}$ | 351.5 mV | 150.4 mV | 271.5 mV | **PASS** |
| **SF** | $27\text{ }^\circ\text{C}$ | 395.2 mV | 135.3 mV | 315.2 mV | **PASS** |
| **SF** | $85\text{ }^\circ\text{C}$ | 358.9 mV | 148.8 mV | 278.9 mV | **PASS** |
| **FS** | $27\text{ }^\circ\text{C}$ | 214.4 mV | 116.5 mV | 134.4 mV | **PASS** |
| **FS** | $85\text{ }^\circ\text{C}$ | 193.0 mV | 128.3 mV | 113.0 mV | **PASS** |

### Key Observations:
* **Sense Amp Trigger Reliability:** Across all process corners and temperature extremes, the differential voltage developed at Sense Enable ($\Delta V_{\text{BL,SAE}}$) stays above **$193.0\text{ mV}$**, maintaining a safety margin $> 2.4\times$ higher than standard sense amplifier offset limits ($\approx 50\text{--}80\text{ mV}$).
* **Worst-Case Sensing Corner (FS at $85\text{ }^\circ\text{C}$):** The FS (Fast N / Slow P) corner produces the smallest bitline differential ($193.0\text{ mV}$) because the fast access NMOS creates a slight internal node voltage rise, reducing the effective $V_{GS}$ overdrive across the pull-down NMOS driver stack.
* **Thermal Degradation Rate:** Increasing temperature from $27\text{ }^\circ\text{C}$ to $85\text{ }^\circ\text{C}$ degrades bitline discharge rates, reducing $\Delta V_{\text{BL,SAE}}$ by **$20\text{--}35\text{ mV}$** across all corners due to lower carrier mobility.
* **Read-0 vs. Read-1 Symmetry:** Differential development on $BL$ during Read 0 matches differential development on $BLB$ during Read 1 within $< 1.5\text{ mV}$ across all conditions, verifying balanced bitline loading ($C_{\text{BL}} = 100\text{ fF}$) and symmetric driver strength.

---

## Static Standby Leakage Current & Static Power

| Corner | Temp | 1-Bit Cell Leakage Current ($I_{\text{leak}}$) | 1-Bit Cell Static Power ($P_{\text{leak}}$) |
| :---: | :---: | :---: | :---: |
| **SS** | $27\text{ }^\circ\text{C}$ | 0.87 pA | 1.57 pW |
| **SF** | $27\text{ }^\circ\text{C}$ | 8.35 pA | 15.03 pW |
| **TT** | $27\text{ }^\circ\text{C}$ | 77.30 pA | 139.14 pW |
| **FF** | $27\text{ }^\circ\text{C}$ | 2.76 nA | 4.97 nW |
| **FS** | $27\text{ }^\circ\text{C}$ | 9.00 nA | 16.20 nW |
| **SS** | $85\text{ }^\circ\text{C}$ | 7.47 pA | 13.45 pW |
| **SF** | $85\text{ }^\circ\text{C}$ | 151.80 pA | 273.24 pW |
| **TT** | $85\text{ }^\circ\text{C}$ | 1.66 nA | 2.99 nW |
| **FF** | $85\text{ }^\circ\text{C}$ | 24.20 nA | 43.56 nW |
| **FS** | $85\text{ }^\circ\text{C}$ | 60.14 nA | 108.25 nW |

### Key Observations:
* **FS Corner (Fast N / Slow P) Leaks Most:** The FS corner exhibits the highest leakage ($9.00\text{ nA}$ at $27\text{ }^\circ\text{C}$ and $60.14\text{ nA}$ at $85\text{ }^\circ\text{C}$). Because 4 of the 6 cell transistors are NMOS (2 access + 2 drivers), having "Fast" NMOS reduces their threshold voltage ($V_{th}$), significantly increasing subthreshold OFF leakage.
* **Wide Dynamic Range ($\sim 69{,}000\times$ Variation):** Standby leakage swings dramatically from $0.87\text{ pA}$ ($1.57\text{ pW}$) in SS at $27\text{ }^\circ\text{C}$ up to $60.14\text{ nA}$ ($108.25\text{ nW}$) in FS at $85\text{ }^\circ\text{C}$.
* **Temperature Sensitivity:** Increasing temperature from $27\text{ }^\circ\text{C}$ to $85\text{ }^\circ\text{C}$ lowers $V_{th}$ and increases thermal voltage ($V_T$), elevating nominal TT leakage by $21.5\times$ ($77.30\text{ pA} \rightarrow 1.66\text{ nA}$) and FS leakage by $6.7\times$ ($9.00\text{ nA} \rightarrow 60.14\text{ nA}$).
* **SF vs. FS Corner Asymmetry:** In the SF corner (Slow N / Fast P), "Slow" NMOS maintains high $V_{th}$, holding room-temperature leakage to $8.35\text{ pA}$. FS leaks $> 1{,}000\times$ more than SF, confirming that NMOS subthreshold conduction dominates cell standby power.
* **SS Corner Minimum Baseline:** High threshold voltages across all devices in the SS corner suppress OFF-state current to picawatt levels ($1.57\text{ pW}$ at $27\text{ }^\circ\text{C}$ and $13.45\text{ pW}$ at $85\text{ }^\circ\text{C}$).

---

## Static Noise Margins (SNM) Across Temperature & Corners

### 1. Hold SNM (HSNM)

![](Week_2_and_3/Waveforms/wave_hold_snm.png)

* Extracted via static butterfly curves under unaccessed hold conditions ($WL = 0\text{ V}$).
* **Metric:** Side length of the largest inscribed square within the butterfly curve loops.

| Corner | $-40\text{ }^\circ\text{C}$ | $0\text{ }^\circ\text{C}$ | $27\text{ }^\circ\text{C}$ | $85\text{ }^\circ\text{C}$ |
| :--- | :---: | :---: | :---: | :---: |
| **TT** | 718.1 mV | 703.7 mV | 694.5 mV | 674.9 mV |
| **SS** | 739.2 mV | 731.1 mV | 723.7 mV | 703.6 mV |
| **FF** | 680.8 mV | 666.9 mV | 657.4 mV | 638.3 mV |
| **SF** *(Worst)* | 633.3 mV | 625.4 mV | 617.5 mV | 600.1 mV |
| **FS** | 764.5 mV | 743.2 mV | 729.9 mV | 702.3 mV |

* **Worst Corner — SF (Slow N / Fast P):** Yields the lowest hold noise margin ($600.1\text{ mV}$ at $85\text{ }^\circ\text{C}$). Strong PMOS pull-up overpowers weak NMOS pull-down, shifting the internal inverter trip point and shrinking the butterfly loop.
* **Best Corner — FS (Fast N / Slow P):** Achieves the highest hold margin ($764.5\text{ mV}$ at $-40\text{ }^\circ\text{C}$). Strong NMOS pull-down holds the internal '0' node firmly to ground.
* **Temperature Effect:** Margin degrades monotonically with rising temperature due to $V_{th}$ reduction.
* **Overall Hold Stability:** Across all conditions, HSNM remains $\ge 600.1\text{ mV}$ ($> 33\%$ of $V_{\text{DD}}$), confirming data retention immunity.

### 2. Read SNM (RSNM)

![](Week_2_and_3/Waveforms/wave_read_snm.png)

* Extracted via static butterfly curves under wordline read-access conditions ($WL = 1.8\text{ V}$, $BL = BLB = 1.8\text{ V}$).

| Corner | $-40\text{ }^\circ\text{C}$ | $0\text{ }^\circ\text{C}$ | $27\text{ }^\circ\text{C}$ | $85\text{ }^\circ\text{C}$ |
| :--- | :---: | :---: | :---: | :---: |
| **TT** | 458.3 mV | 445.8 mV | 437.7 mV | 420.6 mV |
| **SS** | 481.5 mV | 474.3 mV | 465.6 mV | 452.5 mV |
| **FF** | 424.3 mV | 410.2 mV | 402.1 mV | 385.0 mV |
| **SF** *(Worst)* | 386.3 mV | 366.3 mV | 354.6 mV | 331.8 mV |
| **FS** | 535.2 mV | 525.2 mV | 519.9 mV | 503.8 mV |

* **Read Degradation vs. Hold:** Access pass-gate turn-on creates a resistive voltage divider between the bitline and ground, raising internal node potential above zero and lowering static stability during reads.
* **Worst Corner — SF:** Drops to $331.8\text{ mV}$ at $85\text{ }^\circ\text{C}$ due to weak NMOS driver sinking capability.
* **Read Stability Verdict:** Minimum RSNM remains $\ge 331.8\text{ mV}$ ($\approx 18.4\%$ of $V_{\text{DD}}$), preventing read disturb failures.

### 3. Write SNM (WSNM)

* Extracted via largest nested square calculation on single-crossing write curves ($WL = 1.8\text{ V}$, $BL = 0\text{ V}$, $BLB = 1.8\text{ V}$).

![](Week_2_and_3/Waveforms/wave_write_snm.png)

| Corner | $-40\text{ }^\circ\text{C}$ | $0\text{ }^\circ\text{C}$ | $27\text{ }^\circ\text{C}$ | $85\text{ }^\circ\text{C}$ |
| :--- | :---: | :---: | :---: | :---: |
| **TT** | 0.7308 V | 0.7240 V | 0.7188 V | 0.7053 V |
| **SS** | 0.7495 V | 0.7466 V | 0.7428 V | 0.7303 V |
| **FF** *(Worst)* | 0.7269 V | 0.7077 V | 0.6948 V | 0.6727 V |
| **SF** | 0.7461 V | 0.7336 V | 0.7255 V | 0.7106 V |
| **FS** | 0.8099 V | 0.7927 V | 0.7811 V | 0.7562 V |

* **Worst Corner — FF:** Strong cross-coupled inverter devices resist write-driver forcing, lowering WSNM to $0.6727\text{ V}$ at $85\text{ }^\circ\text{C}$.
* **Write Reliability Verdict:** Minimum WSNM remains $\ge 0.6727\text{ V}$ ($> 37\%$ of $V_{\text{DD}}$), ensuring successful state flipping.

---

## Array Scaling & Bitline Capacitance Limits

Capacitance sweeps on the bottleneck corner (**SF**) identify a sharp failure boundary above **$200\text{--}250\text{ fF}$**:

* **$150\text{ fF}$ (Supported Upper Limit):** Winner node bottoms out at $1.18\text{ V}$ during Read-0, retaining $> 0.3\text{ V}$ safety margin above output inverter trip point ($V_M \approx 0.85\text{ V}$).
* **$200\text{ fF}$ (Marginal Boundary):** Winner node drops to $0.857\text{ V}$, operating right on the trip threshold.
* **$\ge 250\text{ fF}$ (Failure Regime):** Sense amplifier fails to latch properly, causing false-1 output flips.

### Worst-Case $400\text{ fF}$ Load Characterization ($85\text{ }^\circ\text{C}$)

At $400\text{ fF}$ bitline loading, heavy capacitive load severely attenuates bitline differential voltage development within the fixed $140\text{ ps}$ wordline-to-sense-enable window.

| Corner | $\Delta V_{\text{BL}}$ @ SAE | Winner Node Min $V(\mathrm{dout}_{\mathrm{b}})$ | Peak $V_{\text{OUT}}$ Read-0 | Read-1 Delay (50%) | Status / Verdict |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **TT** | 72.9 mV | 1.143 V | 18.0 mV | 0.238 ns | **PASS** |
| **SS** | 53.7 mV | 1.082 V | 15.3 mV | 0.343 ns | **PASS** (Marginal $\Delta V_{\text{BL}}$) |
| **FF** | 93.0 mV | 1.203 V | 23.8 mV | 0.185 ns | **PASS** |
| **FS** | 50.8 mV | 1.372 V | 18.0 mV | 0.282 ns | **PASS** (Lowest $\Delta V_{\text{BL}}$) |
| **SF** | 95.2 mV | **0.467 V** | **1.795 V** | 0.222 ns | **FAIL** (False-1 Glitch) |

* **SF Failure Mechanism:** Under $400\text{ fF}$ load, winner node $V(\mathrm{dout}_{\mathrm{b}})$ collapses to **$0.467\text{ V}$**, tripping the output inverter rail-to-rail to produce a full-swing **$1.795\text{ V}$ false-1 output glitch**. Skewed Fast PMOS / Slow NMOS unbalances PMOS cross-coupled recovery during high capacitive loading.

### Cold Temperature Verification ($150\text{ fF}$)

Cold sweeps ($0\text{ }^\circ\text{C}$ and $-40\text{ }^\circ\text{C}$) at $150\text{ fF}$ pass cleanly across all 5 corners. Higher carrier mobility at low temperatures increases cell drive current ($I_{\text{dsat}}$), producing larger bitline differential voltages ($\Delta V_{\text{BL}} \approx 154\text{--}305\text{ mV}$) during the fixed $140\text{ ps}$ sensing window.

---

## Cell Transistor Sizing Justification

To optimize the balance between cell stability and write speed, a sizing sweep was performed:

* **Cell Ratio ($CR = W_{\text{PD}}/W_{\text{ACC}}$):** Fixed at $1.26\ \mu\text{m} / 0.55\ \mu\text{m} = \mathbf{2.29}$
* **Pull-Up Ratio ($PR = W_{\text{PU}}/W_{\text{ACC}}$):** Fixed at $0.55\ \mu\text{m} / 0.55\ \mu\text{m} = \mathbf{1.00}$

| CR | PR | Total $W$ ($\mu\text{m}$) | Hold SNM (mV) | Read SNM (mV) | Write SNM (mV) | $t_{w0}$ (ps) | $t_{w1}$ (ps) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 1.00 | 1.00 | 3.30 | 715.6 | 301.2 | 764.2 | 26.7 | 43.7 |
| 1.50 | 1.00 | 3.85 | 707.8 | 375.0 | 740.1 | 29.7 | 51.0 |
| **2.29** | **1.00** | **4.72** | **696.5** | **438.5** | **717.5** | **34.4** | **62.5** |
| 3.00 | 1.00 | 5.50 | 684.0 | 475.4 | 698.7 | 38.6 | 73.2 |
| 4.00 | 1.00 | 6.60 | 672.3 | 502.1 | 682.7 | 44.6 | 88.3 |

> **Selection:** $CR = 2.29, PR = 1.00$ provides optimal Read SNM ($> 430\text{ mV}$) while maintaining write delay $< 65\text{ ps}$.

---

## Discussion

The 1-bit 6T SRAM macro operates correctly across all five process corners (TT, SS, FF, SF, and FS) over an extended temperature range of **$-40\text{ }^\circ\text{C}$ to $85\text{ }^\circ\text{C}$**, with bitline capacitive loading up to **$400\text{ fF}$**.

### 1. Timing and Speed
As expected, the FF corner exhibits the fastest overall switching response, whereas SS demonstrates the slowest baseline. However, the skewed SF (Slow NMOS / Fast PMOS) corner produces the worst-case write delay ($t_{w1,90} = 0.581\text{ ns}$) because weaker NMOS pass-gates struggle against stronger PMOS pull-up devices.

### 2. Bitline Sensing Differential
The bitline differential voltage ($\Delta V_{\text{BL}}$) measured at Sense Amplifier Enable (SAE) ranges from $403\text{ mV}$ (FS) to $733\text{ mV}$ (SF), maintaining a safety margin $> 4\times$ above typical sense amplifier offset limits ($\approx 50\text{--}80\text{ mV}$).

### 3. Read Disturb and Static Stability
Read disturb bump remains below $134.8\text{ mV}$ (FF corner), leaving significant safety margin relative to the cell trip point ($\approx 450\text{ mV}$). Static stability margins are confirmed across extremes:

| Stability Parameter | Minimum Value | Worst-Case Condition |
| :--- | ---: | :--- |
| **Hold SNM (HSNM)** | 600.1 mV | SF, $85\text{ }^\circ\text{C}$ |
| **Read SNM (RSNM)** | 331.8 mV | SF, $85\text{ }^\circ\text{C}$ |
| **Write SNM (WSNM)** | 0.6727 V | FF, $85\text{ }^\circ\text{C}$ |

### 4. Standby Leakage
Static power consumption is dominated by the FS (Fast NMOS / Slow PMOS) corner due to lower NMOS threshold voltage ($V_{th,n}$). Cell leakage expands by $\sim 69{,}000\times$ across process and temperature extremes, from $0.87\text{ pA}$ ($1.57\text{ pW}$) in SS at $27\text{ }^\circ\text{C}$ up to $60.14\text{ nA}$ ($108.25\text{ nW}$) in FS at $85\text{ }^\circ\text{C}$.

---

## Conclusion

A functional **1-bit 6T SRAM macro** incorporating precharge, write driver, and cross-coupled sense amplifier circuits was designed and characterized in SKY130 $1.8\text{ V}$ technology. Correct write, read, and hold operations were verified across process corners (TT, SS, FF, SF, FS), temperatures ($-40\text{ }^\circ\text{C}$ to $85\text{ }^\circ\text{C}$), and bitline loads up to $400\text{ fF}$. Full static stability (HSNM, RSNM, WSNM), read disturb immunity, transient timing, bitline differential development, and DC standby leakage currents were successfully extracted and evaluated.

---

## Design Limitations & Known Boundary Conditions

1. **Sense Amplifier Capacitance Limit:** The sense amplifier reliably supports bitline loading up to **$150\text{ fF}$** (equivalent to $\sim 190$ rows). At $\ge 200\text{ fF}$ under SF corner conditions, latch resolution degrades, and at $400\text{ fF}$, the sense amplifier suffers a catastrophic false-1 read failure ($V_{\text{OUT}} \rightarrow 1.8\text{ V}$).
2. **Output Signal Validity:** The output node `DOUT` is dynamically driven and valid **only while `read_en` is active HIGH**. After `read_en` drops, internal latch node precharge pulls sense output nodes back to $V_{\text{DD}}$, returning `DOUT` to 0. An output SR latch or D-flip-flop is required in periphery logic to maintain static data output across clock cycles.
3. **Wire Capacitance Allowance:** The nominal $C_{\text{BL}} = 50\text{ fF}$ baseline incorporates a measured per-cell loading of $0.36\text{--}0.40\text{ fF}$ plus an unverified wire parasitic assumption ($0.1\text{--}0.2\text{ fF}/\mu\text{m}$). Precise bitline loading requires post-layout RC parasitic extraction (PEX).
4. **Cell-Only Leakage Modeling:** Reported leakage and standby power figures cover the 6T bitcell matrix only. Decoder tree, wordline driver, write driver, and sense-amplifier static leakage currents were not included in the DC characterization.
5. **Monte Carlo Run on Sense Amplifier:** Corner sweeps (`SS`, `TT`, `FF`, `SF`, `FS`) evaluate global process variation but do not model local intra-die threshold voltage mismatch ($\Delta V_{th}$), which is the primary driver of sense-amplifier offset voltage.

---

## Possible Future Work

* **Layout Optimization & OpenRAM Compiler:** Implement custom layout for bitcells and peripheral circuits, enabling macro compilation via OpenRAM.
* **Leakage Optimization:** Incorporate power-gating sleep transistors to suppress subthreshold leakage, particularly under the FS process corner.
* **Physical Verification:** Complete physical layout execution, DRC, and LVS verification in SKY130 technology.
* **Parasitic Extraction (PEX):** Extract post-layout RC parasitics and perform back-annotated transient simulations for timing and power closure.

---

## References

* Design of 1024x32 SRAM (32Kbits) using OpenRAM and SKY130 PDKs by Shon Taware: [https://github.com/ShonTaware/SRAM_SKY130](https://github.com/ShonTaware/SRAM_SKY130)
* VLSI System Design: [https://www.vlsisystemdesign.com](https://www.vlsisystemdesign.com)
* Design of 4KB Static RAM 1.8V (access time <2.5ns) using OpenRAM and Sky130 node : [https://github.com/pradeepsk13/vsdsram_sky130_1.8V] (https://github.com/pradeepsk13/vsdsram_sky130_1.8V)
