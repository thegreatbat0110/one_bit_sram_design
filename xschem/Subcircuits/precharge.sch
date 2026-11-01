v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1360 -910 -1230 -910 {lab=bl}
N -1190 -880 -1030 -880 {lab=precharge}
N -990 -910 -880 -910 {lab=blb}
N -1230 -850 -1230 -700 {lab=VDD}
N -1230 -700 -990 -700 {lab=VDD}
N -990 -850 -990 -700 {lab=VDD}
N -1110 -700 -1110 -670 {lab=VDD}
N -1120 -920 -1120 -880 {lab=precharge}
N -1230 -880 -1230 -850 {lab=VDD}
N -990 -880 -990 -850 {lab=VDD}
N -1120 -940 -1120 -920 {lab=precharge}
N -1270 -980 -1150 -980 {lab=bl}
N -1270 -980 -1270 -910 {lab=bl}
N -1090 -980 -950 -980 {lab=blb}
N -950 -980 -950 -910 {lab=blb}
C {sky130_fd_pr/pfet_01v8.sym} -1010 -880 2 1 {name=M1
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -1210 -880 2 0 {name=M2
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {code_shown.sym} -1740 -1280 0 0 {name=SPICE only_toplevel=true value="
.lib /home/kaavya/.ciel/ciel/sky130/versions/9233c19260cd813c3fa67dd4594fe4cc67016832/sky130A/libs.tech/ngspice/sky130.lib.spice tt
V1 VDD gnd dc 1.8
V2 precharge gnd pulse 0 1.8 0 60ps 60ps 5ns 10ns

.tran 1n 50n
.control
run
plot V(precharge)+6 V(bl)+2 V(blb)
.endc"}
C {ipin.sym} -1120 -920 0 0 {name=p3 lab=precharge}
C {iopin.sym} -1360 -910 2 0 {name=p4 lab=bl}
C {iopin.sym} -880 -910 0 0 {name=p2 lab=blb}
C {ipin.sym} -1110 -670 0 0 {name=p1 lab=VDD}
C {sky130_fd_pr/pfet_01v8.sym} -1120 -960 3 0 {name=M3
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {vdd.sym} -1120 -980 0 0 {name=l1 lab=VDD}
