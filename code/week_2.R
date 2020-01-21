# Week 2

x <- 5
y <- x*2 # the output of this is assigned to y. we're not really making a link to the object x here. 

x <- 20
# note: y stays the same, even after changing x! 

y <- x*2 

#don't use equal. use the nice arrow
y = x*3
# we should use assignment arrow instead of equal sign! Taking thing on the right and putting it into the left. Also, equal signs are used to set arguments in functions, and so it's much better to keep the two separate. 

# how R talks back

log_of_word <- log("word")
#we get an error. Non-numeric argument to mathematical function. 
log_of_word
#now it says object not found

# errors stop the whole process and don't give outputs other than the error. 

log_of_negative <- log(-2)
#warning message: NaNs produced. This means "not a number". you can't take the log of a negative number. But now we have a value that pops up in our global environment. 
log_of_negative
#the object exists, but the object is NaN. 
#warnings can happen more subtly than an error, but can be very bad to your script. 

#messages aren't anything to worry about really
message("you guys are doing great")


#can run the function getwd() in console to find out where R thinks I am right now

#you can use set() to set a working directory.

#the best thing about having the working directory being the folding of the R-project itself is the best, especially for sharing projects

# the slack denotes different levels. 

# shortcut ~ . This refers to your username or "home directory" . I could say ~/Desktop/R_DAVIS_2020/r-davis-in-class-project-Mojica

#absolute file path: starts from your user all the way down your file path
#relative file path: coming from working directory


#we should use RELATIVE file paths because they will be maintained if I send this to someone else!!!

# tpye "" in console. Between quotes, hit tab. This will allow you to do relative file paths!

# "../" use this to go up a level in your file path and can look up in your directory folders!!!!!!

# could be "../../" for each level. Hit tab between quotes to search. 

getwd()
"data/"

read.csv("")
