## ---- echo = FALSE, message = FALSE-------------------------------------------

# output: pdf_document

# output:
#   rmarkdown::html_vignette:
#     toc: true

knitr::opts_chunk$set(collapse = T, comment = "#>", fig.width = 7, fig.height = 4)

# Set default values so that errors are not thrown for inline chunks if the above env var is set.
overall_stats <- list()

options(tibble.print_min = 4L, tibble.print_max = 4L, tibble.width = Inf)

## ---- message = FALSE---------------------------------------------------------
library(strand)
library(dplyr)

## -----------------------------------------------------------------------------
data(sample_secref)

sample_secref %>%
  select("id", "symbol", "category_1")

## -----------------------------------------------------------------------------
data(sample_inputs)

sample_inputs %>%
  filter(date %in% as.Date("2019-01-04")) %>%
  select("date", "id", "average_volume", "alpha_1", "factor_1",  "factor_2")

## -----------------------------------------------------------------------------
data(sample_pricing)

sample_pricing %>%
  filter(date %in% as.Date("2019-01-04")) %>%
  select("date", "id", "price_unadj", "prior_close_unadj", "adjustment_ratio",
         "volume", "dividend_unadj", "distribution_unadj")

## -----------------------------------------------------------------------------
data(sample_secref)
table(sample_secref$category_1)

## -----------------------------------------------------------------------------
data(sample_inputs)
data(sample_pricing)
data(sample_secref)

sim <- Simulation$new(config = "sample.yaml",
                      raw_input_data = sample_inputs,
                      raw_pricing_data = sample_pricing,
                      security_reference_data = sample_secref)
                      
sim$run()


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

