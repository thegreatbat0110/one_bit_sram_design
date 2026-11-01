v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -260 -390 -260 -330 {lab=dout_b}
N -300 -420 -300 -300 {lab=dout_g}
N -390 -420 -390 -300 {lab=dout_b}
N -430 -390 -430 -330 {lab=dout_g}
N -430 -470 -430 -450 {lab=VDD}
N -430 -470 -270 -470 {lab=VDD}
N -270 -470 -260 -470 {lab=VDD}
N -260 -470 -260 -450 {lab=VDD}
N -390 -380 -260 -380 {lab=dout_b}
N -430 -350 -300 -350 {lab=dout_g}
N -430 -270 -260 -270 {lab=#net1}
N -600 -330 -430 -330 {lab=dout_g}
N -600 -270 -430 -270 {lab=#net1}
N -260 -330 -150 -330 {lab=dout_b}
N -150 -330 -140 -330 {lab=dout_b}
N -260 -270 -140 -270 {lab=#net1}
N -430 -450 -430 -420 {lab=VDD}
N -260 -450 -260 -420 {lab=VDD}
N -340 -240 -340 -210 {lab=0}
N -90 -480 -90 -450 {lab=VDD}
N -610 -480 -610 -450 {lab=VDD}
N -440 -610 -310 -610 {lab=dout}
N -440 -580 -440 -550 {lab=0}
N -310 -580 -310 -550 {lab=VDD}
C {ipin.sym} -350 -470 1 0 {name=p1 lab=VDD}
C {iopin.sym} -100 -300 1 0 {name=p2 lab=bl}
C {iopin.sym} -640 -300 2 0 {name=p3 lab=blb}
C {ipin.sym} -380 -240 2 1 {name=p4 lab=read_en}
C {gnd.sym} -340 -210 0 0 {name=l4 lab=0}
C {sky130_fd_pr/pfet_01v8.sym} -410 -420 0 1 {name=M1
W=1.26
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
C {sky130_fd_pr/pfet_01v8.sym} -280 -420 0 0 {name=M2
W=1.26
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
C {sky130_fd_pr/nfet_01v8.sym} -410 -300 0 1 {name=M3
W=0.84
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -280 -300 0 0 {name=M4
W=0.84
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -120 -300 0 1 {name=M5
W=0.84
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -620 -300 0 0 {name=M7
W=0.84
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -360 -240 0 0 {name=M6
W=0.42
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {gnd.sym} -540 -390 1 0 {name=l19 lab=0}
C {gnd.sym} -430 -300 1 0 {name=l21 lab=0}
C {gnd.sym} -600 -300 3 1 {name=l22 lab=0}
C {gnd.sym} -260 -300 3 1 {name=l23 lab=0}
C {gnd.sym} -140 -300 1 0 {name=l24 lab=0}
C {capa.sym} -540 -360 2 0 {name=C1
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {opin.sym} -380 -610 3 0 {name=p5 lab=dout
}
C {capa.sym} -160 -360 2 0 {name=C2
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -160 -390 1 0 {name=l1 lab=0}
C {vdd.sym} -230 -330 0 0 {name=l2 lab=dout_b}
C {sky130_fd_pr/pfet_01v8.sym} -590 -450 0 1 {name=M10
W=1.26
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
C {sky130_fd_pr/pfet_01v8.sym} -70 -450 0 1 {name=M11
W=1.26
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
C {vdd.sym} -90 -420 1 0 {name=l7 lab=dout_b}
C {vdd.sym} -610 -420 1 0 {name=l8 lab=dout_g}
C {vdd.sym} -570 -450 1 0 {name=l9 lab=read_en}
C {vdd.sym} -50 -450 1 0 {name=l10 lab=read_en}
C {vdd.sym} -90 -480 0 0 {name=l11 lab=VDD}
C {vdd.sym} -610 -480 0 0 {name=l12 lab=VDD}
C {sky130_fd_pr/pfet_01v8.sym} -330 -580 2 1 {name=M8
W=1.26
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
C {sky130_fd_pr/nfet_01v8.sym} -460 -580 0 0 {name=M9
W=0.84
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {vdd.sym} -480 -580 3 1 {name=l13 lab=dout_b}
C {vdd.sym} -350 -580 3 0 {name=l14 lab=dout_b}
C {gnd.sym} -440 -550 0 0 {name=l15 lab=0}
C {vdd.sym} -310 -550 1 0 {name=l16 lab=VDD}
C {vdd.sym} -490 -330 0 1 {name=l17 lab=dout_g}
