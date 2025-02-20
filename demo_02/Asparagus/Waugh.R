
################################################################################
#
# QMB 6912: Capstone Course in Business Analytics
# Example of Characteristic Theory:
# The Price of Asparagus
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# September 9, 2020
#
################################################################################
#
# This program provides an example of characteristic theory
# for the pricing of asparagus, using the data from Waugh, .
#
#
#
################################################################################

# Clear workspace.
# The remove function removes everything in the workspace when the list is all.
rm(list=ls(all=TRUE))

# Load libraries to be used.
library(ggplot2)
library(MASS)
library(mgcv)


# Set working directory.
# The '<-' operator denotes right-to-left assignment.
# wd_path <- '/path/to/your/folder'
# "~/Teaching/QMB6358_Fall_2021/GitRepo/QMB6358F21/demo_07_data_in_R"

wd_path <- '~/Teaching/UCF_BA_Capstones/QMB6912_Spring_2022/GitHub/QMB6912S22/demo_02/Asparagus'
setwd(wd_path)
getwd()


################################################################################
# Load data.
################################################################################

# Version without headers:
# WaughData <- read.table("Waugh.dat", header=FALSE, sep="",
#                         col.names = c("green",
#                                       "nostalks","disperse","price"))
# Version with headers:
WaughData <- read.table("Waugh.dat", header=TRUE, sep="")

# Code below references column names in lower case.
colnames(WaughData) <- c("green", "nostalks","disperse","price")

summary(WaughData)
head(WaughData)

################################################################################
# Empirical Analysis
################################################################################


# Plot the EDF of price, which is saved as a PDF file,
# if you uncomment the pdf() and dev.off() functions.
# pdf(file="EDF-Price.pdf", width=4, height=4)
plot(ecdf(WaughData$price), do.point=FALSE)
# dev.off()


# Plot the histogram of price.
# pdf(file="Histogram-Price.pdf", width=4, height=4)
hist(WaughData$price)
# dev.off()



# Plot the kernel-smoothed density of the price.
sig <- sqrt(var(WaughData$price))
N <- length(WaughData$price)
h <- 1.06 * sig / (N**(1/5))

# pdf(file="KSDensity-Price.pdf", width=4, height=4)
plot(density(WaughData$price, bw=h, kernel="gaussian"))
# dev.off()


# Plot the scatter matrix.
# pdf(file="Waugh-splom.pdf", width=4, height=4)
pairs(WaughData)
# dev.off()


# Calculate regression object.
olsObject <- lm(WaughData$price~WaughData$green +
                  WaughData$nostalks +
                  WaughData$disperse)
summary(olsObject)


################################################################################
# End
################################################################################
