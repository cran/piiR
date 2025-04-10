
#' Compute PII for Multiple Scores
#'
#' Evaluates PII and RMSE for multiple predictors
#'
#' @param formula A formula with multiple predictors (e.g., outcome ~ x1 + x2 + x3)
#' @param data A data.frame
#' @param bins Number of bins for discretization
#' @return A data.frame of PII and RMSE for each predictor
#' @export
pii_batch <- function(formula, data, bins = 10) {
  outcome_var <- all.vars(formula)[1]
  predictor_vars <- all.vars(formula)[-1]
  outcome <- data[[outcome_var]]
  results <- data.frame(Predictor = character(), PII = numeric(), RMSE = numeric(), stringsAsFactors = FALSE)
  for (var in predictor_vars) {
    score <- data[[var]]
    score_disc <- infotheo::discretize(data.frame(score), nbins = bins)[,1]
    outcome_disc <- infotheo::discretize(data.frame(outcome), nbins = bins)[,1]
    mi <- infotheo::mutinformation(score_disc, outcome_disc)
    h <- infotheo::entropy(outcome_disc)
    pii <- ifelse(h == 0, NA, mi / h)
    rmse <- sqrt(mean((outcome - score)^2))
    results <- rbind(results, data.frame(Predictor = var, PII = pii, RMSE = rmse))
  }
  return(results)
}
