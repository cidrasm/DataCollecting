library(plyr)
library(dplyr)
activities <- read.table("activity_labels.txt")
varnames <- read.table("features.txt")

buildDF <- function(dirname) {
  dsMeas <- read.table(file.path(dirname, paste0("X_", dirname, ".txt")))
  names(dsMeas) <- make.names(varnames$V2, unique=TRUE, allow_=TRUE)
  
  dsAct <- read.table(file.path(dirname, paste0("y_", dirname, ".txt")))
  dsAct$V1 <- factor(dsAct$V1, labels = activities$V2)
  dsAct <- rename(dsAct, activity = V1)
  
  subs <- read.table(file.path(dirname, paste0("subject_", dirname, ".txt")))
  subs <- rename(subs, subject = V1)
  
  head(dsMeas)
  dsMeas.f <- select(dsMeas, contains(".mean."), contains(".std."))
  cbind(dsMeas.f, subs, dsAct)
}

message("Munging Training Data")
train <- buildDF("train")
message("Munging Test Data")
test <- buildDF("test")
fullData <- rbind(train, test)
fullData <- group_by(fullData, subject, activity)
t <- ddply(fullData, c('subject','activity'), function(x) sapply(select(x, -activity, -subject), mean))
write.table(t, "./dataset.txt", row.names = FALSE)
message("Wrote dataset.txt")
