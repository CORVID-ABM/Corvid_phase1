#```{r load-seattle, echo=FALSE}
library(knitr)
library(RColorBrewer)
tractlocs <- read.csv("seattle-tracts.dat", header=FALSE, col.names=c("fipsstate", "fipscounty", "fipstract", "population", "latitude", "longitude"))
tracts.seattle <- read.csv("Baseline-tracts.txt", header=TRUE)
tracts.seattle$pop <- rowSums(tracts.seattle[grep("^pop",colnames(tracts.seattle))])
popsize <- sum(tracts.seattle$pop) # size of this synthetic population
wf.seattle <- read.csv("seattle-wf.dat", header=FALSE, sep=" ", col.names=c("source.fipsstate", "source.fipscounty", "source.fipstract", "dest.fipsstate", "dest.fipscounty", "dest.fipstract", "flow"))
temp <- readLines("Baseline-summary.txt")
corvidversion <- as.numeric(strsplit(gsub("^.*: ","",temp[grep("Corvid version", temp)]),",")[[1]])
symptomatic.seattle26 <- as.numeric(strsplit(gsub("^.*: ","",temp[grep("Number symptomatic", temp)]),",")[[1]])
cumulativesymptomatic.seattle26 <- as.numeric(strsplit(gsub("^.*: ","",temp[grep("Cumulative symptomatic", temp)]),",")[[1]])
newlysymptomatic.seattle26 <- c(symptomatic.seattle26[1], diff(cumulativesymptomatic.seattle26))

#individuals.seattle26 <- read.csv("Individuals-seattle26.txt", header=TRUE)
#individuals.seattle26$SOURCETYPE <- ifelse(individuals.seattle26$sourcetype==0, NA,
#                   ifelse(individuals.seattle26$sourcetype==1, "daytime.family",
#                   ifelse(individuals.seattle26$sourcetype==2, "daytime.comm",
#                   ifelse(individuals.seattle26$sourcetype==3, "daytime.nh",
#                   ifelse(individuals.seattle26$sourcetype==4, "daytime.school",
#                   ifelse(individuals.seattle26$sourcetype==5, "daytime.work",
#                   ifelse(individuals.seattle26$sourcetype==10, "nighttime.family",
#                   ifelse(individuals.seattle26$sourcetype==11, "nighttime.comm",
#                   ifelse(individuals.seattle26$sourcetype==12, "nighttime.nh",
#                   ifelse(individuals.seattle26$sourcetype==13, "nighttime.hhcluster",
#                   ifelse(individuals.seattle26$sourcetype==20, "seeded",
#		   ifelse(individuals.seattle26$sourcetype==21, "airport", "error"))))))))))))
#individuals.seattle26$generationtime <- (individuals.seattle26$infectedtime-individuals.seattle26$infectedtime[match(individuals.seattle26$sourceid,individuals.seattle26$id)])/2 # how many days ago was the infecter infected?
#individuals.seattle26$generationtime[individuals.seattle26$infectedtime<=0] <- NA # remove people never infected or infected on day 0

par(mar=c(3.5,3.5,1,1), #bottom, left, top, and right.
    mgp=c(2.0, 0.6, 0))
#pal <- heat.colors(max(tracts.seattle$pop)+1, rev=TRUE)
#plot(x=tractlocs$longitude, y=tractlocs$latitude, col=pal[tracts.seattle$pop[match(tractlocs$fipstract, tracts.seattle$FIPStract)]], cex=0.01*sqrt(tracts.seattle$pop[match(tractlocs$fipstract, tracts.seattle$FIPStract)]), pch=19, xlab="longitude", ylab="latitude", asp=1)
plot(x=tractlocs$longitude, y=tractlocs$latitude, col="blue", cex=0.01*sqrt(tracts.seattle$pop[match(tractlocs$fipstract, tracts.seattle$FIPStract)]), pch=19, xlab="longitude", ylab="latitude", asp=1, cex.axis=0.5, cex.lab=0.8)
points(x=tractlocs$longitude, y=tractlocs$latitude, col="red", cex=0.01*sqrt(tracts.seattle$workers[match(tractlocs$fipstract, tracts.seattle$FIPStract)]), pch=1)

