#' Predictive Information Index (PII)
#'
#' Computes the Predictive Information Index using one of three methods:
#' "r2" (R-squared ratio), "rm" (RMSE-based), or "v" (variance ratio).
#'
#' @param full_preds Predicted values from the full (benchmark) model.
#' @param score_preds Predicted values from the score-based model.
#' @param type Type of PII to compute: "r2", "rm", or "v".
#' @importFrom stats var median aggregate cor
#' @importFrom infotheo entropy mutinformation
#' @return A numeric value between 0 and 1.
#' @examples
#' full <- rnorm(100)
#' score <- full + rnorm(100, sd = 0.5)
#' pii(full, score, type = "rm")
#' @export
pii <- function(full_preds, score_preds, type = c("r2", "rm", "v")) {
  type <- match.arg(type)
  
  if (type == "r2") {
    r2_score <- cor(full_preds, score_preds)^2
    r2_full <- 1
    return(r2_score / r2_full)
  }
  
  if (type == "rm") {
    return(1 - var(full_preds - score_preds) / var(full_preds))
  }

  if (type == "v") {
    return(var(score_preds) / var(full_preds))
  }

  stop("Invalid PII type.")
}
