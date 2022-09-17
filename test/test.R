# CompareListsOfCodes
#CompareListsOfCodes is useful to assess whether an assigned concept set will retrieve the same concept set dataset, or not.
# 
# Purpose
# The function CompareListsOfCodes takes as input two lists of codes, or two multi-level lists of codes associated to multiple coding systems, and checks whether all the codes in the second list are children of the first, or if there are additional codes.If the latter is the case, the list of aditional codes is generated.
# 
# Structure of input
# Input is a pair of lists, possibly multi-level lists indexed on a coding system, such as ICD9 or ATC.
# concept_set_A a list of codes or if multi == T, a 2-level list of codes, each associated to a coding system
# concept_set_B a list of codes or if multi == T, a 2-level list of codes, each associated to a coding system
# multi (default = F) if this is TRUE, concept_set_A and concept_set_B are 2-level lists of codes.
# dot_is_wildcard (default = F) if this is FALSE, the dot is eliminated before attempting a match. If this is TRUE, the dot is considered a wildcard for matching. Only possible if multi == F.
# vocabularies_with_dot_wildcard (otpional) a list of coding systems where the dot is consiedered a wildcard. Only possible if multi == T.

# Structure of output
# The output is the list (or, 2-level list, if multi == T) of codes of concept_set_B that are not children of codes of concept_set_A. If all the codes of concept_set_B are children of codes of concept_set_A, then the output is the empty list.


rm(list=ls(all.names=TRUE))

#set the directory where the file is saved as the working directory
if (!require("rstudioapi")) install.packages("rstudioapi")
thisdir<-setwd(dirname(rstudioapi::getSourceEditorContext()$path))
thisdir<-setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd("..")
# setwd("..")
dirbase<-getwd()

#Example 1
listA <- c('410', '412', '4131', '411') #romin list
listB <- c('410.1', '413', '410', '41', '41123', '414')  #gepard list

source(paste0(dirbase,"/CompareListsOfCodes.R"))

output <- CompareListsOfCodes(
  concept_set_A = listA,
  concept_set_B = listB
)
output

#output is the list c('413', '41', '414')


#-----------------------------------------------------
#Example 2
listA <- vector(mode="list")
listA[['ICD9']] = c('410', '412', '4131', '411')
listA[['ICD10']] = c('I20', 'I21')
listB[['READ']] = c('AAA', 'CCC', '111', '333')

listB <- vector(mode="list")
listB[['ICD9']] = c('410.1', '413', '410', '41', '41123', '414')
listB[['ICD10']] = c('I20.0', 'I2012', 'I22', 'I21', 'I2')
listB[['SNOMED']] = c('AAA', 'BBB', '111', '222')

output <- CompareListsOfCodes(
  concept_set_A = listA,
  concept_set_B = listB,
  multi=T
)
output

# #output is the following list:
# 
# output[['ICD9']] = c('413', '41', '414')
# output[['ICD10']] = c('I22','I2')
# output[['SNOMED']] = c('AAA','BBB', '111', '222')
