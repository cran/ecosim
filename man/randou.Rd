\name{randou}

\alias{randou}

\title{
Sample from an Ornstein-Uhlenbeck Process
}

\description{
Samples from an Ornstein-Uhlenbeck process and optionally exponetiates the results.
In contrast to most parameterizations, sd represents the asymptotic standard deviation rather than the coefficient in the drift term of the corresponding stochastic differential equation.
As in \code{\link{randnorm}}, mean and sd are interpreted in original, not in log-transformed units to facilitate the characterization of uncertainty in original units.
}

\usage{
randou(mean=0,sd=1,tau=0.1,y0=NA,t=0:1000/1000,log=FALSE)
}

\arguments{
  \item{mean}{
Asymptotic mean of the process.
}
  \item{sd}{
Asymptotic standard deviation of the process.
}
  \item{tau}{
Correlation time of the process.
}
  \item{y0}{
Starting value of the process. If no value is given, the starting value will be drawn randomly from the asymptotic distribution.
}
  \item{t}{
Time points at which the process should be sampled.
(Note: the value at t[1] will be the starting value y0.)
}
  \item{log}{
Indicator whether the log of the variable should be an Ornstein-Uhlenbeck process (log=TRUE) rather than the variable itself.
(Note: mean and sd are interpreted in original units also for log=TRUE.)
}
}

\author{
Peter Reichert <peter.reichert@eawag.ch>
}

\seealso{
\code{\link{randnorm}}.
}

\examples{
n <- 10000
tau <- 0.1

proc1 <- randou(mean=0,sd=1,tau=tau,y0= 0,t=0:n/n,log=FALSE)
proc2 <- randou(mean=0,sd=1,tau=tau,y0= 1,t=0:n/n,log=FALSE)
proc3 <- randou(mean=0,sd=1,tau=tau,y0=-1,t=0:n/n,log=FALSE)
plot(proc1,xlim=c(0,1),ylim=c(-2.5,2.5),xlab="t",ylab="y",type="l")
lines(proc2,col="red")
lines(proc3,col="blue")
abline(h=0)
mean(proc1$y)
mean(proc2$y)
mean(proc3$y)
sd(proc1$y)
sd(proc2$y)
sd(proc3$y)

procl1 <- randou(mean=2,sd=2,tau=tau,y0=1,t=0:n/n,log=TRUE)
procl2 <- randou(mean=2,sd=2,tau=tau,y0=2,t=0:n/n,log=TRUE)
procl3 <- randou(mean=2,sd=2,tau=tau,y0=3,t=0:n/n,log=TRUE)
plot(procl1,xlim=c(0,1),ylim=c(0,6),xlab="t",ylab="y",type="l")
lines(procl2,col="red")
lines(procl3,col="blue")
mean(procl1$y)
mean(procl2$y)
mean(procl3$y)
sd(procl1$y)
sd(procl2$y)
sd(procl3$y)
}

