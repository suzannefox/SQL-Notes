

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
# ============================================================
# RODBC example

library(RODBC)

SqlServer <- "P37\\SQLEXPRESS"
SqlDatabase <- 'RSS_IMIS_TrendData_2011'

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
