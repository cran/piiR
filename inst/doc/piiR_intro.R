## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library(piiR)

# Simulate an outcome and two prediction vectors
set.seed(123)
y     <- rnorm(100)                        # observed outcome
full  <- y + rnorm(100, sd = 0.3)          # full-model predictions
score <- y + rnorm(100, sd = 0.5)          # score-based predictions

# Compute the three PII variants
pii(y, score, full, type = "r2")  # variance explained
pii(y, score, full, type = "rm")  # RMSE ratio
pii(y, score, full, type = "v")   # variance ratio

