using Plots

# constants

g = 1.0
dt = 0.001

m1 = 1.0
l1 = 7.0

m2 = 3.0
l2 = 5.0

function ddtheta1(theta1,theta2)
    n = -3*(g*l1*m1*sin(theta1)+2*g*l1*m2*sin(theta1)-g*l2*m2*sin(theta2))
    d = (2*l1^2*m1-3*l1*l2*m2+6*l2^2*m2)
    return n/d
end

function ddtheta2(theta1,theta2)
    n = -3*(-3*g*l1^2*m1*sin(theta1)-6*g*l1^2*m2*sin(theta1)+2*g*l1^2*m1*sin(theta2)+6*g*l2^2*m2*sin(theta2))
    d = 2*l2*(2*l1^2*m1-3*l1*l2*m2+6*l2^2*m2)
    return n/d
end

theta10 = pi/6
theta20 = pi/3
dtheta10 = 0.0
dtheta20 = 0.0

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
    push!(dtheta1e,tmpd1+dt*ddtheta1(tmp1,tmp2))
    push!(dtheta2e,tmpd2+dt*ddtheta2(tmp1,tmp2))
    tmpt = ts[i] + dt
    push!(ts,tmpt)
end

plot(ts,[theta1e,theta2e],title="Double pendulum, θ1 & θ2",label = ["θ1" "θ2"])
savefig("dpe.pdf")
plot(ts,[dtheta1e,dtheta2e],title="Double pendulum, θ1_dot & θ2_dot",label = ["θ1_dot" "θ2_dot"])
savefig("dped.pdf")
