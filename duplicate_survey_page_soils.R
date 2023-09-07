## set environment path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringr)

## read in data and duplicate layer -> and paste into correct location first
## next, sub out guids if needed for each page

## only reading in line 25 of protocol - definition
d_import<- read.delim("www/NRCS Soils 232 Pedon Soil Matrix - Part 2_20230822_142051 - Copy.vgsp",
                      skip = 24, nrows = 1, quote = "")

d<- as.character(d_import)

## EDIT THIS PK_QUESTION INFO BELOW -->
## finding begging of p1 - original
f1<- str_locate_all(pattern ='\\{"PK_Question":"f16652b3-69d0-4754-b8ec-27c2de82065b"', d)

## EDIT THIS PATTERN BELOW FOR LABEL -->
## find end of question section p1
f2<- str_locate_all(pattern ='\\[ SOIL LAYER 1 ]', d)

## Search for Inquiry Ids for each page to paste 2-10 created from labels (on each page)
## must have labels on page pre-made already (InquiryId), match "pages" as well
pages<- c(2:10)
## starts at layer 2 then goes to the rest...
InquiryId<- c("B61cabRDkS","jlPOXtG2ic","JuRmPpRBVF","uV9UQyofRK","P8wd4qkcWY","ZVxByymXTR","ZKQoSyGmml","4QRGIRwV8r","Ict0PtIqQx")

## NESTED INFO BETWEEN QUESTION:[] - WRAPPED IN {}
## THIS SECTION IS BASE THAT GETS EDITED FIRST -->
layer1<- substr(d,f1[[1]][1]+111,f2[[1]][1]-114)

i=1 ## variable for 1st page
while (i < length(InquiryId)+1) {
  
  ## find end of question section p1 / place marker for specific Inq
  a1<- str_locate_all(pattern =InquiryId[i], d)
  
  ## update page number (previous page used)
  old_page<- paste0("Page:",pages-1)
  new_page<- paste0("Page:",pages)
  new_layer <- gsub(pattern = old_page[i], new_layer, replacement = new_page[i])

  ## where to insert info back into original form (d) - DefinitionXML line 25 in file
  insert_pos<- a1[[1]][1]+25
  ## paste together and rename back to d (original data file line 25)
  d<- paste0(substr(d,0,insert_pos-1), layer1, substr(d,insert_pos,nchar(d)))
  
  ## move on to next page/section
  i=i+1
}


sink("www/change_line_24.txt")
cat(d)
sink()


# ## line 1-24 survey
# start<- read.delim("z_Soils232/NRCS_Soils232_Surveys/NRCS Soils 232 Pedon Soil Matrix - Part 2_20230822_142051 - Copy.vgsp",
#                    nrows = 24, header = F, quote = "", sep = "\t")
# start<- as.character(start)
# sink("start.txt")
# cat(start)
# sink()
# ## line 25 -> attribites
# sink("mid.txt")
# cat(d)
# sink()
# ## the rest of it
# end<- read.delim("z_Soils232/NRCS_Soils232_Surveys/NRCS Soils 232 Pedon Soil Matrix - Part 2_20230822_142051 - Copy.vgsp",
#                  skip = 25, quote = "")
# end<- as.character(end)
# sink("end.txt")
# cat(end)
# sink()
# 
# closeAllConnections()
## create protocol as "NEW" --> put all together


