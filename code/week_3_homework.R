set.seed(15)
hw3 <- runif(50, 4, 50)
hw3 <- replace(hw3, c(4,12,22,27), NA)
hw3

# Problem 1: Take you hw3 vector and removed all the NAs then select all the numbers between 14 and 38 inclusive, call this vector prob1.

hw3_rem <- hw3[!is.na(hw3)]
prob1 <- hw3_rem[hw3_rem >= 14 & hw3_rem <= 38]

# Problem 2: Multiply each number in the prob1 vector by 3 to create a new vector called times3. Then add 10 to each number in your times3 vector to create a new vector called plus10.

times3 <- (prob1 * 3)
plus10 <- (times3 + 10)

# Problem 3: Select every other number in your plus10 vector by selecting the first number, not the second, the third, not the fourth, etc.

final <- plus10[c(TRUE, FALSE)]
final
