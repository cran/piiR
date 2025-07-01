#' Predictive Information Index (PII)
#'
#' Computes the Predictive Information Index using one of three methods:
#' "r2" (R-squared ratio), "rm" (RMSE-based), or "v" (variance ratio).
#'
#' @param y Observed outcome vector.
#' @param score_pred Predictions from score-based model.
#' @param full_pred Predictions from the full model.
#' @param type Character. One of "r2", "rm", or "v".
#' @importFrom stats var median aggregate cor
#' @return A numeric value between 0 and 1.
#' @examples
#' set.seed(1)
#' y     <- rnorm(100)
#' full  <- y + rnorm(100, sd = 0.3)
#' score <- y + rnorm(100, sd = 0.5)
#' pii(y, score, full, type = "r2")
#' pii(y, score, full, type = "rm")
#' pii(y, score, full, type = "v")
#' @export
pii <- function(y, score_pred, full_pred = NULL, type = c("r2", "rm", "v")) {
  type <- match.arg(type)
  
  if (type == "r2") {
    mse_score <- mean((y - score_pred)^2)
    mse_null  <- mean((y - mean(y))^2)
    return(1 - mse_score / mse_null)
  }
  
  if (type == "rm") {
    if (is.null(full_pred))
      stop("type = 'rm' needs full_pred.")
    rmse <- function(a,b) sqrt(mean((a-b)^2))
    return(1 - rmse(y, score_pred)^2 / rmse(y, full_pred)^2)
  }
  
  if (type == "v") {
    return(1 - var(full_pred - score_pred) / var(full_pred))
  }
}