# Read in the file
snf <- read.csv(file="http://jakeporway.com/teaching/data/snf_4.csv", as.is=T, h=T)

#explore the data a little
names(snf)
#hmmm what are the 'period_stop' and 'period_obs' variabels?
head(snf)
head(rev(sort(snf$time)))
#looks like we're looking at one moth of data from Nov, 2011

# PART ONE 
# Make a “height” column for your data that is the total number of inches tall each 
# person is.

snf$height <- (snf$feet * 12) + snf$inches

# Plot and describe the variables “height”, “weight”, “period_obs”, and 
# “period_stop”.  Use terms that we learned this lesson – talk about the centers of 
# the distributions, their shapes, and whether they’re skewed or not.  If they’re very 
# skewed, try plotting a smaller subset of the data and describing that (e.g. all 
# values less than 50).

lessthan.40 <- snf[snf$period_obs < 40 & snf$period_stop < 40, ]

par(mfrow=c(4,1))
hist(snf$height, breaks=100, main="Histogram of Heights", xlab="Height (in inches)")
hist(snf$weight, breaks=100, main="Histogram of Weight", xlab="Weight (in lbs)")
hist(lessthan.40$period_obs, breaks=500, main="Histogram of Period Observed", xlab="Period Observed (in minutes)")
hist(lessthan.40$period_stop, breaks=500, main="Histogram of Period Stopped", xlab="Period Stopped (in minutes)")

ltfobs <- lessthan.40$period_obs
ltfst <- lessthan.40$period_stop


# PART TWO
# 1. Create a subset of the data where period_obs and period_stop are less than 40.
lessthan.40 <- snf[snf$period_obs < 40 & snf$period_stop < 40, ]

# 2. Create a jittered() scatterplot of the data.  What do you see?
plot(jitter(ltfobs), ltfst, main="Scatterplot of Time Observed vs Time Stopped", xlab="Time Observed", ylab="Time Stopped")

#Build a linear model predicting the period_stop variable from period_obs.  What is 
# the slope of your model?  Based on your intuition, would you say this is a good 
# model? 

#3. Build a linear model predicting the period_stop variable from period_obs.  What is 
# the slope of your model?  Based on your intuition, would you say this is a good 
# model?
linear.model <- lm(ltfst ~ ltfobs)

# Call:
# lm(formula = ltfst ~ ltfobs)

# Residuals:
#    Min     1Q Median     3Q    Max 
# -6.866 -2.188 -0.280 -0.188 32.812 

# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 5.095630   0.018632  273.49   <2e-16 ***
# ltfobs      0.092358   0.005092   18.14   <2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

# Residual standard error: 3.524 on 57876 degrees of freedom
# Multiple R-squared: 0.005651,	Adjusted R-squared: 0.005634 
# F-statistic: 328.9 on 1 and 57876 DF,  p-value: < 2.2e-16 

#plot the model
abline(linear.model)

slope <- linear.model$coefficients[[2]]
intercept <- linear.model$coefficients[[1]]

# 4. Using your model, predict how long you expect someone to be stopped if they’re 
# observed for 5 minutes.
obs.time <- 5
prediction <- obs.time*slope + intercept
# A: 5.557419

# 5. Using your model, predict how long you expect someone to be stopped if they’re 
# observed for 60 minutes.  Even though we built the model only on data for 
# periods < 40, we do have some data for when people were observed for 60 
# minutes.  Compute the mean for those period_stops where period_obs = 60. 
obs.time <- 60
prediction <- obs.time*slope + intercept
# A: 10.63709

#PART THREE
height <- snf$height
max(height)
#A: 95 inches, or 7'11
min(height)
#A: 36 inches

weight <- snf$weight
max(weight)
#A: 999 lbs
min(weight)
# A:1 lbs

# 2 Trim your data to exclude extreme height or weight values.  Write down what 
# threshold you used.
# A: hmmmm I think the min height is ok, but the max is probably too high.  
# Also the min weight is probably too samll, and the max weight definitely is.
# I'll go with 3ft min height and 7 ft max height, and 80 lb min weight and 400lb max weight 
reasonable <- snf[snf$height < 84 & (snf$weight > 80 & snf$weight < 400), ]

# 1. Create a scatterplot of the height and weight variables.  Jitter() or use 
# transparency() so we can see where the bulk of the data lies.
plot(jitter(reasonable$weight), reasonable$height, main="Scatterplot SNF Heights vs Weights", xlab="Weight", ylab="Height")

# 3. Run a linear model predicting weight from height.  What is the slope of that 
# model?
linear.model <- lm(reasonable$weight ~ reasonable$height)
#A: 0.05026

slope <- lm$coefficients[[2]]
intercept <- lm$coefficients[[1]]

# 4. How much do you expect someone who’s 6’ 0” to weight?
obs.height <- 72
prediction <- obs.height*slope + intercept
#A 183.5693
