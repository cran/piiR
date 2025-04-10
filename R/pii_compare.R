
#' Compare PII and RMSE Across Multiple Scores
#'
#' @param outcome A numeric outcome vector
#' @param scores A named list of score vectors
#' @param bins Number of bins for PII
#' @return A data.frame of comparison metrics
#' @export
pii_compare <- function(outcome, scores, bins = 10) {
  results <- data.frame(Model = character(), PII = numeric(), RMSE = numeric(), stringsAsFactors = FALSE)
  for (name in names(scores)) {
    score <- scores[[name]]
    score_disc <- infotheo::discretize(data.frame(score), nbins = bins)[,1]
    outcome_disc <- infotheo::discretize(data.frame(outcome), nbins = bins)[,1]
    mi <- infotheo::mutinformation(score_disc, outcome_disc)
    h <- infotheo::entropy(outcome_disc)
    pii_val <- ifelse(h == 0, NA, mi / h)
    rmse <- sqrt(mean((outcome - score)^2))
    results <- rbind(results, data.frame(Model = name, PII = pii_val, RMSE = rmse))
  }
  return(results)
}
