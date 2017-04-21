# ============================================================
# use data.table to look forward and backward in a dataset

library(data.table)
library(dplyr)

data.DT <- data.table(A=1:5, B=1:5*10, C=1:5*100)

# D is C plus the previous row of B
data.DTX <- data.DT[ , D := C + shift(B, 1L, type="lag")]

# E is C plus the next row of B
data.DTX <- data.DT[ , E := C + shift(B, 1L, type="lead")]

glimpse(data.DT)
glimpse(data.DTX)

# ============================================================
# dplyr examples

library(dplyr)

#   data.days.year <- File.In %>% select(DAY_OF_YEAR, YEAR) %>%
#                            distinct(DAY_OF_YEAR, YEAR) %>%
#                            arrange(DAY_OF_YEAR)

# recode variables with mutate
iris.1 <- iris
iris.2 <- iris %>% mutate(Petal.Length=replace(Petal.Length, 
                                               Species=="setosa", 
                                               1))

iris.3 <- iris %>% mutate(Petal.Length=replace(Petal.Length, 
                                               Species %in% c("setosa"), 
                                               2))

iris.3 <- mutate(iris, Petal.Length = ifelse(Species=="setosa", 3, Petal.Length))

# rename a variable
# Note that the syntax is rename(data, New = Old)
data.Candidates <- rename(data.Candidates, Candidate.Number = Candidate.number)

# change all factors to character
data.Candidates <- data.Candidates %>% mutate_if(is.factor, as.character)

# ============================================================
# RODBC example

library(RODBC)

SqlServer <- "P37\\SQLEXPRESS"
SqlDatabase <- 'TrendData_2011'

SqlConnection <- paste('driver={SQL Server};server=',
                       SqlServer,
                       ';database=',
                       SqlDatabase,
                       ';trusted_connection=true;rows_at_time=1',
                       sep="")

dbhandle <- odbcDriverConnect(SqlConnection)
sqlUpdate <- "select * from tbl_Annual_2015"
myData <- sqlQuery(dbhandle, sqlUpdate)
close(dbhandle)

# ============================================================
# set nas to 0 to make them easier to detect

data.in[is.na(data.in)] <- 0

# ============================================================
# convert a key/value type list into a dataframe

test <- list("1"="Box 1 New.xlsx",
             "2"="Box 2.xlsx",
             "3"="Box 3.xls",
             "7.5"="Box 7.5.xlsx")

test.df <- data.frame(Box.Number=names(test), SourceFile=unlist(test))

# ============================================================
# dates

data.changes$DATE <- as.POSIXct(strptime(paste(data.changes$YEAR.x, 
                                               data.changes$DAY_OF_YEAR.x), format="%Y %j"))

data.changes$MONTH <- as.character(format(as.Date(data.changes$DATE), "%m"))

# ============================================================
# Excel
library(xlsx)

# read from an Excel sheet
data.Candidates <- read.xlsx(paste(WorkDir, File.Candidates, sep=""), 
                             sheetIndex = 2)

# write to Excel
write.xlsx(marks.check, 
           file = paste(WorkDir,"BadTotals.xlsx",sep=""),
           sheetName = "Check", 
           row.names = FALSE)

see - https://www.r-bloggers.com/write-data-frame-to-excel-file-using-r-package-xlsx/

# ============================================================
# Assertr for variable checking
https://cran.r-project.org/web/packages/assertr/vignettes/assertr.html
