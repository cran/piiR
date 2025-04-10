
#' PII for Classification Outcomes with Metrics
#'
#' @param score Predicted numeric score
#' @param outcome Binary factor outcome
#' @param bins Number of bins for discretization
#' @return List with PII, AUC, accuracy, confusion matrix
#' @export
pii_classification <- function(score, outcome, bins = 10) {
  if (!requireNamespace("pROC", quietly = TRUE)) {
    stop("Please install the 'pROC' package for AUC.")
  }
  outcome <- as.factor(outcome)
  score_disc <- infotheo::discretize(data.frame(score), nbins = bins)[,1]
  outcome_disc <- as.numeric(outcome) - 1
  mi <- infotheo::mutinformation(score_disc, outcome_disc)
  h <- infotheo::entropy(outcome_disc)
  pii_val <- ifelse(h == 0, NA, mi / h)
  pred_class <- ifelse(score > median(score), levels(outcome)[2], levels(outcome)[1])
  cm <- table(pred_class, outcome)
  acc <- sum(diag(cm)) / sum(cm)
  auc <- pROC::auc(pROC::roc(outcome, score))
  return(list(PII = pii_val, Accuracy = acc, AUC = auc, ConfusionMatrix = cm))
}
