% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wqs_pt.R
\name{wqs_pt}
\alias{wqs_pt}
\title{WQS permutation test}
\usage{
wqs_pt(
  model,
  niter = 200,
  boots = NULL,
  b1_pos = TRUE,
  b1_constr = FALSE,
  rs = FALSE,
  plan_strategy = "multicore",
  seed = NULL
)
}
\arguments{
\item{model}{A \code{gwqs} object as generated from the \code{gWQS} package.}

\item{niter}{Number of permutation test iterations.}

\item{boots}{Number of bootstrap samples for each permutation test WQS
regression iteration. If \code{boots} is not specified, then we will use the same
bootstrap count for each permutation test WQS regression iteration as that
specified in the main WQS regression run.}

\item{b1_pos}{A logical value that indicates whether beta values should be
positive or negative.}

\item{b1_constr}{Logical value that determines whether to apply positive or
negative constraints in the optimization function for the weight optimization.}

\item{rs}{A logical value indicating whether random subset implementation
should be performed.}

\item{plan_strategy}{Evaluation strategy for the plan function. You can choose
among "sequential", "transparent", "multisession", "multicore",
"multiprocess", "cluster" and "remote." See future::plan documentation for full
details.}

\item{seed}{(optional) Random seed for the permutation test WQS reference run.
This should be the same random seed as used for the main WQS regression run.
This seed will be saved in the "gwqs_perm" object as "gwqs_perm$seed".}
}
\value{
\code{wqs_pt} returns an object of class \code{wqs_pt}, which contains:

\item{perm_test}{List containing: (1) \code{pval}: permutation test p-value,
(2) (linear WQS regression only) \code{testbeta1}: reference WQS coefficient beta1 value,
(3) (linear WQS regression only) \code{betas}: Vector of beta values from
each permutation test run, (4) (WQS GLM only) \code{testpval}: test reference
p-value, (5) (WQS GLM only) \code{permpvals}: p-values from the null models.}
\item{gwqs_main}{Main gWQS object (same as model input).}
\item{gwqs_perm}{Permutation test reference gWQS object (NULL if model
\code{family != "gaussian"} or if same number of bootstraps are used in permutation
test WQS regression runs as in the main run).}
}
\description{
\code{wqs_pt} takes a \code{gwqs} object as an input and runs the permutation
test (Day et al. 2022) to obtain an estimate for the p-value significance for
the WQS coefficient.
}
\details{
To use \code{wqs_pt}, we first need to run an initial WQS regression run while
setting \code{validation = 0}. We will use this \code{gwqs} object as the model argument
for the \code{wqs_pt} function. Note that permutation test has so far only been
validated for linear WQS regression (i.e., \code{family = "gaussian"}) or logistic
WQS regression (i.e., \code{family = binomial(link = "logit")}), though the
permutation test algorithm should also work for all WQS GLMs. Therefore,
this function accepts \code{gwqs} objects made with the following families:
"gaussian" or gaussian(link = "identity"), "binomial" or binomial() with
any accepted link function (e.g., "logit" or "probit"), "poisson" or
poisson(link="log"), "negbin" for negative binomial, and "quasipoisson" or
quasipoisson(link="log"). This function cannot currently accommodate \code{gwqs}
objects made with the "multinomial" family, and it is not currently able to
accommodate stratified weights or WQS interaction terms (e.g., \code{y ~ wqs * sex}).

The argument \code{boots} is the number of bootstraps for the WQS regression run
in each permutation test iteration. Note that we may elect a bootstrap count
\code{boots} lower than that specified in the model object for the sake of
efficiency. If \code{boots} is not specified, then we will use the same bootstrap
count in the permutation test WQS regression runs as that specified in the
model argument.

The arguments \code{b1_pos} and \code{rs} should be consistent with the inputs chosen
in the model object. The seed should ideally be consistent with the seed set
in the model object for consistency, though this is not required.
}
\examples{
library(gWQS)

# mixture names
PCBs <- names(wqs_data)[1:17] #half of the original 34 for quick computation

# create reference wqs object with 5 bootstraps
wqs_main <- gwqs(yLBX ~ wqs, mix_name = PCBs, data = wqs_data, q = 10, 
                 validation = 0, b = 5, b1_pos = TRUE, b1_constr = FALSE,
                 plan_strategy = "multicore", family = "gaussian", seed = 16)
# Note: We recommend niter = 1000 for the main WQS regression. This example
# has a lower number of bootstraps to serve as a shorter test run.

# run permutation test

perm_test_res <- wqs_pt(wqs_main, niter = 3, b1_pos = TRUE)


# Note: The default value of niter = 200 is the recommended parameter value. 
# This example has a lower niter in order to serve as a shorter test run. 

}
\references{
Day, D. B., Sathyanarayana, S., LeWinn, K. Z., Karr, C. J., Mason, W. A., &
Szpiro, A. A. (2022). A permutation test-based approach to strengthening
inference on the effects of environmental mixtures: comparison between single
index analytic methods. Environmental Health Perspectives, 130(8).

Day, D. B., Collett, B. R., Barrett, E. S., Bush, N. R., Swan, S. H., Nguyen,
R. H., ... & Sathyanarayana, S. (2021). Phthalate mixtures in pregnancy,
autistic traits, and adverse childhood behavioral outcomes. Environment
International, 147, 106330.

Loftus, C. T., Bush, N. R., Day, D. B., Ni, Y., Tylavsky, F. A., Karr, C. J.,
... & LeWinn, K. Z. (2021). Exposure to prenatal phthalate mixtures and
neurodevelopment in the Conditions Affecting Neurocognitive Development and
Learning in Early childhood (CANDLE) study. Environment International, 150,
106409.
}
