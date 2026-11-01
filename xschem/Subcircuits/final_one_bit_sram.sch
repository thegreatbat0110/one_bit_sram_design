v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1070 -520 -1040 -520 {lab=write_en}
N -740 -500 -690 -500 {lab=bl}
N -690 -500 -690 -220 {lab=bl}
N -750 -220 -690 -220 {lab=bl}
N -750 -400 -690 -400 {lab=bl}
N -750 -320 -690 -320 {lab=bl}
N -750 -240 -670 -240 {lab=blb}
N -670 -520 -670 -240 {lab=blb}
N -740 -520 -670 -520 {lab=blb}
N -750 -420 -670 -420 {lab=blb}
N -750 -340 -670 -340 {lab=blb}
C {vdd.sym} -1050 -320 2 0 {name=l1 lab=VDD}
C {vdd.sym} -1050 -340 0 0 {name=l2 lab=wl}
C {vdd.sym} -750 -300 1 0 {name=l5 lab=Q}
C {vdd.sym} -750 -280 1 0 {name=l6 lab=QB}
C {vdd.sym} -1050 -220 2 0 {name=l3 lab=VDD}
C {vdd.sym} -1050 -240 0 0 {name=l4 lab=prec}
C {vdd.sym} -1050 -440 3 0 {name=l7 lab=VDD}
C {vdd.sym} -1050 -420 3 0 {name=l8 lab=read_en}
C {vdd.sym} -750 -440 1 0 {name=l9 lab=dout}
C {vdd.sym} -1040 -500 3 0 {name=l10 lab=VDD}
C {vdd.sym} -1040 -480 3 0 {name=l11 lab=din}
C {vdd.sym} -1070 -520 3 0 {name=l12 lab=write_en}
C {code_shown.sym} -170 -670 0 0 {name=spice only_toplevel=false value="
**** begin user architecture code
**change tt at end of .lib line to ss and ff
.lib /home/kaavya/.ciel/ciel/sky130/versions/9233c19260cd813c3fa67dd4594fe4cc67016832/sky130A/libs.tech/ngspice/sky130.lib.spice tt
*------------------------------------------------------------------------------
* SUPPLY, INITIAL STATE, BITLINE LOADS
*------------------------------------------------------------------------------
V1 vdd gnd dc 1.8

.ic v(Q)=1.8 v(QB)=0

Cbl  bl  gnd 100f
Cblb blb gnd 100f

*------------------------------------------------------------------------------
* PRECHARGE (active LOW)
*------------------------------------------------------------------------------
Vprec prec gnd PWL
+0n      0
+5.00n   0
+5.06n   1.8

+20.00n  1.8
+20.06n  0
+25.00n  0
+25.06n  1.8

+40.00n  1.8
+40.06n  0
+45.00n  0
+45.06n  1.8

+60.00n  1.8
+60.06n  0
+65.00n  0
+65.06n  1.8

+80.00n  1.8
+80.06n  0
+85.00n  0
+85.06n  1.8

+95.00n  1.8
+95.06n  0
+99.00n  0
+99.06n  1.8
+100n    1.8

*------------------------------------------------------------------------------
* WORDLINE
*------------------------------------------------------------------------------
Vwl wl gnd PWL
+0n        0

* Write 0
+10.12n    0
+10.18n    1.8
+16.12n    1.8
+16.18n    0

* Read 0
+50.12n    0
+50.18n    1.8
+51.00n    1.8
+51.06n    0

* Write 1
+70.12n    0
+70.18n    1.8
+76.12n    1.8
+76.18n    0

* Read 1
+90.12n    0
+90.18n    1.8
+91.00n    1.8
+91.06n    0

+100n      0

*------------------------------------------------------------------------------
* WRITE ENABLE
*------------------------------------------------------------------------------
Vwrite_en write_en gnd PWL
+0n        0

* Write 0
+10.26n    0
+10.32n    1.8
+13.26n    1.8
+13.32n    0

* Write 1
+70.26n    0
+70.32n    1.8
+73.26n    1.8
+73.32n    0

+100n      0

*------------------------------------------------------------------------------
* READ ENABLE 
*------------------------------------------------------------------------------
Vread_en read_en gnd PWL
+0n         0

* Read 0
+50.26n     0
+50.32n     1.8
+51.82n     1.8
+51.88n     0

* Read 1
+90.26n     0
+90.32n     1.8
+91.82n     1.8
+91.88n     0

+100n       0

*------------------------------------------------------------------------------
* DATA IN
*------------------------------------------------------------------------------
Vdin din gnd PWL
+0n       0
+60.00n   0
+60.06n   1.8
+100n     1.8

*------------------------------------------------------------------------------
* SIMULATION
*------------------------------------------------------------------------------
.tran 0.1p 100n
.temp 27

*==============================================================================
* 1. WRITE DELAY
*==============================================================================
.meas tran t_write0_50
+ TRIG v(wl) VAL=0.9 RISE=1 TD=9n
+ TARG v(Q)  VAL=0.9 FALL=1 TD=9n

.meas tran t_write0_10
+ TRIG v(wl) VAL=0.9 RISE=1 TD=9n
+ TARG v(Q)  VAL=0.18 FALL=1 TD=9n

.meas tran t_write1_50
+ TRIG v(wl) VAL=0.9 RISE=1 TD=69n
+ TARG v(Q)  VAL=0.9 RISE=1 TD=69n

.meas tran t_write1_90
+ TRIG v(wl) VAL=0.9 RISE=1 TD=69n
+ TARG v(Q)  VAL=1.62 RISE=1 TD=69n

*==============================================================================
* 2. FUNCTIONAL CHECKS (read checks just before read_en falls)
*==============================================================================
.meas tran q_after_write0  FIND v(Q)  AT=18n
.meas tran qb_after_write0 FIND v(QB) AT=18n

.meas tran dout_read0 FIND v(dout)   AT=51.6n
.meas tran dg_read0   FIND v(dout_g) AT=51.6n
.meas tran db_read0   FIND v(dout_b) AT=51.6n

.meas tran q_after_write1  FIND v(Q)  AT=78n
.meas tran qb_after_write1 FIND v(QB) AT=78n

.meas tran dout_read1 FIND v(dout)   AT=91.6n
.meas tran dg_read1   FIND v(dout_g) AT=91.6n
.meas tran db_read1   FIND v(dout_b) AT=91.6n

*==============================================================================
* 3. READ TIMING AND OUTPUT CHECKS
*==============================================================================
* read_en -> DOUT (READ 1)
.meas tran t_read1_50
+ TRIG v(read_en) VAL=0.9 RISE=1 TD=89n
+ TARG v(dout)    VAL=0.9 RISE=1 TD=89n

.meas tran t_read1_90
+ TRIG v(read_en) VAL=0.9 RISE=1 TD=89n
+ TARG v(dout)    VAL=1.62 RISE=1 TD=89n

* Latch resolution (separation of latch nodes reaches 0.8 V)
.meas tran t_res1
+ TRIG v(read_en) VAL=0.9 RISE=1 TD=89n
+ TARG par('v(dout_g)-v(dout_b)') VAL=0.8 RISE=1 TD=89n

.meas tran t_res0
+ TRIG v(read_en) VAL=0.9 RISE=1 TD=49n
+ TARG par('v(dout_b)-v(dout_g)') VAL=0.8 RISE=1 TD=49n

* Glitch robustness: DOUT must stay low in READ 0 and high in READ 1
.meas tran dout_max_read0 MAX v(dout) FROM=50.3n TO=51.8n
.meas tran dout_min_read1 MIN v(dout) FROM=91.0n TO=91.8n

*==============================================================================
* 4. READ DISTURB
*==============================================================================
.meas tran q_before_read0 AVG v(Q)
+ FROM=49n TO=50n
.meas tran q_read0_max MAX v(Q)
+ FROM=50.18n TO=51.06n
.meas tran read0_disturb
+ PARAM='q_read0_max-q_before_read0'
* Lowest point of the READ 0 winner node (must stay above the inverter trip point)
.meas tran db_min_read0 MIN v(dout_b) FROM=50.3n TO=51.8n
.meas tran qb_before_read1 AVG v(QB)
+ FROM=89n TO=90n
.meas tran qb_read1_max MAX v(QB)
+ FROM=90.18n TO=91.06n
.meas tran read1_disturb
+ PARAM='qb_read1_max-qb_before_read1'

*==============================================================================
* 5. BITLINE DIFFERENTIAL (sae = at sense enable, wlf = at WL fall)
*==============================================================================
.meas tran bl_sae0  FIND v(bl)  AT=50.32n
.meas tran blb_sae0 FIND v(blb) AT=50.32n
.meas tran dbl_sae0 PARAM='abs(bl_sae0-blb_sae0)'

.meas tran bl_wlf0  FIND v(bl)  AT=51.06n
.meas tran blb_wlf0 FIND v(blb) AT=51.06n
.meas tran dbl_wlf0 PARAM='abs(bl_wlf0-blb_wlf0)'

.meas tran bl_sae1  FIND v(bl)  AT=90.32n
.meas tran blb_sae1 FIND v(blb) AT=90.32n
.meas tran dbl_sae1 PARAM='abs(bl_sae1-blb_sae1)'

.meas tran bl_wlf1  FIND v(bl)  AT=91.06n
.meas tran blb_wlf1 FIND v(blb) AT=91.06n
.meas tran dbl_wlf1 PARAM='abs(bl_wlf1-blb_wlf1)'

*==============================================================================
* 6. ENERGY PER CYCLE (INCLUDING FOLLOWING PRECHARGE)
* i(V1) is negative when the supply delivers current. If energies come out
* negative, remove the minus sign.
*==============================================================================
.meas tran q_w0 INTEG i(V1) FROM=10n TO=30n
.meas tran e_write0 PARAM='-1.8*q_w0'

.meas tran q_r0 INTEG i(V1) FROM=50n TO=68n
.meas tran e_read0 PARAM='-1.8*q_r0'

.meas tran q_w1 INTEG i(V1) FROM=70n TO=88n
.meas tran e_write1 PARAM='-1.8*q_w1'

.meas tran q_r1 INTEG i(V1) FROM=90n TO=100n
.meas tran e_read1 PARAM='-1.8*q_r1'

*==============================================================================
* 7. HOLD CHECK
*==============================================================================
.meas tran q_hold0_avg  AVG v(Q)  FROM=30n TO=39n
.meas tran qb_hold0_avg AVG v(QB) FROM=30n TO=39n
.meas tran q_hold1_avg  AVG v(Q)  FROM=87n TO=89n
.meas tran qb_hold1_avg AVG v(QB) FROM=87n TO=89n

*==============================================================================
* SAVE / CONTROL
*==============================================================================
.save all

.control
run
*remove run - batch mode will not work - run only for plotting the waveforms
plot bl+2 blb
plot prec+8 wl+6
plot write_en+4 read_en+2
plot Q+2 QB
plot dout
*plot dout_g+2 dout_b
.endc
**** end user architecture code

"}
C {precharge.sym} -900 -230 0 0 {name=x1}
C {lab_pin.sym} -690 -370 0 0 {name=p1 sig_type=std_logic lab=bl}
C {lab_pin.sym} -670 -390 2 0 {name=p2 sig_type=std_logic lab=blb}
C {write_driver.sym} -890 -500 0 0 {name=x4}
C {six_t.sym} -900 -310 0 0 {name=x3}
C {sense_amplifier.sym} -900 -420 0 0 {name=x2}
