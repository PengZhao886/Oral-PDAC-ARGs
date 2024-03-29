# R script for data analysis and visualization
# This script includes various statistical and visual methods to analyze sequencing data.

# Violin Plot
library(ggpubr)
setwd("C:/Users/PengZhao/Desktop")
df <- read.table("123.txt", header = TRUE, sep="\t", na.strings= "NA")
ggviolin(df, x="group2", y="Shannon", add="point", trim=FALSE, width=1, fill="blue")

# Heatmap
library(pheatmap)
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header = TRUE, sep="\t", na.strings= "NA")
pheatmap(all, cellwidth=12, cellheight=6, fontsize_row=12, fontsize_col=12, cluster_rows=FALSE, cluster_cols=FALSE, filename="dd.pdf", color = colorRampPalette(c("black", "white", "gold"))(50))

# Spearman and Pearson Correlation
library(psych)
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header=TRUE, row.names=1, sep="\t")
abc <- corr.test(data.frame(all), method="spearman", adjust="none")
write.table(t(abc$r), "spearmanr.txt", sep="\t")
write.table(t(abc$p), "spearmanp.txt", sep="\t")
bcd <- corr.test(data.frame(all), method="pearson", adjust="none")
write.table(t(bcd$r), "pearsonr1.txt", sep="\t")
write.table(t(bcd$p), "pearsonp1.txt", sep="\t")

# Principal Coordinates Analysis (PCoA)
library(ggplot2)
setwd("C:/Users/PengZhao/Desktop")
aaa <- read.table("123.txt", header = TRUE, row.names = 1, sep="\t")
ggplot(data=aaa, aes(x=PC1, y=PC2, colour=group)) + geom_point(size=4) + theme_bw()

# Boxplot with Significance Tests
library(ggplot2)
library(ggsignif)
setwd("C:/Users/PengZhao/Desktop")
df <- read.table("123.txt", header = TRUE, sep="\t", na.strings= "NA")
compaired <- list(c("HN_CRC", "Con"), c("HN_CRC", "ref_CRC"), c("ref_CRC", "Con"))
ggplot(df, aes(x=group, y=value, fill=group)) + geom_boxplot() + geom_point() + theme_bw() + 
  geom_signif(comparisons = compaired, step_increase = 0.1, map_signif_level = TRUE, test = wilcox.test)

# CLR Transformation
library(compositions)
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header=TRUE, row.names=1, sep="\t")
abc <- clr(all)
write.table(abc, "VFDB_clr.txt", sep="\t")

# Wilcoxon Test
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header=TRUE, row.names=1, sep="\t")
g <- factor(rep(1:2, c(6, 12)), labels=c("HN_CRC", "Con"))
result <- data.frame(as.character(rownames(all)))
for (i in 1:nrow(all)) {
  result[i,2] <- kruskal.test(as.numeric(all[i,]), g)$p.value
}
write.table(result, "p_value_8.txt", sep="\t", row.names=FALSE, col.names=FALSE)

# Aitchison and Bray-Curtis Distance
library(vegan)
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header=TRUE, row.names=1, sep="\t")
a <- vegdist(all, method="euclidean")
aa <- as.matrix(a)
write.table(aa, "distance.txt", sep="\t")

# Adonis
library(vegan)
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header=TRUE, row.names=1, sep="\t")
a <- read.table("234.txt", header=TRUE, row.names=1, sep="\t")
adonis2(all ~ group, data=a, permutations = 999)

# ROC Curve
library("pROC")
setwd("C:/Users/PengZhao/Desktop")
myData <- read.table("123.txt", header=TRUE, sep="\t")  
rocobj <- plot.roc(myData$group, myData$value, main="", percent=TRUE, ci=TRUE)
ciobj <- ci.se(rocobj, specificities=seq(0, 100, 5))
plot(ciobj, type="shape", col="#1c61b6AA", print.auc=TRUE)
text(40, 20, paste("AUC = ", formatC(rocobj$auc, digits=2, format="f"), sep=""), pos=4)
ci.lower <- formatC(rocobj$ci[1], digits=2, format="f")
ci.upper <- formatC(rocobj$ci[3], digits=2, format="f")
text(40, 10, paste("95% CI: ", ci.lower, "-", ci.upper, sep=""), pos=4)

# Bubble Chart
library(ggplot2)
setwd("C:/Users/PengZhao/Desktop")
all <- read.table("123.txt", header=TRUE, row.names=1, sep="\t")
pathway = read.table("123.txt", header=TRUE, row.names=1, check.names = FALSE)  
p = ggplot(pathway, aes(value, pathway))
p = p + geom_point() 
ggplot(pathway, aes(value, pathway)) + geom_point(aes(colour=ende, size=CRC))
