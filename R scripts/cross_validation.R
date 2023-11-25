# This script is for cross validation of the previous model
# In previous model, positive data and negative data were first merged and then
## divided into test and train on the merged "all_data".

### Now, first divide positive and negative data each into Train and Test and 
### then merge positive train + negative train, similarly pos. test + pos. train

# previous recap:
length(tr.idx)
length(te.idx)

length(positive_data)
length(negative_data)

dim(all_positive)
dim(all_negative)
dim(all_data)
dim(model_data)

# Checking how many positive and negative data are in tr.idx and te.idx
## from training
tr.positive <- all_positive[1:nrow(all_positive) %in% tr.idx, ]
tr.negative <- all_negative[(nrow(all_positive)+1):nrow(model_data) %in% tr.idx, ]

## from test
#te.positive <- all_positive[te.idx %in% 1:nrow(all_positive), ]
#te.negative <- all_negative[te.idx %in% (nrow(all_positive) + 1):nrow(model_data), ]

te.positive <- all_positive[te.idx %in% 1:nrow(all_positive), ]
te.negative <- all_negative[(te.idx %in% (nrow(all_positive) + 1):(nrow(all_positive) + 
                                                                  nrow(all_negative))), ]

# Print the number of positive and negative data in train and test data
cat("Train data:\n")
cat("Positive data: ", nrow(tr.positive), "\n")
cat("Negative data: ", nrow(tr.negative), "\n")

cat("\nTest data:\n")
cat("Positive data: ", nrow(te.positive), "\n")
cat("Negative data: ", nrow(te.negative), "\n")

# Somehow the test data count is not matching. Need to recode te.positive and te.negative
## although te.idx is okay = 60. So te.positive should be 20, te.negative 40.

#..........................................................................................

## Split positive into train and test
dim(all_positive)

# train_positive: 78, test_positive: 20
set.seed(123) #seed for reproducibility

train_idx <- sample(seq_len(nrow(all_positive)), round(0.8 * nrow(all_positive)))
train_positive <- all_positive[train_idx, ]
test_positive <- all_positive[-train_idx, ]
dim(train_positive)
dim(test_positive)

## Split negative into train and test
dim(all_negative)
#train_negative: 158, test_negative: 40
train_neg_idx <- sample(seq_len(nrow(all_negative)), round(0.8 * nrow(all_negative)))
train_negative <- all_negative[train_neg_idx, ]
test_negative <- all_negative[-train_neg_idx, ]
dim(train_negative)
dim(test_negative)

all.tr.idex <- c(train_idx, train_neg_idx)
length(all.tr.idex)

test_idx <- setdiff(1:nrow(all_positive), train_idx)
test_neg_idx <-setdiff(1:nrow(all_negative), train_neg_idx)
all.te.idx <- c(test_idx, test_neg_idx)
length(all.te.idx)



#merge all train (pos+neg) and test (pos+neg) data
all.tr <- rbind(train_positive, train_negative)
all.te <- rbind(test_positive, test_negative)

dim(all.tr)
dim(all.te)
head(all.te)
View(all.te)
nrow(all.te)

## Model building
summary(all.tr)
summary(all.te)

dim(all.tr)
dim(all.te)

#labeling
length(positive_data)
length(negative_data)
new_model_lebels <- as.factor(c(rep(0, length(positive_data)),
                            rep(1, length(negative_data))))

length(train_idx)
dim(all.tr)
dim(all.te)
length(all.tr.idex)
length(all.te.idx)

new_x.tr <- model_data[all.tr.idex, ]
new_x.te <- model_data[all.te.idx, ]
new_y.tr <- new_model_lebels[all.tr.idex]
new_y.te <- new_model_lebels[all.te.idx]
dim(new_x.tr)
dim(new_x.te)
length(new_y.tr)
length(new_y.te)


## Random Forest
library(randomForest)
cross_rf.fit <- randomForest(new_x.tr, new_y.tr, cv.fold = 5)
cross_rf.fit

# print previous rf.fit
rf.fit

# prediction on test
cross_rf.pred <- predict(cross_rf.fit, newdata = new_x.te, type = "prob")[, 1]
cross_rf.pred

# ROC plot
library(caret)
library(pROC)
plot.roc(new_y.te, cross_rf.pred, grid = TRUE, print.auc = TRUE)

# Confusion matrix for test data
#confusionMatrix(new_y.te, new_x.te)
#?confusionMatrix

# Use threshold value, first 0.5 and then 0.3.
# Not running with > 0.5. 
#error: "The data must contain some levels that overlap the reference

cross_rf.pred
new_rf.pred

mean(cross_rf.pred)
mean(new_rf.pred)
range(cross_rf.pred)
range(new_rf.pred)


# Set threshold
threshold <- 0.33
#calcuate predicted labels
predicted_labels <- as.numeric(cross_rf.pred > threshold)
predicted_labels
new_y.te #check the actual labels.

# calculate no. of TP, TN, FP, FN
TP <- sum(predicted_labels == 1 & new_y.te == 1)
TN <- sum(predicted_labels == 0 & new_y.te == 0)
FP <- sum(predicted_labels == 1 & new_y.te == 0)
FN <- sum(predicted_labels == 0 & new_y.te == 1)

# Calculate the accuracy, sensitivity, specificity, and MCC
accuracy <- (TP + TN) / length(new_y.te)
accuracy
specificity <- TN / (TN + FP)
specificity
MCC <- ((TP * TN) - (FP * FN)) / sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN))
MCC


#........................................................................................
# REPEAT-1
# Set threshold
threshold1 <- 0.43
#calcuate predicted labels
predicted_labels1 <- as.numeric(cross_rf.pred > threshold1)
predicted_labels1
new_y.te #check the actual labels.

# calculate no. of TP, TN, FP, FN
TP1 <- sum(predicted_labels1 == 1 & new_y.te == 1)
TN1 <- sum(predicted_labels1 == 0 & new_y.te == 0)
FP1 <- sum(predicted_labels1 == 1 & new_y.te == 0)
FN1 <- sum(predicted_labels1 == 0 & new_y.te == 1)

# Calculate the accuracy, sensitivity, specificity, and MCC
accuracy1 <- (TP1 + TN1) / length(new_y.te)
accuracy1
specificity1 <- TN1 / (TN1 + FP1)
specificity1
MCC1 <- ((TP1 * TN1) - (FP1 * FN1)) / sqrt((TP1 + FP1) * (TP1 + FN1) * (TN1 + FP1) * (TN1 + FN1))
MCC1





#........................................................................................
# REPEAT-2
# Set threshold
threshold2 <- 0.50
#calcuate predicted labels
predicted_labels2 <- as.numeric(cross_rf.pred > threshold2)
predicted_labels2
new_y.te #check the actual labels.

# calculate no. of TP, TN, FP, FN
TP2 <- sum(predicted_labels2 == 1 & new_y.te == 1)
TN2 <- sum(predicted_labels2 == 0 & new_y.te == 0)
FP2 <- sum(predicted_labels2 == 1 & new_y.te == 0)
FN2 <- sum(predicted_labels2 == 0 & new_y.te == 1)

# Calculate the accuracy, sensitivity, specificity, and MCC
accuracy2 <- (TP2 + TN2) / length(new_y.te)
accuracy2
specificity2 <- TN2 / (TN2 + FP2)
specificity2
MCC2 <- ((TP2 * TN2) - (FP2 * FN2)) / sqrt((TP2 + FP2) * (TP2 + FN2) * (TN2 + FP2) * (TN2 + FN2))
MCC2









































