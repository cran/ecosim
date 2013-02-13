\name{reactor-class}

\Rdversion{1.1}
\docType{class}

\alias{reactor-class}

\title{Class \code{"reactor"}}

\description{
This class represents a well-mixed part of the system as a "reactor".
A reactor is characterized by 
its initial volume, 
a surface area available for sessile organisms or attached substances,
initial concentrations of substances and organisms in the water column and on the surface area,
input into the reactor not associated with  inflow,
inflow into the reactor
substance and organism concentrations in the inflow,
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
}

