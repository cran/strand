#' @name strand-package
#' @aliases strand
#' @docType package
#' @title strand: a framework for investment strategy simulation
#' @author Jeff Enos \email{jeffrey.enos@gmail.com} and David Kane \email{dave.kane@gmail.com}
#' @description
#' 
#' The strand package provides a framework for performing discrete (share-level)
#' simulations of investment strategies. Simulated portfolios optimize exposure
#' to an input signal subject to constraints such as position size and factor
#' exposure.
#'
#' For an introduction to running simulations using the package, see
#' \code{vignette("strand")}. For details on available methods see the
#' documentation for the \code{\link{Simulation}} class.
#' 
#' @import R6
#' @import ggplot2
#' @importFrom methods is
#' @importFrom dplyr %>% select mutate mutate_at mutate_if filter inner_join left_join vars group_by summarise summarise_all rename contains matches bind_rows ungroup arrange desc transmute rename_at group_by_at
#' @importFrom tibble enframe
#' @importFrom tidyr replace_na starts_with ends_with one_of everything pivot_longer pivot_wider gather unnest unnest_wider
#' @importFrom Matrix Matrix Diagonal
#' @importFrom Rglpk Rglpk_solve_LP
#' @importFrom yaml yaml.load_file
#' @importFrom rlang .data has_name :=
#' @importFrom arrow read_feather write_feather
#' @importFrom lubridate day month year day<- month<-
#' @importFrom stats cor qnorm sd as.formula residuals lm
#' @importFrom utils head
#' 
#' @examples
#' # Load up sample data
#' data(sample_secref)
#' data(sample_pricing)
#' data(sample_inputs)
#' 
#' # Load sample configuration
#' config <- example_strategy_config()
#'
#' # Override config file end date to run a one-week sim
#' config$to <- as.Date("2020-06-05")
#' 
#' # Create the Simulation object and run
#' sim <- Simulation$new(config,
#'                       raw_input_data = sample_inputs,
#'                       raw_pricing_data = sample_pricing,
#'                       security_reference_data = sample_secref)
#' sim$run()
#' 
#' # Print overall statistics
#' sim$overallStatsDf()
#' 
#' # Access tabular result data
#' head(sim$getSimSummary())
#' head(sim$getSimDetail())
#' head(sim$getPositionSummary())
#' head(sim$getInputStats())
#' head(sim$getOptimizationSummary())
#' head(sim$getExposures())
#' 
#' # Plot results
#' \dontrun{
#' sim$plotPerformance()
#' sim$plotMarketValue()
#' sim$plotCategoryExposure("sector") 
#' sim$plotFactorExposure(c("value", "size"))
#' sim$plotNumPositions()
#' }
NULL
