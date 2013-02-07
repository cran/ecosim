\name{calcres}

\alias{calcres}

\title{
Performs a Simulation of the Model Passed as the Argument
}

\description{
Calculates a dynamic solution of the model defined by the argument and returns a numeric matrix with the volumes and substance/organism 
concentrations of all reactors and substances/organisms defined in
the model (columns) for all points in time (rows).
}

\usage{
calcres(system,method="lsoda")
}

\arguments{
  \item{system}{
Object of type \code{\link{system-class}} that defines the model.
}
  \item{method}{
Integration algorithm to be used for numerically solving the system of ordinary differential equations.
Available algorithms: 
"lsoda", 
"lsode", 
"lsodes", 
"lsodar", 
"vode", 
"daspk",
"euler", 
"rk4", 
"ode23", 
"ode45", 
"radau", 
"bdf", 
"bdf_d", 
"adams", 
"impAdams", 
"impAdams_d".
See package \link{deSolve} for more details.
}
}

\details{
See package \link{deSolve} for more details on the integration algorithms.
}

\value{
The function returns a numeric matrix with the volumes and substance/organism concentrations of all reactors and substances/organisms defined in the model (columns) for all points in time (rows)}

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
\code{\link{system-class}},
\code{\link{plotres}}.
}

\examples{
# see
help(ecosim)
# for examples.
}

