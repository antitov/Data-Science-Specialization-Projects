---
  title: "statistical-inference-course-project"
output: 
  html_document:
  keep_md: true
---
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=TRUE, cache=FALSE,  warning=FALSE, results="hide")
options(scipen = 1, digits = 2)
```

## Loading and preprocessing the data
We are loading **data.table** for fast data handling and **ggplot2**. 
Also we change system time display to English by **Sys.setlocale**.
```{r Locale and Libraries}
Sys.setlocale("LC_TIME", "English")
library(data.table)
library(ggplot2)

## Playing with exponential distribution
Calculating sample mean and comparing it to theroretical one

```{r}
smean = NULL
lambda <- 0.2
nexp <- 50
n <- 1000
for (i in 1:n) smean <- c(smean, mean(rexp(nexp, lambda)))
simumean <- mean(smean)
simusd <- sd(smean)
```

# Question 1. Show the sample mean and compare it to the theoretical mean of the distribution


We create data.frame of Sample and Theoretical means
bothmeans <- data.frame(Mean=c("Sample","Theoretical"), vals = c(simumean,1/lambda))

g = ggplot(data.frame(smean = smean), aes(smean))
g = g + geom_histogram(aes(y = ..density..), fill = "lightgrey", colour = "black") 
g = g +  geom_vline(data = bothmeans, aes(xintercept = vals, color = Mean, linetype = Mean), size = 1)
# g = g + geom_vline(aes(xintercept = 1/lambda, color = "Theoretical Mean" ), size = 1) +
#       geom_vline(aes(xintercept = simumean, color = "Sample Mean"), size = 1, linetype = 2)
g = g +  theme(panel.background = element_rect(fill = 'white'), legend.position = "bottom")
g = g + labs(x="Mean", y="Density", title="50 samples of Exponential distribution mean")
g
# Question 2. Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
Generating sample variance
var <- apply(matrix(rexp(n * nexp, lambda), n), 1, var)

g = ggplot(data.frame(var = var), aes(var))
g = g + geom_histogram(aes(y = ..density..), fill = "lightblue", color = "black") + 
  stat_function(fun = dnorm, size = 2, args = list(mean = (1/lambda)^2, sd = sd(var)))
g = g + geom_vline(xintercept = (1/lambda)^2, size = 2)
g
dev.off()
# Question 3. Show that the distribution is approximately normal.

g = ggplot(data.frame(smean = smean), aes(smean))
g = g + geom_histogram(aes(y = ..density..), fill = "lightgrey", colour = "black") + 
      stat_function(fun = dnorm, size = 1, args = list(mean = simumean, sd = simusd), aes(color="Theoretical density") ) +
      geom_density( size=1, aes(color="Simulation density"), linetype = 2) +
      scale_color_manual(values=c("Simulation density" = "blue", "Theoretical density" = "red"), 
                        name="Experimental vs Theroretical\nComparison") +
      guides(colour = guide_legend(override.aes = list(linetype=c(2,1))), 
             fill = guide_legend(override.aes = list(colour = NULL)))
      
g = g + geom_vline(xintercept = simumean, size = 1)
g = g +  theme(panel.background = element_rect(fill = 'white'), legend.position = "bottom")
g = g + labs(x="Mean", y="Density", title="50 samples of Exponential distribution mean")
g
dev.off()








```