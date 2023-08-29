# ME599-Data-Driven-Dynamics
Li-Ion battery modeling using Gaussian Process Regression

Just like any regression algorithm, here you have some predictor variable x (input) and response variable y (observations), and the aim is to find a function that fits these points. There can be many functions that pass through those same set of points. <br>

Gaussian Process Regression in a way is a distribution over a function. It is a powerful tool in machine learning that allows us to make predictions about our data by incorporating prior knowledge. The key assumption being that the function output with n > 0 inputs, f = [f(x1), . . . .,f(xn)], is jointly gaussian with mean  = m(x1), . . . . , m(xn) and covariance ij = k (xi, xj),  where  is a mean function and k(. , .) is a positive definite kernel. Since this holds, then for n = m + 1,  with xm training points and one test point x*, we can infer information about f(x*) from the knowledge of f(x1), . . . , f(xm) by using the joint gaussian distribution p(f(x1), . . . , f(xm), f(x*)). <br>

Let D = {(x1, y1), . . . , (xm, ym)} = (X, y). We presume that there is some structure in our data, that means yi  f(Xi). Gaussian Process model the output as a noisy function of the inputs given by yi  = f(Xi) + ε; where ε ~ N(0, 2n).

