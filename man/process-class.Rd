\name{process-class}

\Rdversion{1.1}
\docType{class}

\alias{process-class}

\title{Class \code{"process"}}

\description{
This class represents a transformation process of substances/organisms in the modelled system.
Such a process is characterized by a transformation rate and a list of stoichiometric coefficients for the affected substances and organisms.
It is recommended to calculate the stoichiometric coefficients with the function \code{\link{calc.stoich.coef}} of the package \code{\link[stoichcalc:stoichcalc-package]{stoichcalc}} from substance and organism compositions.
The output of this function can directly be used for the process definition.
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
}

