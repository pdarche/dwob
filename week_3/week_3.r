# PART 1

#read in the data
tweets <- read.csv(file="~/desktop/dwob/week_3/libya_tweets.csv")

# Q: I’m always curious about people who have high follower counts, because they 
# might be interesting people tweeting about this topic.  How many unique users 
# have more than 100,000 followers?  
# A: 13

over.100k.followers <- unique(tweets[tweets$followers >= 100000,])
over.100k.screen.names <- nrow(unique(over.100k.followers$screen_name))

# Q: What are their screen names?
# A: detikcom       DonLemonCNN    HuffingtonPost Dputamadre     WorldRss       AlMasryAlYoum 
# theobscurant   fadjroeL       TPO_Hisself    CAPAMAG        TwittyAlgeria  foxandfriends 
# PranayGupte 
over.100k.screen.names <- unique(over.100k.followers$screen_name)

# Q:  It’d be interesting to see what part of the world users are tweeting from.  What 
# are the top 3 locations people are from (not counting blanks)?
# A: USA    Tripoli, Libya   London 
# 	 34	 	28				  20 

loc.without.blanks <- tweets[tweets$location != '',]
location <- rev(sort(table(loc.without.blanks$location)))[1:3]

# Q: Retweets can often indicate what’s important, or at least influential.  What is the 
# text of the tweet that was retweeted the most times and who tweeted it?
# A: RT @DennisDMZ: So let me get this straight. There's a War on Women but no War on Terror? Hey guys, little less focus on the labia little ...
most.retweeted.tweet <- tweets[tweets$retweet_count == max(tweets$retweet_count),]
most.retweeted.tweet <- most.retweeted.tweet$text

# Plot the distribution of the number of people the users are following (don’t 
# worry about the fact that some people will be counted multiple times – just pretend each 
# row is a different user).  NOTE:  We don’t want to use table() here because we don’t 
# want to know how many people had exactly 4014 followers, for example, we just want to 
# see the overall distribution, so use hist() to plot the distribution of “following”.  What do 
# you see?

following <- rev(sort(tweets$following))
barplot(following, xlab="user", ylab="number following", main="number of users each tweet author is following")

followers <- rev(sort(tweets$followers))
barplot(followers, xlab="user", ylab="number of followers", main="number of followers")

# Huh, it looks like there are a few people with LOTS of followers who are 
# skewing our distribution, making it hard to look at the bulk of the data.  It’s probably 
# those people from the first question.  Let’s reduce our set to just people with fewer than 
# 5000 followers and look at the histogram again.  What do you see now?  Have you tried 
# using different breaks?  Does anything surprise you?

