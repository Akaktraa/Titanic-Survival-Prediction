train <- read.csv('titanic_train.csv')
test <- read.csv('titanic_test.csv')
#EDA
library(ggplot2)
str(train)
ggplot(train,aes(Survived)) + geom_bar()
ggplot(train,aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)),alpha=0.7)
ggplot(train,aes(Sex)) + geom_bar(aes(fill=factor(Sex)),alpha=0.7)
ggplot(train,aes(Age)) + geom_histogram(fill='blue',bins=20,alpha=0.7)
ggplot(train,aes(SibSp)) + geom_bar(fill='red',alpha=0.7)
ggplot(train,aes(Fare)) + geom_histogram(fill='green',color='black',alpha=0.7)
ggplot(train,aes(Pclass,Age)) + geom_boxplot(aes(group=Pclass,fill=factor(Pclass),alpha=0.7)) 
#Check for missing values
library(Amelia)
missmap(train)
#Imputed Missing Values
for (i in 1:length(train$Survived)) {
  if (is.na(train$Age[i])&(train$Pclass[i]==1)) {
    train$Age[i]= mean(train[train$Pclass==1,]$Age,na.rm = T)
  }else if (is.na(train$Age[i])&(train$Pclass[i]==2)) {
    train$Age[i]= mean(train[train$Pclass==2,]$Age,na.rm = T)
  }else if (is.na(train$Age[i])&(train$Pclass[i]==3)) {
    train$Age[i]= mean(train[train$Pclass==3,]$Age,na.rm = T)
  }
}
# converted some numeric data in factors
train$Survived <- factor(train$Survived)
train$Pclass <- factor(train$Pclass)
train$Parch <- factor(train$Parch)
train$SibSp <- factor(train$SibSp)
train$Sex <- factor(train$Sex)
library(dplyr)
train <- select(train,-PassengerId,-Name,-Ticket,-Cabin)
#Apply Logistic Regression

my_model <- glm(formula=Survived ~ . , family = binomial(link='logit'),data = train)
summary(my_model)
#Apply Backward Stepwise Selection
my_model <- step(my_model,direction = 'backward')
# Now we do prediction on Test data
for (i in 1:length(test$Pclass)) {
  if (is.na(test$Age[i])&(test$Pclass[i]==1)) {
    test$Age[i]= mean(test[test$Pclass==1,]$Age,na.rm = T)
  }else if (is.na(test$Age[i])&(test$Pclass[i]==2)) {
    test$Age[i]= mean(test[test$Pclass==2,]$Age,na.rm = T)
  }else if (is.na(test$Age[i])&(test$Pclass[i]==3)) {
    test$Age[i]= mean(test[test$Pclass==3,]$Age,na.rm = T)
  }
}
test$Pclass <- factor(test$Pclass)
test$Parch <- factor(test$Parch)
test$SibSp <- factor(test$SibSp)
test$Sex <- factor(test$Sex)
pred_prob <- predict(my_model,test,type = 'response')
pred_survived <- ifelse(pred_prob>0.5,1,0)
PassengerID <- test$PassengerId
Survived <- pred_survived
df1 <- data.frame(PassengerID,Survived)
write.csv(df1,file = 'My_Submission.csv',row.names = F)

