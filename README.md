# MWE-2d-numeric-integration-methods
Right hand rule, left hand rule, mid point rule, trapezoid rule, and monte carlo method for numerically integrating the MWE for 2d integration

rhrule(n) gives error using right hand rule with n segments in the x and y directions.
lhrule(n) gives error using left hand rule with n segments in the x and y directions.
mptrule(n) gives error using mid point rule with n segments in the x and y directions.
traprule(n) gives error using trapezoid rule with n segments in the x and y directions.
mcrule(n) uses monte carlo method with n points on the domain -1.5pi to 1.5pi in the x and y directions and produces plot of random points and error info
mcrule_noplot(n) is same as mcrule(n) without plots for speed
quadgk_numint() is Tim's original code for using quadgk
plotintegral() plots the integral without calculating any numeric approximation
