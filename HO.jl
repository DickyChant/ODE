using Plots
using LinearAlgebra

# x + \ddots{x} == 0 -> x_n + (v_{n+1} - v_n)/dt == 0
# x_{n+1} = x_n + v_n * dt
# v_{n+1} = v_n + \ddots{x}*dt = v_n - x_n*dt
# (x,v)_(n+1) = ((1,dt),(-dt,1))(x,v)_(n), M <- ((1,dt),(-dt,1)) 

m = 1
k = 1
dt = 0.001 # the time interval

# initial condition:

x = 1.0
v = 0.0
t = 0.0

ts = [t]


xse = [x]
vse = [v]

M = [[1,dt] [-dt,1]]

xsf = [x]
vsf = [v]

for i in 1:5000
    tmp = M * [xs[i],vs[i]]
    push!(xse,tmp[1])
    push!(vse,tmp[2])
    tmpt = ts[i] + dt
    push!(ts,tmpt)
end

for i in 1:2500
    xtmp = xsf[i]
    vhalf = vsf[i] + dt*(-xtmp)
    xnew = xtmp + vhalf*2*dt
    push!(xsf,xnew)
    push!(vsf,vhalf + dt*(-xnew))
end

tsprime = [(ts[2*i-1]) for i in 1:2501]
Ese = [(xse[2*i-1]^2+vse[2*i-1]^2)-1 for i in 1:2501]
Esf = [(xsf[i]^2+vsf[i]^2)-1 for i in 1:2501]

plot(tsprime,[Ese,Esf],title="HO: relative residual of energy between simulation and truth ",label=["Euler" "Frogleap"])
savefig("energy.pdf")

