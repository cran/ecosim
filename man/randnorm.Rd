\name{randnorm}

\alias{randnorm}

\title{
Sample from a Univariate Normal or Lognormal Distribution
}

\description{
Samples from a univariate Normal or Lognormal distribution with parameters valid in the original units.
Just invokes a parameter transformation and calls \code{\link{rnorm}} as users often prefer to specify uncertainty in their original units rather than on the log scale as it is done in \code{\link{rlnorm}}. 
}

\usage{
randnorm(mean=0,sd=1,log=FALSE,n=1)
}

\arguments{
  \item{mean}{
Mean of the random variable.
}
  \item{sd}{
Standard deviation of the random variable.
}
  \item{log}{
Indicator whether the log of the variable should be normally distributed (log=TRUE) rather than the variable itself.
(Note: mean and sd are interpreted in original units also for log=TRUE.)
}
  \item{n}{
Sample size.
}
}

\author{
Peter Reichert <peter.reichert@eawag.ch>
}

\seealso{
\code{\link{rnorm}},
\code{\link{rlnorm}},
\code{\link{randou}}.
}

\examples{
n <- 10000

samp <- randnorm(mean=0,sd=1,n=n)
plot(1:length(samp),samp,xlab="index",ylab="y",cex=0.2)
mean(samp)
sd(samp)

samp <- randnorm(mean=2,sd=2,log=TRUE,n=n)
plot(1:length(samp),samp,ylim=c(0,25),xlab="index",ylab="y",cex=0.2)
mean(samp)
sd(samp)
}

