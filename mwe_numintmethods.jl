using Random
using Plots
using PyFormattedStrings
using QuadGK

####################################################################
####################################################################
####################################################################

function plotintegral() #plots the funtion and domain being integrated

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)
f_str = "sin(πx/2)+sin(πy/2)"

# Create a grid of x and y values for plotting 
x = range(-1.5pi, 1.5pi, length=100)
y = range(-1.5pi, 1.5pi, length=100)

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# 2d integral with right hand rule
integral=0; #exact sol'n

# Evaluate the function on the grid
z = [f(i, j) for i in x, j in y]

# Create the contour plot
plt=contour(x, y, z, levels=20, color=:plasma, xlabel="x", ylabel="y", title=f" ∬({f_str})dydx from -π to π = {integral:0.02f}")
# ticks as multiples of pi
xticks!(plt, -pi:pi/2:pi, ["-π", "-π/2", "0", "π/2", "π"])
yticks!(plt, -pi:pi/2:pi, ["-π", "-π/2", "0", "π/2", "π"])
# add h/v lines for the integration limits
vline!(plt, [x_min, x_max], color=:black, linestyle=:dash, label="")
hline!(plt, [y_min, y_max], color=:black, linestyle=:dash, label="")
# show the plot
display(plt)

end

####################################################################
####################################################################
####################################################################


function rhrule(n) #right hand rule with n segments in the x and y directions

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)

nx=n; #number of x segments to integrate
ny=n; #number of y segments to integrate

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# Create a grid of x and y values for integration
xint = range(x_min, x_max, length=nx+1); #first point not used
yint = range(y_min, y_max, length=ny+1);

# 2d integral with right hand rule
hx=(x_max-x_min)/nx; #Calculate x spacing
hy=(y_max-y_min)/ny; #Calculate y spacing
rhr=0.0
for ix=2:nx+1
for iy=2:ny+1
rhr+= f(xint[ix],yint[iy])*hx*hy;
end
end

str=f"error using right hand rule with {n:0.0f} points is"
display(str)
display(rhr)

end


####################################################################
####################################################################
####################################################################


function lhrule(n) #left hand rule with n segments in the x and y directions

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)

nx=n; #number of x segments to integrate
ny=n; #number of y segments to integrate

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# Create a grid of x and y values for integration
xint = range(x_min, x_max, length=nx+1); 
yint = range(y_min, y_max, length=ny+1);

# 2d integral with right hand rule
hx=(x_max-x_min)/nx; #Calculate x spacing
hy=(y_max-y_min)/ny; #Calculate y spacing
lhr=0.0
for ix=1:nx
for iy=1:ny
lhr += f(xint[ix],yint[iy])*hx*hy;
end
end

str=f"error using left hand rule with {n:0.0f} points is"
display(str)
display(lhr)

end


####################################################################
####################################################################
####################################################################


function mptrule(n) #midpoint rule with n segments in the x and y directions

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)

nx=n; #number of x segments to integrate
ny=n; #number of y segments to integrate

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# Create a grid of x and y values for integration
xint = range(x_min, x_max, length=nx+1); #length is nx+1 since first point not used
yint = range(y_min, y_max, length=ny+1);

# 2d integral with right hand rule
hx=(x_max-x_min)/nx; #Calculate x spacing
hy=(y_max-y_min)/ny; #Calculate y spacing
mptr=0.0
for ix=1:nx
for iy=1:ny
mptr += f(xint[ix]+.5*hx,yint[iy]+.5hy)*hx*hy;
end
end

str=f"error using mid point rule with {n:0.0f} points is"
display(str)
display(mptr)

end


####################################################################
####################################################################
####################################################################


function traprule(n) #trap rule with n segments in the x and y directions

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)

nx=n; #number of x segments to integrate
ny=n; #number of y segments to integrate

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# Create a grid of x and y values for integration
xint = range(x_min, x_max, length=nx+1); #length is nx+1 since first point not used
yint = range(y_min, y_max, length=ny+1);

# 2d integral with right hand rule
hx=(x_max-x_min)/nx; #Calculate x spacing
hy=(y_max-y_min)/ny; #Calculate y spacing
trap=0.0
for ix=1:nx
for iy=1:ny
trap +=hx*hy*.5*(f(xint[ix],yint[iy])+f(xint[ix+1],yint[iy+1]));
end
end

str=f"error using trap rule with {n:0.0f} points is"
display(str)
display(trap)

end


####################################################################
####################################################################
####################################################################


function mcrule(n) #monte carlo toy problem with n points on test domain x,y=(-3/2pi,3/2pi) with points plotted

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)
f_str = "sin(πx/2)+sin(πy/2)"

#get vector of points
pts=3*pi*rand(Float64,(n,2)).-3/2*pi

# Create a grid of x and y values for plotting 
x = range(-1.5pi, 1.5pi, length=100)
y = range(-1.5pi, 1.5pi, length=100)

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# 2d integral with right hand rule
integral=0; #exact sol'n

# Evaluate the function on the grid
z = [f(i, j) for i in x, j in y]

# Create the contour plot
plt=contour(x, y, z, levels=20, color=:plasma, xlabel="x", ylabel="y", title=f" ∬({f_str})dydx from -π to π = {integral:0.02f}")
# ticks as multiples of pi
xticks!(plt, -pi:pi/2:pi, ["-π", "-π/2", "0", "π/2", "π"])
yticks!(plt, -pi:pi/2:pi, ["-π", "-π/2", "0", "π/2", "π"])
# add h/v lines for the integration limits

vline!(plt, [x_min, x_max], color=:black, linestyle=:dash, label="")
hline!(plt, [y_min, y_max], color=:black, linestyle=:dash, label="")

#get ratio of points in domain of integration and sum function values at in points
incnt=0
mc=0.0
for i=1:n
if pts[i,1]<=pi && pts[i,1]>=-pi && pts[i,2]<=pi && pts[i,2]>=-pi #Easy in out test
incnt+=1
mc+=f(pts[i,1],pts[i,2])
scatter!([pts[i,1]],[pts[i,2]],legend = false)
end
end


ratio=incnt/n #ratio of points in
area=ratio*9*pi^2 #area of integral
hmc=area/n #point weight

display("number of points in")
display(incnt)

display("ratio of points in")
display(ratio)

display("error of integration area")
err=abs(4*pi^2-area)
display(err)

mc*=hmc
str=f"error using monte carlo with {n:0.0f} points is"
display(str)
display(abs(mc))



display(plt)

end


####################################################################
####################################################################
####################################################################



function mcrule_noplot(n) #monte carlo toy problem with n points on test domain x,y=(-3/2pi,3/2pi) without plot for speed

# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)

#get ratio of points in domain of integration and sum function values at in points
incnt=0
mc=0.0
for i=1:n
pts=3*pi*rand(Float64,(1,2)).-3/2*pi
if pts[1,1]<=pi && pts[1,1]>=-pi && pts[1,2]<=pi && pts[1,2]>=-pi #Easy in out test
incnt+=1
mc+=f(pts[1,1],pts[1,2])
end
end

ratio=incnt/n #ratio of points in
area=ratio*9*pi^2 #area of integral
hmc=area/incnt #point weight

display("number of points in")
display(incnt)

display("ratio of point in")
display(ratio)

display("error of integration area")
err=abs(4*pi^2-area)
display(err)

mc*=hmc
str=f"error using monte carlo with {n:0.0f} points is"
display(str)
display(abs(mc))

end


####################################################################
####################################################################
####################################################################

function quadgk_numint() #original integration code from Tim


# Define the function
f(x, y) = sin(x+pi/2) + sin(y+pi/2)
f_str = "sin(πx/2)+sin(πy/2)"

# every positive version
# f(x, y) = sin(x+pi/2) + sin(y+pi/2) + 2.0001
# f_str = "sin(πx/2)+sin(πy/2)+2"

# Create a grid of x and y values
x = range(-1.5pi, 1.5pi, length=100)
y = range(-1.5pi, 1.5pi, length=100)

# Define the integration limits
x_min, x_max = -pi, pi
y_min, y_max = -pi, pi

# 2d integral
integral, _ = quadgk(x -> quadgk(y -> f(x, y), y_min, y_max)[1], x_min, x_max)

# Evaluate the function on the grid
z = [f(i, j) for i in x, j in y]

# Create the contour plot
plt=contour(x, y, z, levels=20, color=:plasma, xlabel="x", ylabel="y", title=f" ∬({f_str})dydx from -π to π = {integral:0.02f}")
# ticks as multiples of pi
xticks!(plt, -pi:pi/2:pi, ["-π", "-π/2", "0", "π/2", "π"])
yticks!(plt, -pi:pi/2:pi, ["-π", "-π/2", "0", "π/2", "π"])
# add h/v lines for the integration limits
vline!(plt, [x_min, x_max], color=:black, linestyle=:dash, label="")
hline!(plt, [y_min, y_max], color=:black, linestyle=:dash, label="")
# save the plot
#savefig(plt, "plots/2d_integration.png")
# show the plot
display(plt)

end
