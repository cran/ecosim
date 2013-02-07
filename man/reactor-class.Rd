\name{reactor-class}

\Rdversion{1.1}
\docType{class}

\alias{reactor-class}

\title{Class \code{"reactor"}}

\description{
The class represents a well-mixed part of the system as a "reactor".
A reactor is characterized by 
its initial volume, 
a surface area available for sessile organisms or attached substances,
initial concentrations of substances/organisms in the water column and on the surface area,
input into the reactor not associated with  inflow,
inflow into the reactor
substance/organism concentrations in the inflow,
outflow out of the reactor,
environmental conditions to which the reactor is exposed, and
processes active in the reactor.
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("reactor", ...)}.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Character string specifying the name of the reactor.}
    \item{\code{volume.ini}:}{Expression specifying the initial volume of the reactor}
    \item{\code{area}:}{Expression specifying the surface area available for sessile organisms or attached substances.}
    \item{\code{conc.pervol.ini}:}{List of expressions specifying the initial concentrations of substances/organisms in the reactor.}
    \item{\code{conc.perarea.ini}:}{List of expressions specifying the initial surface density of sessile organisms or attached substances.}
    \item{\code{input}:}{List of expressions specifying the input of substances/organisms into the reactor.}
    \item{\code{inflow}:}{Expression specifying the volumetric inflow rate into the reactor.}
    \item{\code{inflow.conc}:}{List of expressions specifying the substance/organism concentrations in the inflow.}
    \item{\code{outflow}:}{Expression specifying the volumetric outflow rate of the reactor.}
    \item{\code{cond}:}{List of expressions specifying the environmental conditions to which the reactor is exposed.}
    \item{\code{processes}:}{List of processes that are active in the reactor.}
    \item{\code{a}:}{Evaluated area; for internal use only.}
  }
}

\section{Methods}{
  \describe{
    \item{calc.rates.statevar.reactor}{Calculates rates of change; internal use only.}
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

