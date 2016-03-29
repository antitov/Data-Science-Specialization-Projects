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

g = ggplot(data.frame(smean = smean), aes(smean))
g = g + geom_histogram(fill = "lightblue", color = "black")
g = g + geom_vline(xintercept = 1/lambda, size = 2)
g
dev.off()

```