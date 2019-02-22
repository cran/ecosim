\name{calcsens}

\alias{calcsens}

\title{
Performs a Sensitivity Analysis of the Model Passed as the Argument
}

\description{
Calculates dynamic solutions of the model defined by the argument with modified parameter values.
Each of the specified parameters is multiplied in sequence by the provided scaling factors to produce
complete model output matrices for all individual parameter modifications. 
}

\usage{
calcsens(system, param.sens, scaling.factors=c(1,0.5,2))}

\arguments{
  \item{system}{
Object of type \code{\link{system-class}} that defines the model.
}
  \item{param.sens}{
Vector of parameter names for which sensitivity analysis should be performed.
The names must be a subset of the names used in the parameter entry of the argument \code{system}.
}
  \item{scaling.factors}{
Numerical vector of scaling factors with which the parameters should be multiplied.
It is recommended that the scaling factors include unity as the first entry to get the basic simulation results.
The default is to use the scaling factors 1, 0.5 and 2.
}
}

\value{
The function returns a list of lists of result matrices of the method \code{\link{calcres-methods}}.
The outer list is over the parameters, the inner list over the different values of each parameter.
Note that the function \code{\link{plotres}} can be used to plot the results.
}

\references{
Omlin, M., Reichert, P. and Forster, R., Biogeochemical model of lake Zurich: Model equations and results, Ecological Modelling 141(1-3), 77-103, 2001. \cr\cr
Reichert, P., Borchardt, D., Henze, M., Rauch, W., Shanahan, P., Somlyody, L. and Vanrolleghem, P., River Water Quality Model no. 1 (RWQM1): II. Biochemical process equations, Water Sci. Tech. 43(5), 11-30, 2001. \cr\cr
Reichert, P. and Schuwirth, N., A generic framework for deriving process stoichiometry in environmental models, Environmental Modelling & Software, 25, 1241-1251, 2010. \cr\cr
Soetaert, K., Petzoldt, T., and Woodrow Setzer, R. Solving differential equations in R: Package deSolve. Journal of Statistical Software, 33(9), 2010. \cr\cr
Soetaert, K., Cash, J., and Mazzia, F. Solving Differential Equations in R. Springer, Heidelberg, Germany. 2012.
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
\code{\link{calcres-methods}}.
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

plotres(res,file="ecosim_example_plot1.pdf")  # plot to pdf file

plotres(res, colnames=c("C.ALG", "C.ZOO"))  # plot selected variables

plotres(res, colnames=list("C.HPO4",c("C.ALG", "C.ZOO")))

plotres(res[1:100,], colnames=list("C.HPO4",c("C.ALG", "C.ZOO"))) # plot selected time steps

plotres(res      = res,    # plot to pdf file
        colnames = list("C.HPO4",c("C.ALG","C.ZOO")),
        file     = "ecosim_example_plot2.pdf",
        width    = 8,
        height   = 4)

# Perform sensitivity analysis:
# =============================
 
res.sens <- calcsens(system,param.sens=c("k.gro.ALG","k.gro.ZOO"))

# Plot results of sensitivity analysis:
# =====================================
 
plotres(res.sens)              # plot to screen

plotres(res.sens,file="ecosim_example_plot3.pdf")  # plot to pdf file
}

