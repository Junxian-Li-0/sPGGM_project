library(survival)
library(survminer)

linewidth=2.5
my_theme <- function() {
  theme(
    panel.background = element_rect(fill = "white"),
    axis.line = element_line(size = 1), 
    axis.ticks = element_line(size=1),
    panel.border = element_blank(), 
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
  )
}

cli=read.table("data/UCEC_clinical.txt", header=T, sep="\t", check.names=F, row.names=1)
cli$time=cli$time/365
rt=cli

group = ifelse(rt[,"stage_index"]>5,"IIIA~IV","IA~IIB")
rt[,"group"] = group
length = length(levels(factor(group)))
diff = survdiff(Surv(time,state) ~group,data = rt)
pValue=1-pchisq(diff$chisq, df=length-1)
p=pValue
pValue1=paste0("p=",sprintf("%.011f",pValue))
fit <- survfit(Surv(time, state) ~group,data = rt)
bioCol=c("Firebrick3","#006400","#6E568C","#223D6C")
bioCol=bioCol[1:length]
surPlot=ggsurvplot(fit, 
                   data=rt,
                   conf.int=F,
                   lwd=linewidth,
                   legend.labs=levels(factor(rt[,"group"],levels = c("IA~IIB","IIIA~IV"))),
                   legend = c(0.8, 0.8),
                   legend.title="",
                   font.legend=16,
                   break.time.by = 2,
                   palette = bioCol,
                   ggtheme = my_theme(),
                   xlab="year",
                   ylab="Survival probability",
                   surv.median.line = "hv",
                   risk.table=T,
                   cumevents=F,
                   risk.table.height=.2,
)
png(file="survival.png", width=7*300, height=5.5*300,res=300)
print(surPlot)
dev.off()
cat("pValue1 ",pValue1,"\n")
