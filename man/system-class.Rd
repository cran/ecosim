\name{system-class}

\Rdversion{1.1}
\docType{class}

\alias{system-class}

\title{Class \code{"system"}}

\description{
The class represents a system consisting of linked reactors, substances/organisms in the reactors and transformation processes.
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("system", ...)}.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Character string specifying the name of the system.}
    \item{\code{reactors}:}{List of reactors that build the system.}
    \item{\code{links}:}{List of links that connect the reactors.}
    \item{\code{cond}:}{List of expressions that specify global environmental conditions to which all reactrs are exposed.}
    \item{\code{param}:}{List of model parameters}
    \item{\code{t.out}:}{Numeric vector of points in time at which output should be calculated.}
  }
}

\section{Methods}{
  \describe{
    \item{calcres}{Calculates simulation results, see \code{\link{calcres}}}
	 }
}

\references{
Omlin, M., Reichert, P. and Forster, R., Biogeochemical model of lake Zurich: Model equations and results, Ecological Modelling 141(1-3), 77-103, 2001. \cr\cr
Reichert, P., Borchardt, D., Henze, M., Rauch, W., Shanahan, P., Somlyody, L. and Vanrolleghem, P., River Water Quality Model no. 1 (RWQM1): II. Biochemical process equations, Water Sci. Tech. 43(5), 11-30, 2001. \cr\cr
Reichert, P. and Schuwirth, N., A generic framework for deriving process stoichiometry in environmental models, Environmental Modelling & Software, 25, 1241-1251, 2010.
}

\author{
Peter Reichert <peter.reichert@eawag.ch>
}

\seealso{
\code{\link{process-class}},
\code{\link{reactor-class}},
\code{\link{link-class}},
\code{\link{calcres}},
\code{\link{plotres}}.
}

\examples{
# see
help(ecosim)
# for examples.
}

