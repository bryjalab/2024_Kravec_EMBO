# Script for the generation of volcano plot in Fig. 4B

# Libraries
library(plotly) 
library(dplyr)
library(ggrepel)

# Input file: for_volcano_plots_updated.txt from KNIME workflow
data_volcano <- read.delim("for_volcano_plots_updated.txt", stringsAsFactors = FALSE)
str(data_volcano)

# Create new column for the color of the points and labels
data_volcano["color"] <- "grey"
data_volcano["selected"] <- ""

# Define specific proteins which will be colored
# in RED
data_volcano[which(data_volcano$Gene.names %in% c('TTLL11', 'RAB11FIP5', 'KATNAL2', 'CSNK1E', 'CSNK2A2',
                                                     'RPS27', 'CDK1', 'HSPB1', 'DNAJB6', 'SRSF9', 'DAP3', 'GRWD1',
                                                     'CSNK1D', 'USP9X', 'RANBP10','SON', 'YTHDF3;YTHDF1',
                                                     'C12orf66', 'MRTO4','SRRM2' )), "color"] <- "red" 

data_volcano[which(data_volcano['Majority.protein.IDs']=='Q92997-FLAG;Q92997'), "color"] <- "red" 

# in BLACK
data_volcano[which(data_volcano$Gene.names %in% c('TJP1', 'CKAP5', 'MLF2', 'PHLDB2', 'MCRS1',
                                                  'TRMT112', 'C7orf43', 'SORT1', 'CMSS1', 'DDX23',
                                                  'GID8', 'NUFIP1', 'THRAP3')), "color"] <- "black" 

# Add labels
data_volcano[which(data_volcano['Gene.names']=='TTLL11'), "selected"] <- "TTLL11" 
data_volcano[which(data_volcano['Gene.names']=='RAB11FIP5'), "selected"] <- "RAB11FIP5" 
data_volcano[which(data_volcano['Gene.names']=='KATNAL2'), "selected"] <- "KATNAL2" 
data_volcano[which(data_volcano['Gene.names']=='CSNK1E'), "selected"] <- "CSNK1E" 
data_volcano[which(data_volcano['Gene.names']=='CSNK2A2'), "selected"] <- "CSNK2A2" 
data_volcano[which(data_volcano['Gene.names']=='RPS27'), "selected"] <- "RPS27" 
data_volcano[which(data_volcano['Gene.names']=='CDK1'), "selected"] <- "CDK1" 
data_volcano[which(data_volcano['Gene.names']=='HSPB1'), "selected"] <- "HSPB1" 
data_volcano[which(data_volcano['Gene.names']=='DNAJB6'), "selected"] <- "DNAJB6" 
data_volcano[which(data_volcano['Majority.protein.IDs']=='Q92997-FLAG;Q92997'), "selected"] <- "DVL3" 
data_volcano[which(data_volcano['Gene.names']=='SRSF9'), "selected"] <- "SRSF9" 
data_volcano[which(data_volcano['Gene.names']=='DAP3'), "selected"] <- "DAP3" 
data_volcano[which(data_volcano['Gene.names']=='GRWD1'), "selected"] <- "GRWD1" 
data_volcano[which(data_volcano['Gene.names']=='CSNK1D'), "selected"] <- "CSNK1D"
data_volcano[which(data_volcano['Gene.names']=='USP9X'), "selected"] <- "USP9X"
data_volcano[which(data_volcano['Gene.names']=='TJP1'), "selected"] <- "TJP1"
data_volcano[which(data_volcano['Gene.names']=='CKAP5'), "selected"] <- "CKAP5"
data_volcano[which(data_volcano['Gene.names']=='MLF2'), "selected"] <- "MLF2"
data_volcano[which(data_volcano['Gene.names']=='RANBP10'), "selected"] <- "RANBP10"
data_volcano[which(data_volcano['Gene.names']=='YTHDF3;YTHDF1'), "selected"] <- "YTHDF3"
data_volcano[which(data_volcano['Gene.names']=='PHLDB2'), "selected"] <- "PHLDB2"
data_volcano[which(data_volcano['Gene.names']=='MCRS1'), "selected"] <- "MCRS1"
data_volcano[which(data_volcano['Gene.names']=='TRMT112'), "selected"] <- "TRMT112"
data_volcano[which(data_volcano['Gene.names']=='SON'), "selected"] <- "SON"
data_volcano[which(data_volcano['Gene.names']=='C7orf43'), "selected"] <- "C7orf43"
data_volcano[which(data_volcano['Gene.names']=='C12orf66'), "selected"] <- "C12orf66"
data_volcano[which(data_volcano['Gene.names']=='SORT1'), "selected"] <- "SORT1"
data_volcano[which(data_volcano['Gene.names']=='CMSS1'), "selected"] <- "CMSS1"
data_volcano[which(data_volcano['Gene.names']=='DDX23'), "selected"] <- "DDX23"
data_volcano[which(data_volcano['Gene.names']=='GID8'), "selected"] <- "GID8"
data_volcano[which(data_volcano['Gene.names']=='DDX56'), "selected"] <- "DDX56"
data_volcano[which(data_volcano['Gene.names']=='NUFIP1'), "selected"] <- "NUFIP1"
data_volcano[which(data_volcano['Gene.names']=='MRTO4'), "selected"] <- "MRTO4"
data_volcano[which(data_volcano['Gene.names']=='SRRM2'), "selected"] <- "SRRM2"
data_volcano[which(data_volcano['Gene.names']=='THRAP3'), "selected"] <- "THRAP3"

# Adjust colors of labels
data_volcano$label_color <- data_volcano$color
data_volcano$label_color[data_volcano$label_color == "grey"] <- ""
data_volcano$label_color[data_volcano$color == "red"] <- "black"
data_volcano$label_color[data_volcano$color == "black"] <- "grey"

# Plot the volcano plot
t <- ggplot(data_volcano, aes(x=data_volcano$LIMMA_DVL3_TTLL.DVL3.logFC ,y =-log10(data_volcano$LIMMA_DVL3_TTLL.DVL3.adj.P.Val), label=data_volcano$selected)) +
  geom_point(size=1.5, color=data_volcano$color)+
  geom_hline(yintercept=-log10(0.05), linetype="dashed", color = "black") +
  geom_vline(xintercept=c(-1,1), linetype="dashed", color = "black") +
  #geom_text_repel()+
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
                     legend.position = "none")+
  xlab("log Fold Change") + ylab("-log10 (adjusted pvalue)") + 
  #   geom_text()+
  geom_label_repel(aes(color = data_volcano$label_color),
                   arrow = arrow(length = unit(0.01, "npc"), type = "closed", ends = "first"),
                   force = 10
  )+
  scale_colour_manual(values = c("white", "black", "grey"))

t
