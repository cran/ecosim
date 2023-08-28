\name{system-class}

\Rdversion{1.1}
\docType{class}

\alias{system-class}

\title{Class \code{"system"}}

\description{
This class represents a system consisting of linked reactors, substances/organisms in the reactors and transformation processes. \cr\cr
Once a model is described by an object of the class system (\code{\link{system-class}}), simulations can be performed using the member function \cr\cr
\code{\link{calcres}}, \cr\cr
This function integrates the system of ordinary differential equations numerically using the function \code{\link{ode}} of the package \code{\link[deSolve:deSolve]{deSolve}} and produces time series of the volumes and substance and organisms concentrations as a R matrix.
The results can be visualized with arbitrary R functions or a summary of all results can be produced with the function \cr\cr
\code{\link{plotres}}.
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
    \item{\code{param}:}{List of model parameters in the form of numerical values or lists of vectors for x and y values describing a realization of a time-dependent parameter.}
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
Reichert, P. and Schuwirth, N., A generic framework for deriving process stoichiometry in environmental models, Environmental Modelling & Software, 25, 1241-1251, 2010. \cr\cr
Soetaert, K., Petzoldt, T., and Woodrow Setzer, R. Solving differential equations in R: Package deSolve. Journal of Statistical Software, 33(9), 2010. \cr\cr
Soetaert, K., Cash, J., and Mazzia, F. Solving Differential Equations in R. Springer, Heidelberg, Germany. 2012.
}

\author{
Peter Reichert <peter.reichert@emeriti.eawag.ch>
}

\seealso{
\code{\link{process-class}},
\code{\link{reactor-class}},
\code{\link{link-class}},
\code{\link{calcres}},
\code{\link{plotres}}.
}

\examples{
# Definition of parameters:
# =========================

param    <- list(k.gro.ALG   = 1,        # 1/d
                 k.gro.ZOO   = 0.8,      # m3/gDM/d
                 k.death.ALG = 0.4,      # 1/d
                 k.death.ZOO = 0.08,     # 1/d
                 K.HPO4      = 0.002,    # gP/m3
                 Y.ZOO       = 0.2,      # gDM/gDM
                 alpha.P.ALG = 0.002,    # gP/gDM
                 A           = 8.5e+006, # m2
                 h.epi       = 4,        # m
                 Q.in        = 4,        # m3/s
                 C.ALG.ini   = 0.05,     # gDM/m3
                 C.ZOO.ini   = 0.1,      # gDM/m3
                 C.HPO4.ini  = 0.02,     # gP/m3
                 C.HPO4.in   = 0.04)     # gP/m3             

# Definition of transformation processes:
# =======================================

# Growth of algae:
# ----------------

gro.ALG   <- new(Class  = "process",
                 name   = "Growth of algae",
                 rate   = expression(k.gro.ALG
                                     *C.HPO4/(K.HPO4+C.HPO4)
                                     *C.ALG),
                 stoich = list(C.ALG  = expression(1),              # gDM/gDM
                               C.HPO4 = expression(-alpha.P.ALG)))  # gP/gDM

# Death of algae:
# ---------------

death.ALG <- new(Class = "process",
                 name   = "Death of algae",
                 rate   = expression(k.death.ALG*C.ALG),
                 stoich = list(C.ALG  = expression(-1)))            # gDM/gDM

# Growth of zooplankton:
# ----------------------

gro.ZOO   <- new(Class  = "process",
                 name   = "Growth of zooplankton",
                 rate   = expression(k.gro.ZOO
                                     *C.ALG
                                     *C.ZOO),
                 stoich = list(C.ZOO  = expression(1),              # gDM/gDM
                               C.ALG  = expression(-1/Y.ZOO)))      # gP/gDM

# Death of zooplankton:
# ---------------------

death.ZOO <- new(Class  = "process",
                 name   = "Death of zooplankton",
                 rate   = expression(k.death.ZOO*C.ZOO),
                 stoich = list(C.ZOO  = expression(-1)))            # gDM/gDM

# Definition of reactor:
# ======================

# Epilimnion:
# -----------

epilimnion <- 
   new(Class            = "reactor",
       name             = "Epilimnion",
       volume.ini       = expression(A*h.epi),
       conc.pervol.ini  = list(C.HPO4 = expression(C.HPO4.ini),     # gP/m3
                               C.ALG  = expression(C.ALG.ini),      # gDM/m3
                               C.ZOO  = expression(C.ZOO.ini)),     # gDM/m3
       inflow           = expression(Q.in*86400),                   # m3/d
       inflow.conc      = list(C.HPO4 = expression(C.HPO4.in),
                               C.ALG  = 0,
                               C.ZOO  = 0),
       outflow          = expression(Q.in*86400),
       processes        = list(gro.ALG,death.ALG,gro.ZOO,death.ZOO))

# Definition of system:
# =====================

# Lake system:
# ------------

system <- new(Class    = "system",
              name     = "Lake",
              reactors = list(epilimnion),
              param    = param,
              t.out    = seq(0,365,by=1))
}

