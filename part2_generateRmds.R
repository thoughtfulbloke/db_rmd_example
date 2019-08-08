# example of generating paramtised reports from a database
library(janitor)
example_csv_contents <- "
person,fromdate, todate
JENK,1983-02-10,1990-10-03
MCQU,1950-01-01,2000-01-01
NEVER,1980-02-05,1984-08-04
JENK,1980-02-10,1986-10-03"

example_data <- read.csv(text=example_csv_contents,
                         stringsAsFactors = FALSE)
example_data$output <- paste0(make_clean_names(paste0(
  example_data$person, example_data$fromdate, example_data$todate
)),".html")

library(rmarkdown)
#you are going to need the libraries installed that are used in primary.Rmd
mailmerge <- function(x) {
  render(input="primary.Rmd", output_file=x[[4]], params = list(
    startTime = x[[2]],
    endTime = x[[3]],
    person = x[[1]]
  ))
}

apply(example_data, MARGIN = 1, mailmerge)
