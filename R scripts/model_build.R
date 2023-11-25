# Model by Random Forest

# read file # get data
dim(all_positive)
dim(all_negative)
dim(all_data)

# sequence data
length(positive_data)
length(negative_data)

# transpose all_data # row-wise all 296 pos+neg seqs #column wise properties

model_data <- t(all_data)
dim(model_data)

#labeling

model_lebels <- as.factor(c(rep(0, length(positive_data)),
                            rep(1, length(negative_data)))) 

# divide train and test

set.seed(123)
#create train data-set (tr.idx)
tr.idx <- c(
  sample(1:nrow(all_positive), round(nrow(all_positive) * 0.8)),
  sample(nrow(all_positive) + 1:nrow(all_negative), round(nrow(all_negative) * 0.8))
)
#create test data
te.idx <- setdiff(1:nrow(model_data), tr.idx)
length(tr.idx)  
length(te.idx)  

x.tr <- model_data[tr.idx, ]
x.te <- model_data[te.idx, ]
y.tr <- model_lebels[tr.idx]
y.te <- model_lebels[te.idx]

# Model Building # Random Forest

library(randomForest)
rf.fit <- randomForest(x.tr, y.tr, cv.fold = 5)
rf.fit

# Run on test
rf.pred <- predict(rf.fit, newdata = x.te, type = "prob")[, 1]
rf.pred

# Plot ROC
library(pROC)
plot.roc(y.te, rf.pred, grid = TRUE, print.auc = TRUE)

# confusion matrix
library(caret)
confusionMatrix(table(rf.pred, rf.fit))









  
  
  
  
  
  

