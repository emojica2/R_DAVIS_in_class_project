# R-DAVIS 2020 Week 1

1 + 100

#r uses the order of operation

3 + 5 * 2

#use parentheses to force order of operations

(3 + 5)*2

#r doesn't read white space
3+5
3 + 5

#this is a comment

#r uses scientific notation

2 / 10000

1e9 * 8
#the answer is returned in scientific notation

#functions in R

sin(3.14)
log(3)
exp(1/2)
#that's the exponenet of 1/2

#you can also nest functions. Functions are determined from the inside out. 

sqrt(exp(4))

#Comparisons in R

#R can do logical comparisons

1 == 1
# == means "is equal to"
# the answer to this in the console is "TRUE"

1 == 3

1 != 2
# != means "is not equal to"



#Objects and assignments in R

x <- 1/4
# <- is the assignment arrow
# now you can see x in your environment

log(x)
# you can also overwrite your objects

x <- 99
# now R will not remember that x was once 1/4

x <- x + 1

y <- x * 10

#we can name our objects anything...

this_is_my_object <- 90

#there can't be any spaces or numbers in an object
#It's a good idea to give descriptive object names

log(this_is_my_object) # tab completion

#every function in R is in the help window!

# write "?log" in the console. It will then show up in the help window. 

log(3, 10)
log(x = 3, base = 10) #this line of code is the same as above

log(10, 3) #this is not the same as above. It's evaluating ten, not three. 

log(base = 10, x = 3) #if you're writing out the arguments, the order doesn't matter anymore

log(x = 10, base = 3) #use can use tab once you write log( and it helps you fill out the function

log(aword)
#this gives me an error. R needs something numerical in that log function
#Error messages are good things to google!!!

