## ---- echo = FALSE, message = FALSE-------------------------------------------

# output: pdf_document

# output:
#   rmarkdown::html_vignette:
#     toc: true

knitr::opts_chunk$set(collapse = T, comment = "#>", fig.width = 7, fig.height = 4)

# Compile vignette if the COMPILE_STRAND_VIGNETTE env var is set.
knitr::opts_chunk$set(eval = nzchar(Sys.getenv("COMPILE_STRAND_VIGNETTE")))

# Set default values so that errors are not thrown for inline chunks if the above env var is set.
overall_stats <- list()

options(tibble.print_min = 4L, tibble.print_max = 4L, tibble.width = Inf)
library(feather)
library(dplyr)
library(strand)

## -----------------------------------------------------------------------------
read_feather("sample_data/secref.feather") %>%
  select("id", "symbol", "category_1")

## -----------------------------------------------------------------------------
read_feather("sample_data/inputs/inputs_20190715.feather") %>%
  select("id", "average_volume", "alpha_1", "factor_1",  "factor_2")

## -----------------------------------------------------------------------------
read_feather("sample_data/pricing/pricing_20190715.feather") %>%
  select("id", "price_unadj", "prior_close_unadj", "adjustment_ratio",
         "volume", "dividend_unadj", "distribution_unadj")

## -----------------------------------------------------------------------------
security_reference <- read_feather("sample_data/secref.feather")
table(security_reference[["category_1"]])

## -----------------------------------------------------------------------------
sim <- Simulation$new("sample.yaml")
sim$run()


## ---- echo = FALSE------------------------------------------------------------
overall_stats <- sim$overallStatsDf()

## -----------------------------------------------------------------------------
sim$overallStatsDf()

## -----------------------------------------------------------------------------
sim$plotPerformance()

## -----------------------------------------------------------------------------
sim$plotMarketValue()

## -----------------------------------------------------------------------------
sim$plotCategoryExposure("category_1")

## -----------------------------------------------------------------------------
sim$plotFactorExposure(c("factor_1", "factor_2"))

