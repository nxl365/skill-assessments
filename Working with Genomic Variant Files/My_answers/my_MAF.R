### reference: https://www.youtube.com/watch?v=wVHomBdMXfY&t=12s ; https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html#13_TCGA_cohorts




library(maftools)

# view available TCGA cohorts, check that LGG is there
tcgaAvailable()

# load the available LGG cohort
lgg <- tcgaLoad(study = "LGG")

# view a summary of this file
lgg




## 1. An oncoplot of the top five mutated genes

# Open the graphics device
png("my_oncoplot.png", width = 1600, height = 1200, res = 150)

# Create the plot
oncoplot(maf = lgg, top = 5)

# Close the device
dev.off()



## 2. A boxplot of the transistion-to-transversion ratio

# Compute titv values
titv_values <- titv(maf = lgg, plot = FALSE, useSyn = TRUE)


# Open the graphics device
png("my_titv.png", width = 1600, height = 1200, res = 150)

# create plot
plotTiTv(res = titv_values)

# Close the device
dev.off()




## 3.A plot comparing the mutation load in this LGG cohort to other TCGA cohorts. Use log scale.
# extract 3 datasets respectively for example


# Compute mutation load for each sample
lgg_mutload <- getSampleSummary(lgg)$Tumor_Sample_Barcode
names(lgg_mutload) <- getSampleSummary(lgg)$V1



# Load another cohort (e.g., BRCA)
brca <- tcgaLoad(study = "BRCA")

# Compute mutation load
brca_mutload <- getSampleSummary(brca)$Tumor_Sample_Barcode
names(brca_mutload) <- getSampleSummary(brca)$V1



# Load another cohort (e.g., LAML)
laml <- tcgaLoad(study = "LAML")

# Compute mutation load
laml_mutload <- getSampleSummary(laml)$Tumor_Sample_Barcode
names(laml_mutload) <- getSampleSummary(laml)$V1



# Combine mutation loads
all_mutload <- data.frame(
  Cohort = c(rep("LGG", length(lgg_mutload)), 
             rep("BRCA", length(brca_mutload)),
             rep("LAML", length(laml_mutload))
             ),
  MutLoad = c(lgg_mutload, brca_mutload,laml_mutload)
)






# Open the graphics device
png("my_comparPlot.png", width = 1600, height = 1200, res = 150)


# Plot comparison
boxplot(MutLoad ~ Cohort, data = all_mutload, log = "y", 
        xlab = "Cohort", ylab = "Mutation Load (log scale)",
        main = "Mutation Load Comparison across TCGA Cohorts")

# Close the device
dev.off()

