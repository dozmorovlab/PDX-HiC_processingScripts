# K Tyc
# 2020-03-11

#---------------------------

args <- commandArgs(TRUE)
if(length(args) <1) {
  cat("No arguments specified.

      Options:
      -w=set working directory
      -b=/full_path_to/xxx_ord.bed
      -o=outputfile name [e.g. juicer_to_hicpro.matrix]
      ")
  stop("missing arguments")
}

parseArgs <- function(x) strsplit(sub("^-", "", x), "=")
argsDF <- as.data.frame(do.call("rbind", parseArgs(args)))
argsL <- as.list(as.character(argsDF$V2))
names(argsL) <- argsDF$V1

#---------------------------

suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(suppressWarnings(library(data.table)))

#---------------------------

df.bins = read.csv(argsL$b, sep = "\t", header = F)
df.bins$id = paste0(df.bins$V1,"_", df.bins$V2)

#---------------------------

outname = as.character(argsL$o)

#---------------------------

setwd(argsL$w)
chroms_list = list.files(pattern = "\\.txt$")

#---------------------------

dataset <- data.frame()
for (i in 1:length(chroms_list)){
  
  temp_data <- fread(chroms_list[i], stringsAsFactors = F) #read in files using the fread function from the data.table package

  if(dim(temp_data)[1]!=0){
 
  temp_data$chrom = paste0("chr", strsplit(chroms_list[i], "_")[[1]][2])
  temp_data$id1 = paste0(temp_data$chrom, "_", temp_data$V1)
  temp_data$id2 = paste0(temp_data$chrom, "_", temp_data$V2)
  
  temp_merge = merge(temp_data, df.bins, by.x = "id1", by.y = "id")
  temp_merge = temp_merge[ , c("chrom", "V4", "V1.x", "V2.x", "V3.x", "id2")]
  
  temp_merge2 = merge(temp_merge, df.bins, by.x = "id2", by.y = "id")
  temp_merge2 = temp_merge2[ , c("chrom", "V4.x", "V4.y", "V3.x")]

  temp_merge2 = temp_merge2[ order(temp_merge2$V4.x, temp_merge2$V4.y), ]
  
  dataset <- rbindlist(list(dataset, temp_merge2), use.names = T) #for each iteration, bind the new data to the building dataset
 }
}

dataset = na.omit(dataset)

fwrite(dataset[,c("V4.x", "V4.y", "V3.x")], outname, quote = F, row.names = F, col.names = F, sep = "\t")




