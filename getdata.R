#Configuration

#location on the web of our zip file
source.web <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
source.local <- tail(unlist(strsplit(source.web,split="/")),n=1)

#new datafile name based on our filtering criteria
data.file <- "assignment1.txt"


#convenience file to read in data to 
#avoid repeating file reading code
get.data <- function(){
  
  #download our file if we don't have it
  if (!file.exists(source.local)) {
    download.file(source.web, source.local)
  }
  
  #get the actual filename from the unzipped version
  source.unzip <- unzip(source.local, list=T)$Name
  
  #rewrite a filtered version of the unzipped file to data.file
  file.connection <- file(source.unzip, "r")
  
  cat(grep("(^Date)|(^[1|2]/2/2007)",
           readLines(file.connection), 
           value=TRUE), 
      sep="\n", 
      file=data.file)
  
  close(file.connection)  
  
  # Now read the full file
  read.table(data.file, header=T, sep=";", na.strings="?")
}