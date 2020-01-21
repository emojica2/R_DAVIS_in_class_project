# Vectors!

x <- 5
# this is just a vector of length 1
# we will work with bigger vectors that build up
# we use the c() function

weight_g <- c(50, 60, 65, 82)
#this is reported back in console. printed similarly to x in console. 
# now we have a vector in our environment. it goes from 1:4. One to four. 

animals <- c("mouse", "rat", "dog")

# you can use single or double quotes. 

# every element in a vector needs to be the same TYPE of data! (character, number, etc.) Use the class function to ask this

class(weight_g)
# the answer is "numeric". cool

class(animals)
# get back "character"

#Str for structure. 
str(weight_g)
str(animals)

# we can modify vectors with the c() function

c(weight_g, 90)
c(50, 60, 65, 82, 90)

weight_g <- c(weight_g, 90)
weight_g <- c(30, weight_g)
weight_g

# Atomic vectors. called this because they're the lowest matter in R. Vectors make everything up. They're a linear value. and it's a vector of a single TYPE of data. We've seen character and numeric vector. Numeric vectors can be referred to as "double" because they can have a decimal. The other two types are logical (true and false values) and integer. Integer values can only have whole, round numbers in it. This is represented with an L. 2L, for example, means exactly 2. 

class(1:10)
# the colon is a shortcut for making a sequence

x <- 1:10
# now it says integer. 


## Coercion Challenge

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

# this is called coercion. We can only allow one type of data in a vector. If they aren't, R will coerce them to be the same type. 

# Any character in a vector will turn the whole vector into characters!!!!!!! 


## CHALLENGE 2

combined_logical <- c(num_logical, char_logical)
combined_logical
# only one value is "TRUE", even though there were originally two. This is because one of the TRUE's was coerced to a 1. This is because they went through different pathways of coercion. 

class(combined_logical)




## subsetting vectors

animals <- c("mouse", "rat", "dog", "cat")
animals[2]
# when you subset a vector, what you get back is another vector. 

animals[c(3, 2)]

animals[c(3, 2, 4, 1, 2, 1)]

animals[0]
#R doesn't start at 0, it starts at 1. I guess python starts at 0. 


## conditional subsetting

weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)]
# it only gives us back the entries that have "TRUE" for them

weight_g > 50

weight_g[weight_g > 50]
# first it will just do logical values
# then the logical values will be put into weight_g again
# it'll give us back numbers!


# multiple operations at once
weight_g[weight_g < 30 | weight_g > 50]
# or is |

weight_g[weight_g >= 30 & weight_g == 21]
# this is a problem because a number can't be both of these
# the answer is numeric(0)

animals

animals[animals == "cat" | animals == "rat"]

animals %in% c("mouse", "rat")
#this asks if the values of the lefthand side are found anywhere in the righthand side
# gives us back a logical vector. we can put this inside brackets

animals[animals %in% c("mouse", "rat")]


## Challenge

"four" > "five"
"six" > "four"
"eight" > "six"
"alpha" > "beta"
"dog" > "cat"
"b" > "a"

# characters are ranked in alphabetical order



## Vector math

x <- 1:10

x + 3
# it does element by element. 
x * 10

y <- 100:109
x + y
# takes the first value in x and adds it to the first value in y

z <- 1:2
#try adding vectors that aren't the same length

x + z
# this is a behavior in R called vector recycling! R needs vectors of same length. it just pretends that z is longer, going 1, 2, 1, 2, 1, 2, 1, 2 until it's the length of x. 


z <- 1:3

x + z
# 10 is not a multiple of 3. the warning message is "longer object length is not a multiple of shorter object length"

a <- x + z
# even though we got the warning message, we were still able to make a. we have the recycling behavior again, plus some partial recycling. 
# this could happen and you could never know it's happening! Maybe your vectors are not the same size but you thought they were. 
# this is why we check the structure of x and z!!!

str(x)
length(x)
length(z)
str(z)

# if we check these and they're difference, we should know something is up


## Recycling with conditional subsetting
x[c(TRUE, FALSE)]
# we just get back the odd values because this conditional vector gets recycled as well

x[c(TRUE, FALSE, FALSE)]
# if you ask a weird condition, you can get back values that you maybe don't expect. 




## Working with missing data

# In R, missing data are represented as NAs

heights <- c(2, 4, 4, NA, 6)

mean(heights)
max(heights)
# so we have to remove the NAs before calculating the mean. 
# na.rm = NA Remove

mean(heights, na.rm = TRUE)
#now we get a number! It removed the NA and calculated the mean. 
max(heights, na.rm = TRUE)

# is.na = Is it a NA?

is.na(heights)

# ! = is not

!is.na(heights)
# this says "is not an NA". get back logical values

heights[!is.na(heights)]
# in this heights vector, is it an NA? if it's not, give it back to me. 

heights[is.na(heights)]


## Complete.cases = extracting all the elements that are complete cases (are not NAs)

heights[complete.cases(heights)]

## CHALLENGE

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
median(heights, na.rm = TRUE)
sum(heights > 67, na.rm = TRUE)

# or

heights2 <- heights[complete.cases(heights)]
str(heights2)

median(heights2)
# longer than 67 inches

length(heights2[heights2 > 67])

heights2[heights2 > 67]


# a list is a bunch of vectors put together and those vectors CAN be different lengths. 

# a data.frame is the thing you will be most used to looking at. Most common. It's just a picky list. It's a bunch of lists that all need to be the same length



# Factors are a bit funky
# used to represent categorical data

sex <- factor(c("male", "female", "female", "male"))
class(sex)
#now it's a factor, not a character. 
typeof(sex)
# Factors can only contain a predefined number of values
# first level is female (alphabetical), second level is male. we can force this to be different

levels(sex)
nlevels(sex)
# this is number of levels

# specify the order of the levels
sex <- factor(sex, levels = c("male", "female"))
str(sex)
sex

# 1 is male and 2 is female. as integers of a factor


# making factors into characters

sex_ch <- as.character(sex)
str(sex_ch)
