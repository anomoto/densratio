## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE)
library(mvtnorm)

## ------------------------------------------------------------------------
set.seed(3)
x <- rnorm(200, mean = 1, sd = 1/8)
y <- rnorm(200, mean = 1, sd = 1/2)

library(densratio)
result <- densratio(x, y)

## ----fig.width=5, fig.height=4-------------------------------------------
new_x <- seq(0, 2, by = 0.05)
w_hat <- result$compute_density_ratio(new_x)

plot(new_x, w_hat, pch=19)

## ----fig.width=5, fig.height=4-------------------------------------------
true_density_ratio <- function(x) dnorm(x, 1, 1/8) / dnorm(x, 1, 1/2)

plot(true_density_ratio, xlim=c(-1, 3), lwd=2, col="red", xlab = "x", ylab = "Density Ratio")
plot(result$compute_density_ratio, xlim=c(-1, 3), lwd=2, col="green", add=TRUE)
legend("topright", legend=c(expression(w(x)), expression(hat(w)(x))), col=2:3, lty=1, lwd=2, pch=NA)

## ----eval=FALSE----------------------------------------------------------
#  install.packages("densratio")

## ----eval=FALSE----------------------------------------------------------
#  install.packages("devtools") # If you have not installed "devtools" package
#  devtools::install_github("hoxo-m/densratio")

## ----eval=FALSE----------------------------------------------------------
#  library(densratio)
#  
#  x <- rnorm(200, mean = 1, sd = 1/8)
#  y <- rnorm(200, mean = 1, sd = 1/2)
#  
#  result <- densratio(x, y)

## ----fig.width=5, fig.height=4-------------------------------------------
new_x <- seq(0, 2, by = 0.05)
w_hat <- result$compute_density_ratio(new_x)

plot(new_x, w_hat, pch=19)

## ------------------------------------------------------------------------
print(result)

## ------------------------------------------------------------------------
library(densratio)
library(mvtnorm)

set.seed(71)
x <- rmvnorm(300, mean = c(1, 1), sigma = diag(1/8, 2))
y <- rmvnorm(300, mean = c(1, 1), sigma = diag(1/2, 2))

result <- densratio(x, y)
result

## ----fig.width=7, fig.height=4-------------------------------------------
true_density_ratio <- function(x) {
  dmvnorm(x, mean = c(1, 1), sigma = diag(1/8, 2)) /
    dmvnorm(x, mean = c(1, 1), sigma = diag(1/2, 2))
}

N <- 20
range <- seq(0, 2, length.out = N)
input <- expand.grid(range, range)
w_true <- matrix(true_density_ratio(input), nrow = N)
w_hat <- matrix(result$compute_density_ratio(input), nrow = N)

par(mfrow = c(1, 2))
contour(range, range, w_true, main = "True Density Ratio")
contour(range, range, w_hat, main = "Estimated Density Ratio")

