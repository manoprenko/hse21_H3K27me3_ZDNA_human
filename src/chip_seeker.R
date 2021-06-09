source('lib.R')

###

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ChIPseeker")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene", force=TRUE)
BiocManager::install("clusterProfiler", force=TRUE)
BiocManager::install("GenomicFeatures", force=TRUE)
BiocManager::install("org.Hs.eg.db", force=TRUE)
BiocManager::install("ChIPpeakAnno", force=TRUE)

library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
#library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(clusterProfiler)

###

NAME <- 'H3K27me3_H1.intersect_with_DeepZ'
#NAME <- 'DeepZ'
#NAME <- 'H3K27me3_H1.ENCFF152JSZ.hg19.filtered'
#NAME <- 'H3K27me3_H1.ENCFF296RYM.hg19.filtered'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')

###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

#pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()

# peak <- readPeakFile(BED_FN)
# pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
# covplot(peak, weightCol="V5")
# dev.off()
#