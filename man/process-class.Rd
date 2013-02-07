\name{process-class}

\Rdversion{1.1}
\docType{class}

\alias{process-class}

\title{Class \code{"process"}}

\description{
The class represents a transformation process of substances/organisms in the modelled system.
Such a process is characterized by a transformation rate and a list of stoichiometric coefficients for the affected substances/organisms.
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("process", ...)}.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Character string specifying the name of the process.}
    \item{\code{rate}:}{Expression characterizing the dependence of the transformation rate on substance/organism concentrations and external influence factors}
    \item{\code{stoich}:}{List of expressions or numbers defining the stoichiometric coefficient of the substance/organism given by the label of the list component.}
    \item{\code{pervol}:}{Logical variable defining the process rate as per volume of the reactor (pervol=TRUE) or per surface area (pervol=FALSE).}
  }
}

\section{Methods}{
  \describe{
    \item{calc.trans.rates}{Calculates transformation rates; internal use only.}
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
\code{\link{reactor-class}},
\code{\link{link-class}},
\code{\link{system-class}},
\code{\link{calcres}},
\code{\link{plotres}}.
}

\examples{
# see
help(ecosim)
# for examples.
}

