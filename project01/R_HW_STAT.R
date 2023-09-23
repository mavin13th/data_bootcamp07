# Load and install library
library(tidyverse)
library(titanic)

# Check detail data titanic
glimpse(titanic_train)

# Data Cleaning
## Drop NA (missing values)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

## Factorizing
titanic_train$Sex <- factor(titanic_train$Sex,
                            levels = c("male", "female"),
                            labels = c(0,1))

# Split Data
set.seed(9)
n <- nrow(titanic_train)
id <- sample(1:n, size = n*0.7) ## 70%train 30%test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

nrow(train_data)
nrow(test_data)

# Train Model
## Train model
m_model <- glm(Survived ~ Pclass + Sex + Age + Parch, data = train_data, family = "binomial") 

## Predict and Evaluate model
train_data$prob_Survived <- predict(m_model,type="response")
train_data$pred_Survived <- ifelse(train_data$prob_Survived >= 0.5, 1, 0)

## Confusion Matrix
(conM <- table(train_data$pred_Survived, train_data$Survived, dnn= c("Predicted", "Actual")))

## Model evaluation
accuracy_train <- (conM[1,1] + conM[2,2]) / sum(conM)
precision_train <- conM[2,2] / (conM[2,1] + conM[2,2])
recall_train <- conM[2,2] / (conM[1,2] + conM[2,2])
f1_train <- 2*(precision_train * recall_train) / (precision_train + recall_train)

cat("Accuracy:", accuracy_train,
    "\nPrecision:", precision_train,
    "\nRecall:", recall_train,
    "\nF1 Score:", f1_train)

# Test Model
# Predict and Evaluate Model
test_data$prob_Survived <- predict(m_model, newdata= test_data, type="response")
test_data$pred_Survived <- ifelse(test_data$prob_Survived >= 0.5, 1, 0)

# Confusion Matrix
(conT <- table(test_data$pred_Survived, test_data$Survived, dnn=c("Predicted", "Actual")))

# Model evaluation
accuracy_test <- (conT[1,1] + conT[2,2]) / sum(conT)
precision_test <- conT[2,2] / (conT[2,1] + conT[2,2])
recall_test <- conT[2,2] / (conT[1,2] + conT[2,2])
f1_test <- 2*((precision_test*recall_test) / (precision_test+recall_test))

cat("Accuracy:", accuracy_test,
    "\nPrecision:", precision_test,
    "\nRecall:", recall_test,
    "\nF1 Score:", f1_test)

# Summary
(df <- data.frame(
  type = c("Train", "Test"),
  accuracy = c(accuracy_train, accuracy_test),
  precision = c(precision_train, precision_test),
  recall = c(recall_train, recall_test),
  f1_score = c(f1_train, f1_test)
))

The result is train accuracy and test accuracy have closed to each other at approximately 79% and 81% respectively
