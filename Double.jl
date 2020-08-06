using Plots

# constants

g = 1.0
dt = 0.001

m1 = 1.0
l1 = 7.0

m2 = 3.0
l2 = 5.0

function ddtheta1(theta1,theta2,dtheta1,dtheta2)
    n = -3*(3*cos(theta1-theta2)*dtheta1*dtheta2*l1^2*m2*sin(theta1-theta2)+2*dtheta1*dtheta2*l1*l2*m2*sin(theta1-theta2)+2*g*l1*m1*sin(theta1)+4*g*l1*m2*sin(theta1)-3*cos(theta1-theta2)*g*l1*m2*sin(theta2))
    d = (4*l1^2*m1-9*cos(theta1-theta2)^2*l1^2*m2+12*l2^2*m2)
    return n/d
end

function ddtheta2(theta1,theta2,dtheta1,dtheta2)
    n = 3*(2*dtheta1*dtheta2*l1^3*m1*sin(theta1-theta2)+3*cos(theta1-theta2)*dtheta1*dtheta2*l1^2*l2*m2*sin(theta1-theta2)+6*dtheta1*dtheta2*l1*l2^2*m2*sin(theta1-theta2)+3*cos(theta1-theta2)*g*l1^2*m1*sin(theta1)+6*cos(theta1-theta2)*g*l1^2*m2*sin(theta1)-2*g*l1^2*m1*sin(theta2)-6*g*l2^2*m2*sin(theta2))
    d = l2*(2*l1^2*m1-3*l1*l2*m2+6*l2^2*m2)
    return n/d
end

function x1(theta1)
    return -l1*sin(theta1)
end

function y1(theta1)
    return -l1*cos(theta1)
end

function x2(theta1,theta2)
    return -(l1*sin(theta1)+l2*sin(theta2))    
end

function y2(theta1,theta2)
    return -(l1*cos(theta1)+l2*cos(theta2))    
end

function energy(theta1,theta2,dtheta1,dtheta2)
    ret = (m1*l1^2/6+m2*l1^2/2)*dtheta1^2+m2*l2^2/6*dtheta2^2+m2*l1*l2*dtheta1*dtheta2*cos(theta1-theta2)/2-(m1/2+m2)*g*l1*cos(theta1)-m2/2*g*l2*cos(theta2)
    return ret
end

theta10 = pi/6
theta20 = pi/3
dtheta10 = 0.0
dtheta20 = 0.0

e0 = energy(theta10,theta20,dtheta10,dtheta20)

# Euler

theta1e = [theta10]
theta2e = [theta20]
dtheta1e = [dtheta10]
dtheta2e = [dtheta20]

ts = [0.0]

for i in 1:5000
    
    tmp1 = theta1e[i]
    tmp2 = theta2e[i]
    tmpd1 = dtheta1e[i]
    tmpd2 = dtheta2e[i]

    push!(theta1e,tmp1+dt*tmpd1)
    push!(theta2e,tmp2+dt*tmpd2)
    push!(dtheta1e,tmpd1+dt*ddtheta1(tmp1,tmp2,tmpd1,tmpd2))
    push!(dtheta2e,tmpd2+dt*ddtheta2(tmp1,tmp2,tmpd1,tmpd2))
    tmpt = ts[i] + dt
    push!(ts,tmpt)
end

plot(ts,[theta1e,theta2e],title="Double pendulum Euler, theta1 & theta2",label = ["theta1" "theta2"])
savefig("dpe.pdf")
plot(ts,[dtheta1e,dtheta2e],title="Double pendulum Euler, theta1_dot & theta2_dot",label = ["theta1_dot" "theta2_dot"])
savefig("dped.pdf")

# Frogleap

theta1f = [theta10]
theta2f = [theta20]
dtheta1f = [dtheta10]
dtheta2f = [dtheta20]

for i in 1:2500
    
    tmp1 = theta1f[i]
    tmp2 = theta2f[i]
    tmpd1 = dtheta1f[i]
    tmpd2 = dtheta2f[i]

    halfd1 = tmpd1 + dt*ddtheta1(tmp1,tmp2,tmpd1,tmpd2)
    halfd2 = tmpd2 + dt*ddtheta2(tmp1,tmp2,tmpd1,tmpd2)
    new1 = tmp1+2*dt*halfd1
    new2 = tmp2+2*dt*halfd2
    push!(theta1f,new1)
    push!(theta2f,new2)
    push!(dtheta1f,halfd1+ddtheta1(new1,new2,halfd1,halfd2)*dt)
    push!(dtheta2f,halfd2+ddtheta2(new1,new2,halfd1,halfd2)*dt)
end

tsprime = [(ts[2*i-1]) for i in 1:2501]
plot(tsprime,[theta1f,theta2f],title="Double pendulum Frogleap, θ1 & θ2",label = ["θ1" "θ2"])
savefig("dpf.pdf")
plot(tsprime,[theta1f,theta2f],title="Double pendulum Frogleap, θ1_dot & θ2_dot",label = ["θ1_dot" "θ2_dot"])
savefig("dpfd.pdf")

Ese = [energy(theta1e[2*i-1],theta2e[2*i-1],dtheta1e[2*i-1],dtheta2e[2*i-1])-e0 for i in 1:2501]
Esf = [energy(theta1f[i],theta2f[i],dtheta1f[i],dtheta2f[i])-e0 for i in 1:2501]

plot(tsprime,[Ese,Esf],title="energy difference",label = ["Euler" "Frogleap"])
savefig("energydp.pdf")