## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----warning=F, message=F-----------------------------------------------------
library(gWQS)
library(wqspt)

## ----warning = F, message = F, eval=F-----------------------------------------
# # simulated dataset
# sim_res1 <- wqs_sim(nmix = 10,
#                     ncovrt = 10,
#                     nobs = 1000,
#                     ntruewts = 10,
#                     ntruecovrt = 5,
#                     truewqsbeta = 0.2,
#                     truebeta0 = 2,
#                     truewts = c(0.15, 0.15, 0.15, 0.15, 0.15,
#                                 0.05, 0.05, 0.05, 0.05, 0.05),
#                     q = 10,
#                     seed = 16)
# 
# sim_data1 <- sim_res1$Data
# 
# wqs_form <- formula(paste0("y ~ wqs + ", paste(paste0("C", 1:10),
#                                                collapse = "+")))

## ----warning = F, eval=F------------------------------------------------------
# # mixture names
# mix_names1 <- colnames(sim_data1)[2:11]
# 
# # create reference wqs object
# wqs_main1 <- gwqs(wqs_form, mix_name = mix_names1, data = sim_data1,
#                   q = 10, validation = 0, b = 20, b1_pos = TRUE,
#                   plan_strategy = "multicore", family = "gaussian",
#                   seed = 16)

## ----eval=F-------------------------------------------------------------------
# # run permutation test
# perm_test_res1 <- wqs_pt(wqs_main1, niter = 50, boots = 5, b1_pos = TRUE,
#                          seed = 16)

## ----echo=F-------------------------------------------------------------------
load("data/introduction-vignette.RData")

## ----eval = F-----------------------------------------------------------------
# main_sum1 <- summary(perm_test_res1$gwqs_main)

## -----------------------------------------------------------------------------
main_sum1$coefficients

## -----------------------------------------------------------------------------
perm_test_res1$perm_test$pval

## ----fig.height = 6-----------------------------------------------------------
wqspt_plot(perm_test_res1)$FullPlot

## ----eval = F-----------------------------------------------------------------
# sim_res2 <- wqs_sim(nmix = 10,
#                     ncovrt = 10,
#                     nobs = 1000,
#                     ntruewts = 10,
#                     ntruecovrt = 5,
#                     truewqsbeta = 0,
#                     truebeta0 = 0.1,
#                     truewts = c(0.15, 0.15, 0.15, 0.15, 0.15,
#                                 0.05, 0.05, 0.05, 0.05, 0.05),
#                     q = 10,
#                     seed = 16)
# 
# sim_data2 <- sim_res2$Data

## ----eval=F-------------------------------------------------------------------
# # mixture names
# mix_names2 <- colnames(sim_data2)[2:11]
# 
# # create reference wqs object
# wqs_main2 <- gwqs(wqs_form, mix_name = mix_names2, data = sim_data2, q = 10,
#                   validation = 0, b = 20, b1_pos = TRUE,
#                   plan_strategy = "multicore", family = "gaussian",
#                   seed = 16)
# 
# # run permutation test
# perm_test_res2 <- wqs_pt(wqs_main2, niter = 50, boots = 5, b1_pos = TRUE,
#                          seed = 16)

## ----eval = F-----------------------------------------------------------------
# main_sum2 <- summary(perm_test_res2$gwqs_main)

## -----------------------------------------------------------------------------
main_sum2$coefficients

## -----------------------------------------------------------------------------
perm_test_res2$perm_test$pval

## ----fig.height = 6-----------------------------------------------------------
wqspt_plot(perm_test_res2)$FullPlot

## ----eval = F-----------------------------------------------------------------
# perm_test_res3 <- wqs_full_perm(wqs_form,
#                                data = sim_data1,
#                                mix_name = mix_names1,
#                                q = 10,
#                                b_main = 20,
#                                b_perm = 5,
#                                b1_pos = TRUE,
#                                niter = 50,
#                                seed = 16,
#                                plan_strategy = "multicore")

## ----fig.height = 6-----------------------------------------------------------
wqspt_plot(perm_test_res3)$FullPlot

## ----eval=F-------------------------------------------------------------------
# sim_res3 <- wqs_sim(nmix = 10,
#                     ncovrt = 10,
#                     nobs = 1000,
#                     ntruewts = 10,
#                     ntruecovrt = 5,
#                     truewqsbeta = 0.4,
#                     truebeta0 = -2.5,
#                     truewts = c(0.15, 0.15, 0.15, 0.15, 0.15,
#                                 0.05, 0.05, 0.05, 0.05, 0.05),
#                     q = 10,
#                     family = "binomial",
#                     seed = 16)
# 
# sim_data3 <- sim_res3$Data
# 
# perm_test_res4 <- wqs_full_perm(wqs_form,
#                                data = sim_data3,
#                                mix_name = mix_names1,
#                                q = 10,
#                                b_main = 20,
#                                b_perm = 5,
#                                b1_pos = TRUE,
#                                niter = 50,
#                                seed = 16,
#                                plan_strategy = "multicore",
#                                family = "binomial")

## ----fig.height=6-------------------------------------------------------------
wqspt_plot(perm_test_res4)$FullPlot

