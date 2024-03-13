
library(BiocManager)
library(protr)
library(seqinr)
test <- read.fasta(file = 'test.fasta')
length(test)  

#............................................................................................
#............................................................................................
library(seqinr)
test_data <- read.fasta(file = "test.fasta")
length(test_data) 

# checking unusual Amino acid composition

test_data_check <- test_data[(sapply(test_data, protcheck))]
length(test_data_check)

# DESCRIPTORS:
# 1. Amino Acid Composition (AAC) #extractAAC() function

test <- readFASTA("test.fasta")
test_1 <- test[(sapply(test, protcheck))]
aac_test <- t(sapply(test, extractAAC))
aac_test

# Dipeptide with extractDC()

dc_test <- t(sapply(test, extractDC))
head(dc_test)


# Tripeptide with extractTC()

tc_test <- t(sapply(test, extractTC))
head(tc_test, n = 36L)
head(tc_test)
tc_test[[1]]

#............................................................................................
## Autocorrelation descriptors

# -> MORAEU-BOROTO CORRELATION DESCRIPTOR

mbc_test <- t(sapply(test, extractMoreauBroto))
head(mbc_test)

# -> Moran Correlation

mc_pos <- t(sapply(positive_data, extractMoran))
head(mc_pos, n = 36L)

# -> Geary Autocorrelation

geary_test <- t(sapply(test, extractGeary))
head(geary_test, n = 36L)


##..........................................................................................
#CTD - Composition

c <- t(sapply(test, extractCTDC))
head(c)

##CTD - Transition
t<- t(sapply(test, extractCTDT))
head(t)

## CTD - Distribution
d <- t(sapply(test, extractCTDD))
head(d)

##..................................................................................
# Conjoint-triad

conjoint_triad <- t(sapply(test, extractCTriad))
head(conjoint_triad, n = 65L)

##..................................................................................
## Sequence Order Coupling Number

socp <- t(sapply(test, extractSOCN))
head(socp)


##..................................................................................
#Quasi-sequence order

qso <- t(sapply(test, extractQSO))
head(qso)

#...................................................................................
## Pseudo-amino acid composition

paac <- t(sapply(test, extractPAAC))
head(paac)

#...................................................................................
## Amphi-philic PAAC
apaac <- t(sapply(test, extractAPAAC))
head(apaac)

#...................................................................................
## BLOSUM Matrix descriptor: extractBLOSUM()

?extractBLOSUM()
blosum <- t(sapply(test, extractBLOSUM, k = 5, lag = 7))
head(blosum)
length(blosum)


#...................................................................................
## scale-based descriptors
?extractDescScales()
descscales <- t(sapply(test, extractDescScales, 
                           propmat = "AATopo", pc = 20 
                           , lag = 7))
head(descscales)
descscales_aamoe2d <- t(sapply(test, extractDescScales,
                                   propmat = "AAMOE2D", pc = 20,
                                   lag = 7))
descscales_aamoe3d <- t(sapply(test, extractDescScales, 
                                   propmat = "AAMOE3D", pc = 20,
                                   lag = 7))
View(descscales_aamoe2d)
View(descscales_aamoe3d)

descscales_aamolprop <- t(sapply(test, extractDescScales,
                                     propmat = "AAMolProp", pc = 20,
                                     lag = 7))
length(descscales_aamolprop)
View(descscales_aamolprop)

print(paste0("row: ",nrow(descscales_aamolprop), 
             ", column: ", ncol(descscales_aamolprop)))

print(paste0("row: ",nrow(descscales_aamoe3d), 
             ", column: ", ncol(descscales_aamoe3d)))

print(paste0("row: ",nrow(descscales_aamoe2d), 
             ", column: ", ncol(descscales_aamoe2d)))
## We calculated 4 different descriptors with scaled-based properties. MOE2D,
## MOE3D, Topology and MolProp
## combine all the 4 matrices [ by using reduce() func.]

# merge all matrices
scale_based_des <- Reduce(function(x, y) cbind(x, y), 
                       list(descscales_aamolprop, 
                            descscales_aamoe2d, 
                            descscales_aamoe3d, 
                            descscales))

# check dimensions [should be 98 * 9408]
dim(scale_based_des)
head(scale_based_des, n = 60L)


test_all <- Reduce(function(x, y) cbind(x, y),
                       list(aac_test, dc_test, tc_test,
                            mbc_test, mc_test, geary_test,
                            c, t, d, conjoint_triad,
                            socp, qso, paac, apaac,
                            blosum, scale_based_des))
dim(test_all)

# Transpose of all_new_test

test_all_trans <- t(test_all)
dim(test_all_trans)

# Save the all_data into .csv file

write.csv(test_all_trans, file = "test.csv", 
          row.names = TRUE, col.names = TRUE)



































