# Set seed for reproducibility
set.seed(1)

# Generate worker data
workers <- data.frame(
  name = paste("Worker", 1:400, sep=""),
  gender = sample(c("male", "female"), 400, replace=TRUE),
  salary = sample(5000:35000, 400, replace=TRUE)
)

# Function to determine level
determine_level <- function(salary, gender) {
  if (salary > 10000 && salary < 20000) {
    return("A1")
  } else if (salary > 7500 && salary < 30000 && gender == "female") {
    return("A5-F")
  } else {
    return("Other")
  }
}

# Generate payment slips
for (i in 1:nrow(workers)) {
  tryCatch({
    workers$level[i] <- determine_level(workers$salary[i], workers$gender[i])
    cat("Payment slip for", workers$name[i], ": Salary $", workers$salary[i], ", Level ", workers$level[i], "\n", sep="")
  }, error=function(e) {
    cat("Error processing payment for", workers$name[i], ": ", e$message, "\n")
  })
}
