\name{link-class}

\Rdversion{1.1}
\docType{class}

\alias{link-class}

\title{Class \code{"link"}}

\description{
The class represents a link between mixed reactors.
A link is characterized by
the two reactors it connects to,
the flow through the link,
advective transfer coefficients, and
diffusive exchange coefficients.
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("link", ...)}.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Character string specifying the name of the process.}
    \item{\code{from}:}{Character string specifying the name of the reactor where the link starts.}
    \item{\code{to}:}{Character string specifying the name of the reactor where the link ends.}
    \item{\code{flow}:}{Expression specifying the flow through the link.}
    \item{\code{qadv.gen}:}{Expression specifying a general advective transfer coefficient}
    \item{\code{qadv.spec}:}{List of expressions specifying substance/organism-specific advective transfer coefficients.}
    \item{\code{qdiff.gen}:}{Expression specifying a general diffusive exchange coefficient.}
    \item{\code{qdiff.spec}:}{List of expressions specifying substance/organism-specific diffusion coefficients.}
  }
}

\section{Methods}{
  \describe{
    \item{calc.rates.statevar.link}{Calculates rates of change; internal use only.}
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
\code{\link{system-class}},
\code{\link{calcres}},
\code{\link{plotres}}.
}

\examples{
# see
help(ecosim)
# for examples.
}

