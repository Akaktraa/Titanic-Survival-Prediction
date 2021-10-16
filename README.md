# Titanic-Survival-Prediction
##Self-Project on Titanic-Survival-Prediction##

First, we do some basic EDA to understand the relationships between different predictors and the
 response variable we are interested in that is 'Survived'.

Then we check for missing values using a useful package 'Amelia' through which we get to know
the NA values in our data.

We then find missing values in the Age dataset which we instead of omitting find it using the 
Pclass and mean of the Age for different values of Pclass. 

We then Convert the numeric data types into factors for better results and we select suitable 
predictors for our response using the information we got in EDA.

We then Apply logistic regression to our data and optimize the model using the backward
stepwise selection.

After that, we do predictions on test data and submit our predictions on Kaggle for Accuracy.
We get 76.08% accuracy.

-------------------------------------------------------------------------------------------------