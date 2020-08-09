using Plots
Plots.scalefontsizes(0.7)


# mass, G = 1
M1 = 1.0
M2 = 5.0
M3 = 3.7

dt = 0.001
halfnt = 250000
nt = 2*halfnt

# Initial values
x10 = 1.5
y10 = 31.1
z10 = 2.3

x20 = 5.0
y20 = 3.1
z20 = 2.9

x30 = 1.0
y30 = 0.0
z30 = 0.0

vx10 = 0.0
vy10 = 0.0
vz10 = 0.0

vx20 = 0.0
vy20 = 0.0
vz20 = -0.1

vx30 = -0.1
vy30 = 0.1
vz30 = 0.0

function ax(x1,y1,z1,x2,y2,z2,x3,y3,z3,m2,m3)
    r12sq = (x1-x2)^2+(y1-y2)^2+(z1-z2)^2
    ax12 = m2/r12sq*(x2-x1)/sqrt(r12sq)
    r13sq = (x1-x3)^2+(y1-y3)^2+(z1-z3)^2
    ax13 = m3/r13sq*(x3-x1)/sqrt(r13sq)
    return ax12+ax13
end

function ay(x1,y1,z1,x2,y2,z2,x3,y3,z3,m2,m3)
    r12sq = (x1-x2)^2+(y1-y2)^2+(z1-z2)^2
    ay12 = m2/r12sq*(y2-y1)/sqrt(r12sq)
    r13sq = (x1-x3)^2+(y1-y3)^2+(z1-z3)^2
    ay13 = m3/r13sq*(y3-y1)/sqrt(r13sq)
    return ay12+ay13
end

function az(x1,y1,z1,x2,y2,z2,x3,y3,z3,m2,m3)
    r12sq = (x1-x2)^2+(y1-y2)^2+(z1-z2)^2
    az12 = m2/r12sq*(z2-z1)/sqrt(r12sq)
    r13sq = (x1-x3)^2+(y1-y3)^2+(z1-z3)^2
    az13 = m3/r13sq*(z3-z1)/sqrt(r13sq)
    return az12+az13
end

function energy(x1,y1,z1,x2,y2,z2,x3,y3,z3,vx1,vy1,vz1,vx2,vy2,vz2,vx3,vy3,vz3,m1,m2,m3)
    T1 = m1/2*(vx1^2+vy1^2+vz1^2)
    T2 = m2/2*(vx2^2+vy2^2+vz2^2)
    T3 = m3/2*(vx3^2+vy3^2+vz3^2)
    r12 = sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2)
    r23 = sqrt((x3-x2)^2+(y3-y2)^2+(z3-z2)^2)
    r31 = sqrt((x1-x3)^2+(y1-y3)^2+(z1-z3)^2)
    V12 = -m1*m2/r12
    V23 = -m2*m3/r23
    V31 = -m3*m1/r31
    return (T1+T2+T3+V12+V23+V31)
end

e0 = energy(x10,y10,z10,x20,y20,z20,x30,y30,z30,vx10,vy10,vz10,vx20,vy20,vz20,vx30,vy30,vz30,M1,M2,M3)

x1e = [x10]
y1e = [y10]
z1e = [z10]

x2e = [x20]
y2e = [y20]
z2e = [z20]

x3e = [x30]
y3e = [y30]
z3e = [z30]

vx1e = [vx10]
vy1e = [vy10]
vz1e = [vz10]

vx2e = [vx20]
vy2e = [vy20]
vz2e = [vz20]

vx3e = [vx30]
vy3e = [vy30]
vz3e = [vz30]

ts = [0.0]

for i in 1:nt
    tmpx1 = x1e[i]
    tmpy1 = y1e[i]
    tmpz1 = z1e[i]
    tmpx2 = x2e[i]
    tmpy2 = y2e[i]
    tmpz2 = z2e[i]
    tmpx3 = x3e[i]
    tmpy3 = y3e[i]
    tmpz3 = z3e[i]
    tmpvx1 = vx1e[i]
    tmpvy1 = vy1e[i]
    tmpvz1 = vz1e[i]
    tmpvx2 = vx2e[i]
    tmpvy2 = vy2e[i]
    tmpvz2 = vz2e[i]
    tmpvx3 = vx3e[i]
    tmpvy3 = vy3e[i]
    tmpvz3 = vz3e[i]

    push!(x1e,tmpx1+dt*tmpvx1)
    push!(y1e,tmpy1+dt*tmpvy1)
    push!(z1e,tmpz1+dt*tmpvz1)
    push!(x2e,tmpx2+dt*tmpvx2)
    push!(y2e,tmpy2+dt*tmpvy2)
    push!(z2e,tmpz2+dt*tmpvz2)
    push!(x3e,tmpx3+dt*tmpvx3)
    push!(y3e,tmpy3+dt*tmpvy3)
    push!(z3e,tmpz3+dt*tmpvz3)
    
    push!(vx1e,tmpvx1+dt*ax(tmpx1,tmpy1,tmpz1,tmpx2,tmpy2,tmpz2,tmpx3,tmpy3,tmpz3,M2,M3))
    push!(vy1e,tmpvy1+dt*ay(tmpx1,tmpy1,tmpz1,tmpx2,tmpy2,tmpz2,tmpx3,tmpy3,tmpz3,M2,M3))
    push!(vz1e,tmpvz1+dt*az(tmpx1,tmpy1,tmpz1,tmpx2,tmpy2,tmpz2,tmpx3,tmpy3,tmpz3,M2,M3))
    push!(vx2e,tmpvx2+dt*ax(tmpx2,tmpy2,tmpz2,tmpx3,tmpy3,tmpz3,tmpx1,tmpy1,tmpz1,M3,M1))
    push!(vy2e,tmpvy2+dt*ay(tmpx2,tmpy2,tmpz2,tmpx3,tmpy3,tmpz3,tmpx1,tmpy1,tmpz1,M3,M1))
    push!(vz2e,tmpvz2+dt*az(tmpx2,tmpy2,tmpz2,tmpx3,tmpy3,tmpz3,tmpx1,tmpy1,tmpz1,M3,M1))
    push!(vx3e,tmpvx3+dt*ax(tmpx3,tmpy3,tmpz3,tmpx1,tmpy1,tmpz1,tmpx2,tmpy2,tmpz2,M1,M2))
    push!(vy3e,tmpvy3+dt*ay(tmpx3,tmpy3,tmpz3,tmpx1,tmpy1,tmpz1,tmpx2,tmpy2,tmpz2,M1,M2))
    push!(vz3e,tmpvz3+dt*az(tmpx3,tmpy3,tmpz3,tmpx1,tmpy1,tmpz1,tmpx2,tmpy2,tmpz2,M1,M2))

    push!(ts,ts[i]+dt)
end

plot(ts,[x1e,x2e,x3e],label = ["x1" "x2" "x3"])
savefig("xs.pdf")
plot(ts,[y1e,y2e,y3e],label = ["y1" "y2" "y3"])
savefig("ys.pdf")
plot(ts,[z1e,z2e,z3e],label = ["z1" "z2" "z3"])
savefig("zs.pdf")

Ese = [energy(x1e[i],y1e[i],z1e[i],x2e[i],y2e[i],z2e[i],x3e[i],y3e[i],z3e[i],vx1e[i],vy1e[i],vz1e[i],vx2e[i],vy2e[i],vz2e[i],vx3e[i],vy3e[i],vz3e[i],M1,M2,M3)-e0 for i in 1:(nt+1)]
plot(ts,Ese,xlabel="time",ylabel="absolute error",title="Energy Euler")
savefig("GravityE.pdf")