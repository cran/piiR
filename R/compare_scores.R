
#' Compare Multiple Scoring Methods
#'
#' @param outcome Vector of outcomes
#' @param scores Named list of score vectors
#' @param bins Number of bins
#' @return Data frame with PII and RMSE
#' @export
compare_scores <- function(outcome, scores, bins = 10) {
  results <- data.frame(Method = character(), PII = numeric(), RMSE = numeric(), stringsAsFactors = FALSE)
  for (name in names(scores)) {
    score <- scores[[name]]
    score_disc <- infotheo::discretize(data.frame(score), nbins = bins)[,1]
    outcome_disc <- infotheo::discretize(data.frame(outcome), nbins = bins)[,1]
    mi <- infotheo::mutinformation(score_disc, outcome_disc)
    h <- infotheo::entropy(outcome_disc)
    pii_val <- ifelse(h == 0, NA, mi / h)
    rmse_val <- sqrt(mean((outcome - score)^2))
    results <- rbind(results, data.frame(Method = name, PII = pii_val, RMSE = rmse_val))
  }
  return(results)
}
