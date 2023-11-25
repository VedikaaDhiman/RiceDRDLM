# merge all positive matrices

## matrices: aac_pos, dc_pos, tc_pos, mbc_pos, mc_pos, geary_pos,
##           c_pos, t_pos, d_pos, conjoint_triad_pos, socp_pos, qso_pos,
##           paac_pos, apaac_pos, blosum_pos, scale_based_des_pos

dim(aac_pos)
dim(dc_pos)
dim(tc_pos)
dim(mbc_pos)
dim(mc_pos)
dim(geary_pos)
dim(c_pos)
dim(t_pos)
dim(d_pos)
dim(conjoint_triad_pos)
dim(socp_pos)
dim(qso_pos)
dim(paac_pos)
dim(apaac_pos)
dim(blosum_pos)
dim(scale_based_des_pos)

# merge all matrices



all_positive <- Reduce(function(x, y) cbind(x, y),
                       list(aac_pos, dc_pos, tc_pos,
                            mbc_pos, mc_pos, geary_pos,
                            c_pos, t_pos, d_pos, conjoint_triad_pos,
                            socp_pos, qso_pos, paac_pos, apaac_pos,
                            blosum_pos, scale_based_des_pos))
dim(all_positive)

#.......................................................................................
## merge negative matrices
## matrices: aac_neg, dc_neg, tc_neg, mbc_neg, mc_neg, geary_neg,
##           c_neg, t_neg, d_neg, conjoint_triad_neg, socp_neg, qso_neg,
##           paac_neg, apaac_neg, blosum_neg, scale_based_des_neg

dim(aac_neg)
dim(dc_neg)
dim(tc_neg)
dim(mbc_neg)
dim(mc_neg)
dim(geary_neg)
dim(c_neg)
dim(t_neg)
dim(d_neg)
dim(conjoint_triad_neg)
dim(socp_neg)
dim(qso_neg)
dim(paac_neg)
dim(apaac_neg)
dim(blosum_neg)
dim(scale_based_des_neg)


# merge all the neg matrices
all_negative <- Reduce(function(x, y) cbind(x, y),
                       list(aac_neg, dc_neg, tc_neg,
                            mbc_neg, mc_neg, geary_neg,
                            c_neg, t_neg, d_neg, conjoint_triad_neg,
                            socp_neg, qso_neg, paac_neg, apaac_neg,
                            blosum_neg, scale_based_des_neg))

dim(all_negative)


# Transpose of all_positive and all_negative

all_positive_trans <- t(all_positive)
dim(all_positive_trans)

all_negative_trans <- t(all_negative)
dim(all_negative_trans)

# Merge all_positive_trans and all_negative_trans
## dimension: 19503(nrow) * 296 (ncol)

all_data <- cbind(all_positive_trans, all_negative_trans)
dim(all_data)
View(all_data)

# Save the all_data into .csv file

write.csv(all_data, file = "all_data.csv", 
          row.names = TRUE, col.names = TRUE)
















                       
                       
                       
                