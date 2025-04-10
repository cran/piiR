
#' Plot Score vs Outcome for Visual PII Insight
#'
#' @param score Numeric score vector
#' @param outcome Numeric outcome vector
#' @param bins Number of bins for discretization
#' @return A base R plot
#' @export
pii_plot <- function(score, outcome, bins = 10) {
  df <- data.frame(score = score, outcome = outcome)
  df$score_bin <- cut(df$score, breaks = bins)
  agg <- aggregate(outcome ~ score_bin, data = df, FUN = mean)
  plot(agg$outcome, type = "b", xlab = "Score Bin", ylab = "Mean Outcome", main = "Score-Outcome Relationship")
}
