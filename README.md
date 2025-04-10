# piiR <img src="https://raw.githubusercontent.com/TheotherDrWells/piiR/main/inst/logo.png" align="right" height="100" />

[![R-CMD-check](https://github.com/TheotherDrWells/piiR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/TheotherDrWells/piiR/actions/workflows/R-CMD-check.yaml)

**Predictive Information Index (PII): Quantifying predictive utility of scores**

The `piiR` package provides tools for computing the Predictive Information Index (PII), which evaluates how much outcome-relevant information is retained in various types of scores (e.g., sum scores, CFA scores, subscale scores) in predictive models.

---

## 📦 Installation

```r
# Install from GitHub
remotes::install_github("TheotherDrWells/piiR")

# Or from CRAN (once accepted)
install.packages("piiR")

---

## 🚀 Example

library(piiR)

set.seed(123)
full <- rnorm(100)
score <- full + rnorm(100, sd = 0.5)

# Compute RMSE-based PII
pii(full, score, type = "rm")

# Try R²-based PII
pii(full, score, type = "r2")

---

📘 Learn More
Vignette: vignette("piiR_intro")

Docs: CRAN page (once available)
