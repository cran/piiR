## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library(piiR)

# Simulate two prediction vectors
set.seed(123)
full_model_preds <- rnorm(100)
score_based_preds <- full_model_preds + rnorm(100, sd = 0.5)

# Compute PII
pii(full_model_preds, score_based_preds)

