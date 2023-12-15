## Data Quaility Check Functions

## checking data frame and class type by columns ----
data_quality_report <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a dataframe.")
  }

  # if (any(sapply(data, class) != "numeric")) {
  #   stop("All columns must be numeric.")
  # }
  
  # ... [rest of the function]
}


## checking specific col names ----
data_quality_report <- function(data) {
  required_columns <- c("column1", "column2", "column3")
  if (!all(required_columns %in% names(data))) {
    stop("Data is missing required columns.")
  }
  
  # if (any(data > 1e6, na.rm = TRUE)) {
  #   stop("Data contains values too large to process.")
  # }
  
  # ... [rest of the function]
}


## summarizing data ----
data_quality_report <- function(data) {
  # ... [input validation code]
  
  # Handling numeric and categorical data differently
  numeric_columns <- data %>%
    select(where(is.numeric))
  categorical_columns <- data %>%
    select(where(is.factor))
  
  numeric_summary <- summarize_numeric_data(numeric_columns)
  categorical_summary <- summarize_categorical_data(categorical_columns)
  
  # ... [combine summaries and continue with the function]
}

summarize_numeric_data <- function(data) {
  # Numeric data summarization logic
}

summarize_categorical_data <- function(data) {
  # Categorical data summarization logic
}

## assertthat library ----
library(assertthat)

data_quality_report <- function(data) {
  assert_that(is.data.frame(data), msg = "Data not a Data Frame")
  assert_that(all(colSums(!is.na(data)) > 0), msg = "Some columns are entirely NA.")
  
  # ... [rest of the function]
}

d<- data.frame("Blue","Red")
d2<- "abc"
d3<- data.frame("Blue",NA)
data_quality_report(d2)
