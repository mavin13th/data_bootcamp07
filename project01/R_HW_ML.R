# Load Library
library(readxl)
library(tidyverse)
library(caret)
library(randomForest)

# Import Dataset from Excel
raw_data <- read_excel("House Price India.xlsx")

# Check data detail
glimpse(raw_data)

# Split Data
## Create Function
train_test_split <- function(data, trainRatio=0.7){
  set.seed(13)
  n <- nrow(data)
  id <- sample(1:n, size=trainRatio*n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  
  list(train=train_data, test=test_data)
}

## Split data
split_data <- train_test_split(raw_data, 0.7)
train_data <- split_data$train
test_data <- split_data$test

# Train model
lm_model <- train(log(Price) ~ `number of bedrooms`+`number of bathrooms`+`number of floors`+`number of views`+`condition of the house`,
                  data = train_data,
                  method = "lm")

knn_model <- train(log(Price) ~ `number of bedrooms`+`number of bathrooms`+`number of floors`+`number of views`+`condition of the house`,
                  data = train_data,
                  method = "knn")

rf_model <- train(log(Price) ~ `number of bedrooms`+`number of bathrooms`+`number of floors`+`number of views`+`condition of the house`,
                  data = train_data,
                  method = "rf")

# Score model
p_lm <- predict(lm_model, newdata = test_data)
p_knn <- predict(knn_model, newdata = test_data)
p_rf <- predict(rf_model, newdata = test_data)

# Evaluate model
# create function
sum_error <- function(actual, predict){
  abs_error <- abs(actual - predict)
  mae <- mean(abs_error)
  
  sq_error_mse <- (actual - predict) **2
  mse <- sqrt(sq_error_mse)
  
  sq_error_rmse <- (actual - predict) **2
  rmse <- sqrt(mean(sq_error_rmse))
  
  return(list(MAE = mae, MSE = mse, RMSE = rmse))
}

lm_error <- sum_error(log(test_data$Price), p_lm)
knn_error <- sum_error(log(test_data$Price), p_knn)
rf_error <- sum_error(log(test_data$Price), p_rf)

# Summary Each Model
lm_model
knn_model
rf_model

The 3 model to prediction column price. knn model is good performance but we should select to lm model because lm model have final value and describe easy more than knn model.
