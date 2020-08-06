using Plots

# constants

g = 1

m1 = 1
l1 = 7

m2 = 3
l2 = 5

function ddtheta1(theta1,theta2)
    n = -3*(g*l1*m1*sin(theta1)+2*g*l1*m2*sin(theta1)-g*l2*m2*sin(theta2))
    d = (2*l1^2*m1-3*l1*l2*m2+6*l2^2*m2)
    return n/d
end

function ddtheta2(theta1,theta2)
    n = -3*(g*l1*m1*sin(theta1)+2*g*l1*m2*sin(theta1)-g*l2*m2*sin(theta2))
    d = 2*l2*(2*l1^2*m1-3*l1*l2*m2+6*l2^2*m2)
    return n/d
end
