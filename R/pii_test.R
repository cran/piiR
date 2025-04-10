
#' Permutation Test for PII
#'
#' @param score Numeric score vector
#' @param outcome Outcome vector
#' @param bins Number of bins for discretization
#' @param n_perm Number of permutations
#' @return List with observed PII, p-value, and null distribution
#' @export
pii_test <- function(score, outcome, bins = 10, n_perm = 1000) {
  score_disc <- infotheo::discretize(data.frame(score), nbins = bins)[,1]
  outcome_disc <- infotheo::discretize(data.frame(outcome), nbins = bins)[,1]
  obs_pii <- mutinformation(score_disc, outcome_disc) / entropy(outcome_disc)
  null_piis <- replicate(n_perm, {
    permuted <- sample(outcome_disc)
    mutinformation(score_disc, permuted) / entropy(permuted)
  })
  p_val <- mean(null_piis >= obs_pii)
  return(list(Observed_PII = obs_pii, P_Value = p_val, Null_Distribution = null_piis))
}
