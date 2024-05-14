# Script for statistical analysis of DVL3 subcellular localization

library(lme4) 
library(lmerTest)
library(reshape)
library(multcomp)

D <- read.delim(file = "path/polyE data.txt") # adjust path according to particular file
D1 <- melt(D, id=c("exp", "treat"))

fit4 <- lmer(value ~ treat + (1|exp), data = D1[which(D1$variable=="puncta"),])
fit4 
anova(fit4)   
summary(fit4) 
summary(glht(fit4))  # adjusted p-values

cc4 <- confint(fit4,parm="beta_")
ctab4 <- round((cbind(OR=fixef(fit4),cc4)),3)
ctab4    ### returns OR (95% CI)

summary(glht(fit4, mcp(treat = "Tukey"))) # post-hoc test