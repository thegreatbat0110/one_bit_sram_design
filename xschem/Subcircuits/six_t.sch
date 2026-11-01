v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -280 -180 -280 -130 {lab=Q}
N -120 -180 -120 -130 {lab=QB}
N -160 -210 -160 -100 {lab=Q}
N -320 -210 -320 -100 {lab=QB}
N -280 -160 -160 -160 {lab=Q}
N -320 -140 -120 -140 {lab=QB}
N -420 -170 -280 -170 {lab=Q}
N -450 -260 -450 -210 {lab=wl}
N -10 -270 -10 -210 {lab=wl}
N -220 -300 -220 -260 {lab=wl}
N -450 -260 -10 -260 {lab=wl}
N -280 -70 -200 -70 {lab=0}
N -200 -70 -120 -70 {lab=0}
N -280 -240 -120 -240 {lab=VDD}
N -520 -250 -520 -40 {lab=bl}
N -170 -280 -170 -240 {lab=VDD}
N -520 -170 -480 -170 {lab=bl}
N 50 -250 50 -60 {lab=blb}
N -280 -240 -280 -210 {lab=VDD}
N -120 -240 -120 -210 {lab=VDD}
N -280 -100 -280 -70 {lab=0}
N -120 -100 -120 -70 {lab=0}
N -120 -170 -40 -170 {lab=QB}
N 20 -170 50 -170 {lab=blb}
C {sky130_fd_pr/nfet_01v8.sym} -140 -100 0 0 {name=M3
L=0.15
W=1.26
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -10 -190 3 1 {name=M4
L=0.15
W=0.55
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -450 -190 1 0 {name=M5
L=0.15
W=0.55
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -300 -210 0 0 {name=M6
L=0.15
W=0.55
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -140 -210 0 0 {name=M7
L=0.15
W=0.55
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {gnd.sym} -200 -70 0 0 {name=l4 lab=0}
C {gnd.sym} -450 -170 0 0 {name=l8 lab=0}
C {gnd.sym} -10 -170 0 0 {name=l9 lab=0}
C {code_shown.sym} 240 -290 0 0 {name=SPICE
only_toplevel=true
value="
.lib /home/kaavya/.ciel/ciel/sky130/versions/9233c19260cd813c3fa67dd4594fe4cc67016832/sky130A/libs.tech/ngspice/sky130.lib.spice tt

VDD VDD 0 1.8
.ic v(Q)=1.8 v(QB)=0

Vbl bl 0 0
Vblb blb 0 1.8
Vwl wl 0 PULSE(0 1.8 2n 10p 10p 3n 10n)

.tran 10p 10n
.control
run
plot v(wl)+4 v(Q)+2 v(QB)
.endc
.save all
"}
C {iopin.sym} -520 -250 0 0 {name=p4 lab=bl}
C {opin.sym} -280 -160 2 0 {name=p5 lab=Q}
C {opin.sym} -120 -140 0 0 {name=p6 lab=QB}
C {ipin.sym} -220 -300 0 0 {name=p2 lab=wl}
C {ipin.sym} -170 -280 0 0 {name=p3 lab=VDD}
C {iopin.sym} 50 -250 0 0 {name=p1 lab=blb}
C {sky130_fd_pr/nfet_01v8.sym} -300 -100 0 0 {name=M1
L=0.15
W=1.26
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
