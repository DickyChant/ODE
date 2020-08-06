using Plots



n = 150
t = range(0, 2π, length = n)
x = sin.(t)
y = cos.(t)

plot(x,y)
anim = @animate for i ∈ 1:n
    scatter!(x[i:i+2],y[i:i+2])
end
gif(anim, "anim_fps15.gif", fps = 15)