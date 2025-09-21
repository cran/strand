## ----echo = FALSE, message = FALSE--------------------------------------------

# output: pdf_document

# output:
#   rmarkdown::html_vignette:
#     toc: true

knitr::opts_chunk$set(collapse = T, comment = "#>", fig.width = 7, fig.height = 4)

# Set default values so that errors are not thrown for inline chunks if the above env var is set.
overall_stats <- list()

options(tibble.print_min = 4L, tibble.print_max = 4L, tibble.width = Inf, dplyr.summarise.inform = FALSE)

## ----message = FALSE----------------------------------------------------------
library(strand)
library(dplyr)

## -----------------------------------------------------------------------------
data(sample_secref)

sample_secref %>%
  select(id, name, sector) %>%
  head()

## -----------------------------------------------------------------------------
data(sample_inputs)

sample_inputs %>%
  filter(date %in% as.Date("2020-06-01")) %>%
  select("date", "id", "rc_vol", "size", "value") %>%
  head()

## -----------------------------------------------------------------------------
data(sample_pricing)

sample_pricing %>%
  filter(date %in% as.Date("2020-06-01")) %>%
  select("date", "id", "price_unadj", "prior_close_unadj", "adjustment_ratio",
         "volume", "dividend_unadj", "distribution_unadj") %>%
  head()

## -----------------------------------------------------------------------------
data(sample_secref)
sample_secref %>%
  group_by(sector) %>%
  summarise(count = n()) %>%
  print(n = Inf)

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
sim$plotCategoryExposure("sector")

## -----------------------------------------------------------------------------
sim$plotFactorExposure(c("size"))

