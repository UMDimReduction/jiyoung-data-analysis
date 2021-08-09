library(dslabs)
library(rsample)

# Split data into train and test----
set.seed(2021)

dataset <- as.data.frame(brca$x)
dataset$class <- brca$y

split <- initial_split(dataset, props = 9/10)
data_train <- training(split)
data_test  <- testing(split)

# Save test data
readr::write_csv(data_test, "brca_test.csv")

# Introduce missing data in training----
missing_prop <- 0.05
n <- nrow(data_train)
p <- ncol(data_train) - 1 # No missing response

missing_num <- round(missing_prop*n*p)

# Randomly select rows and columns
miss_rows <- sample(n, size = missing_num, replace = TRUE)
miss_cols <- sample(p, size = missing_num, replace = TRUE)

for (i in seq_len(missing_num)) {
    data_train[miss_rows[i], miss_cols[i]] <- NA
}

# Save train data
readr::write_csv(data_train, "brca_train.csv")
