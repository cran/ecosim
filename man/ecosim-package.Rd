\name{ecosim-package}

\alias{ecosim-package}
\alias{ecosim}

\docType{package}

\title{
Toolbox for Aquatic Ecosystem Modeling
}

\details{
\tabular{ll}{
Package: \tab ecosim\cr
Type: \tab Package\cr
Version: \tab 1.3-4\cr
Date: \tab 2023-08-28\cr
License: \tab GPL (>= 2)\cr
Depends: \tab deSolve, stoichcalc\cr
}
}

\description{
Classes and methods for implementing aquatic ecosystem models,
for running these models, and for visualizing their results. \cr\cr
Models are built by constructing objects of the classes \cr\cr
\code{\link{process-class}}, \cr
\code{\link{reactor-class}}, \cr
\code{\link{link-class}}, \cr
\code{\link{system-class}}. \cr\cr
A transformation processes (\code{\link{process-class}}) is defined by a process rate (expression describing the dependence of the rate on substance or organism concentrations and external influence factors) and stoichiometric coefficients that describe how the rate affects different substances or organisms.
It is recommended to calculate the stoichiometric coefficients with the function \code{\link{calc.stoich.coef}} of the package \code{\link[stoichcalc]{stoichcalc}} from substance and organism compositions.
The output of this function can directly be used for the process definition.
A reactor (\code{\link{reactor-class}}) describes a well-mixed compartment of the environment (or of a laboratory system).
For each reactor, inflow, outflow, substance and organism input and transformation processes can be defined.
A link (\code{\link{link-class}}) describes advective and/or diffusive exchange of substances and/or organisms between well-mixed reactors.
Finally, a system (\code{\link{system-class}}) consists of a single reactor or a set of isolated or linked reactors and can be used to describe a community or meta-community model of an ecosystem and the biogeochemical cycles. \cr\cr
Once a model is described by an object of the class system (\code{\link{system-class}}), simulations can be performed using the member function \cr\cr
\code{\link{calcres}}. \cr\cr
This function integrates the system of ordinary differential equations numerically using the function \code{\link{ode}} of the package \code{\link[deSolve]{deSolve}} and produces time series of the volumes and substance and organisms concentrations as a R matrix.
The results can be visualized with arbitrary R functions or a summary of all results can be produced with the function \cr\cr
\code{\link{plotres}}. \cr\cr
Similarly, sensitivity analyses can be performed with the member function \cr\cr
\code{\link{calcsens}}. \cr\cr
This function produces a list of lists of output matrices of the format produced by
\code{\link{calcres}}.
The function \code{\link{plotres}} is also able to deal with this slightly more complex
output format. \cr\cr
To propagate stochasticity and uncertainty to the results, stochastic parameter time series can be generated with the function \cr\cr
\code{\link{randou}} \cr\cr
and parameter samples can be sampled with the function \cr\cr
\code{\link{randnorm}} \cr\cr
to get a sample from the predictive distribution by Monte Carlo simulation.
Again, the results can be plotted with the function \code{\link{plotres}}.
}

\author{
Peter Reichert

Maintainer: Peter Reichert <peter.reichert@emeriti.eawag.ch>
}

\references{
Omlin, M., Reichert, P. and Forster, R., Biogeochemical model of lake Zurich: Model equations and results, Ecological Modelling 141(1-3), 77-103, 2001. \cr\cr
Reichert, P., Borchardt, D., Henze, M., Rauch, W., Shanahan, P., Somlyody, L. and Vanrolleghem, P., River Water Quality Model no. 1 (RWQM1): II. Biochemical process equations, Water Sci. Tech. 43(5), 11-30, 2001. \cr\cr
Reichert, P. and Schuwirth, N., A generic framework for deriving process stoichiometry in environmental models, Environmental Modelling & Software, 25, 1241-1251, 2010. \cr\cr
Soetaert, K., Petzoldt, T., and Woodrow Setzer, R. Solving differential equations in R: Package deSolve. Journal of Statistical Software, 33(9), 2010. \cr\cr
Soetaert, K., Cash, J., and Mazzia, F. Solving Differential Equations in R. Springer, Heidelberg, Germany. 2012.
}

\keyword{ package }

\seealso{
\code{\link[deSolve]{deSolve}},
\code{\link[stoichcalc]{stoichcalc}},
}

\note{The following demos are available:\cr\cr
lakemodel_simple \cr
lakemodel_intermediate \cr
lakemodel_complex \cr
rivermodel_simple \cr
rivermodel_complex \cr
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

# Perform simulation:
# ===================

res <- calcres(system)

# Plot results:
# =============
                 
plotres(res)              # plot to screen

# plotres(res,file="ecosim_example_plot1.pdf")  # plot to pdf file

plotres(res, colnames=c("C.ALG", "C.ZOO"))  # plot selected variables

plotres(res, colnames=list("C.HPO4",c("C.ALG", "C.ZOO")))

plotres(res[1:100,], colnames=list("C.HPO4",c("C.ALG", "C.ZOO"))) # plot selected time steps

# plotres(res      = res,    # plot to pdf file
#         colnames = list("C.HPO4",c("C.ALG","C.ZOO")),
#         file     = "ecosim_example_plot2.pdf",
#         width    = 8,
#         height   = 4)

# Perform sensitivity analysis:
# =============================
 
res.sens <- calcsens(system,param.sens=c("k.gro.ALG","k.gro.ZOO"))

# Plot results of sensitivity analysis:
# =====================================
 
plotres(res.sens)              # plot to screen

# plotres(res.sens,file="ecosim_example_plot3.pdf")  # plot to pdf file
}

