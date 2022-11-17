# Echo cancellation and Noise reduction from audio signal
# 1) First file
# We created echo by adding delay to the recoreded audio signal
# Then filterd using some inbuilt MATLAB function
# 2) LMS algorithm
# used LMS algorithm of adaptive filtering method
# LMS Algorithm :-

LMS algorithm was developed by Widrow and Hoff in 1959.It is widely used in various applications of adaptive filtering.The mail features that attracted the use of the LMS algorithm are low computational complexity, proof of convergence in stationary environments and stable behavior when implemented with finite precision arithmetic.

 
A path that changes the signal x is called h. Transfer function of this filter is not known in the beginning. The task of LMS algorithm is to estimate the transfer function of the filter.The result of the signal distortion is calculated by convolution and is denoted by d. In this case d is the echo and h is the transfer function of the hybrid. The adaptive algorithm tries to create a filter w. The transfer function in turn is used for calculating an estimate of the echo. The echo estimate is denoted by y.
The signals are added so that the output signal from the algorithm is
e=d-y
where e denotes the error signal.
The error signal and the input signal x are used for the estimation of the filter coefficient vector w. One of the main problems associated with choosing filter weight is that the path h is not stationary. Therefore, the filter weights must be updated frequently so that the
adjustment to the variations can be performed. The filter is a FIR filter with the form

W=   W0(n)+W1(n)Z-1+….+WN-1(n)Z-(N-1)      

The LMS algorithm is a type of adaptive filter known as stochastic gradient based algorithm as it utilizes the gradient vector of the filter tap weights to converge on the optimal weiner solution.
With each iteration of the LMS algorithm , the filter tap weights of the adaptive filter are updated according to the following formula
W(n+1)=w(n)+2µe(n)x(n)
Here x(n) is the input vector of time delayed input values, x(n) = [x(n) x(n-1) x(n-2) …..x(n-N+1)T .The
vector w(n) = [w0(n) w1(n) w2(n) .. wN-1(n)] T represents the coefficients of the adaptive FIR filter tap weight vector at time n. The parameter µ is known as the step size parameter and is a small positive constant. This step size parameter controls the influence of the updating factor. Selection of a suitable value for µ is imperative to the performance of the LMS algorithm, if the value is too small the time the adaptive filter takes to converge on the optimal solution will be too long; if µ is too large the adaptive filter becomes unstable and its output diverges.

