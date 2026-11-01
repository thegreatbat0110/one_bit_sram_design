v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 100 10 100 50 {lab=#net1}
N 30 -20 60 -20 {lab=din}
N 30 -20 30 80 {lab=din}
N 30 80 60 80 {lab=din}
N 400 10 400 50 {lab=#net2}
N 330 -20 360 -20 {lab=#net1}
N 330 -20 330 80 {lab=#net1}
N 330 80 360 80 {lab=#net1}
N 230 -190 290 -190 {lab=write_en}
N 260 -280 260 -190 {lab=write_en}
N -140 -280 260 -280 {lab=write_en}
N -180 -280 -140 -280 {lab=write_en}
N 100 -80 100 -50 {lab=VDD}
N 100 -50 100 -20 {lab=VDD}
N 100 110 100 130 {lab=0}
N 100 80 100 110 {lab=0}
N 400 -80 400 -50 {lab=VDD}
N 400 -50 400 -20 {lab=VDD}
N 400 80 400 140 {lab=0}
N 400 110 400 140 {lab=0}
N 100 40 330 40 {lab=#net1}
N 400 30 440 30 {lab=#net2}
N 110 -220 190 -220 {lab=#net3}
N 330 -220 400 -220 {lab=#net4}
N 40 -160 40 -140 {lab=bl}
N 140 -120 140 40 {lab=#net1}
N 190 -190 190 -160 {lab=0}
N 190 -160 190 -140 {lab=0}
N 40 -220 110 -220 {lab=#net3}
N 0 -190 40 -190 {lab=0}
N 330 -190 330 -160 {lab=0}
N 330 -160 330 -140 {lab=0}
N 460 -160 460 -140 {lab=blb}
N 420 -190 420 -160 {lab=#net2}
N 400 -220 460 -220 {lab=#net4}
N 460 -190 500 -190 {lab=0}
N 420 -160 420 -120 {lab=#net2}
N 440 30 510 30 {lab=#net2}
N 80 -190 90 -190 {lab=#net1}
N 90 -190 140 -190 {lab=#net1}
N 140 -190 140 -120 {lab=#net1}
N 420 -120 510 -120 {lab=#net2}
N 510 -120 510 30 {lab=#net2}
C {sky130_fd_pr/nfet_01v8.sym} 80 80 0 0 {name=M3
W=1
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
C {sky130_fd_pr/pfet_01v8.sym} 80 -20 0 0 {name=M4
W=1
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
C {sky130_fd_pr/nfet_01v8.sym} 380 80 0 0 {name=M5
W=1
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
C {sky130_fd_pr/pfet_01v8.sym} 380 -20 0 0 {name=M6
W=1
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
C {sky130_fd_pr/nfet_01v8.sym} 210 -190 0 1 {name=M8
W=4
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
C {sky130_fd_pr/nfet_01v8.sym} 310 -190 0 0 {name=M9
W=4
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
C {ipin.sym} 400 -80 0 0 {name=p1 lab=VDD}
C {gnd.sym} 100 130 0 0 {name=l1 lab=0}
C {gnd.sym} 400 140 0 0 {name=l3 lab=0}
C {ipin.sym} -180 -280 0 0 {name=p5 lab=write_en}
C {ipin.sym} 30 20 0 0 {name=p6 lab=din}
C {iopin.sym} 40 -140 0 0 {name=p8 lab=bl}
C {gnd.sym} 190 -140 1 0 {name=l5 lab=0}
C {vdd.sym} 100 -80 0 0 {name=l8 lab=VDD}
C {sky130_fd_pr/nfet_01v8.sym} 60 -190 2 0 {name=M7
W=4
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
C {gnd.sym} 0 -190 1 0 {name=l6 lab=0}
C {gnd.sym} 330 -140 3 0 {name=l7 lab=0}
C {sky130_fd_pr/nfet_01v8.sym} 440 -190 2 1 {name=M10
W=4
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
C {gnd.sym} 500 -190 3 0 {name=l4 lab=0}
C {iopin.sym} 460 -140 0 0 {name=p2 lab=blb}
