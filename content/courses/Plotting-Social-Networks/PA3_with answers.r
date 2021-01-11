###PA3###
###version 22-08-2019###
###J Tolsma###


#always start with cleaning up your workspace if you want to run your script again
rm (list = ls( )) 

#intall additional packages you will need later. 
library(RSiena) 
library(igraph)
library(devtools)
require("isnar")
library(foreign)
require(xtable)
#install.packages("devtools")
#install_github("mbojan/isnar")
#install.packages("xtable")

#define additional customized functions
{
fdensity <- function(x) { 
	#x is your nomination network
	#should be relationship, divided by all possible off diagonal ties. 
	#make sure diagonal cells are NA
	diag(x) <- NA
	x[x==10] <- NA
	sum(x==1, na.rm=T) / (sum(x==1 | x==0, na.rm=T))
}

fdensityintra <- function(x, A) { 
	#A is matrix indicating whether nodes constituting dyad have same characteristics
	diag(x) <- NA
	x[x==10] <- NA
	diag(A) <- NA
	sum(x==1 & A==1, na.rm=T) / (sum((x==1 | x==0) & A==1, na.rm=T))
}

fdensityinter <- function(x, A) { 
	#A is matrix indicating whether nodes constituting dyad have same characteristics
	diag(x) <- NA
	x[x==10] <- NA
	diag(A) <- NA
	sum(x==1 & A!=1, na.rm=T) / (sum((x==1 | x==0) & A!=1, na.rm=T))
}

fhomomat <- function(x) {
xmat <- matrix(x, nrow=length(x), ncol=length(x))
xmatt <- t(xmat)
xhomo <- xmat==xmatt
return(xhomo)
}

fndyads <- function(x) {
	diag(x) <- NA
	x[x==10] <- NA
	(sum((x==1 | x==0) , na.rm=T))
}

fndyads2 <- function(x, A) {
	diag(x) <- NA
	x[x==10] <- NA
	diag(A) <- NA
	(sum((x==1 | x==0) & A==1, na.rm=T))
}


fscolnet <- function(network, ccovar) {
#Calculate coleman on network level: https://reader.elsevier.com/reader/sd/pii/S0378873314000239?token=A42F99FF6E2B750436DD2CB0DB7B1F41BDEC16052A45683C02644DAF88215A3379636B2AA197B65941D6373E9E2EE413

	fhomomat <- function(x) {
	xmat <- matrix(x, nrow=length(x), ncol=length(x))
	xmatt <- t(xmat)
	xhomo <- xmat==xmatt
	xhomo[is.na(xmat)] <- NA
	return(xhomo)
	}

	fsumintra <- function(x, A) { 
	#A is matrix indicating whether nodes constituting dyad have same characteristics
	diag(x) <- NA
	x[x==10] <- NA
	diag(A) <- NA
	sum(x==1 & A==1, na.rm=T) 
	}

	#expecation w*=sum_g sum_i (ni((ng-1)/(N-1)))
	network[network==10] <- NA
	ni <- rowSums(network, na.rm=T)
	ng <- NA
	for (i in 1:length(ccovar)) {ng[i] <- table(ccovar)[rownames(table(ccovar))==ccovar[i]]}
	N <- length(ccovar)
	wexp <- sum(ni*((ng-1)/(N-1)), na.rm=T)

	#wgg1 how many intragroup ties
	w <- fsumintra(network, fhomomat(ccovar)) 
	
	Scol_net <- ifelse(w>=wexp, (w-wexp) / (sum(ni, na.rm=T) - wexp), (w - wexp)/wexp)
	return(Scol_net)

}
}

#setwd
setwd("C:\\Users\\Administrator\\Documents\\Shared\\Twitter\\Network data")

#STAP 1: read in data
load("twitter_20190919.RData")
str(twitter_20190919,1)
keyf <- twitter_20190919[[1]]
mydata <- twitter_20190919[[2]]
seats <- twitter_20190919[[3]]

#STAP 2: lets go fishing (some data)
fnet <- mydata$depvars$fnet
atmnet <- mydata$depvars$atmnet
rtnet <- mydata$depvars$rtnet

vrouw <- mydata$cCovars$vrouw
partij <- mydata$cCovars$partij
ethminz <- mydata$cCovars$ethminz
lft <- mydata$cCovars$lft

ethminz <- ethminz + attributes(ethminz)$mean
partij <- partij + attributes(partij)$mean
vrouw <- vrouw + attributes(vrouw)$mean
lft <- lft + attributes(lft)$mean

vrouwm <- fhomomat(vrouw)
partijm <- fhomomat(partij)
ethminzm <- fhomomat(ethminz)

xmat <- matrix(ethminz, nrow=length(ethminz), ncol=length(ethminz))
xmatt <- t(xmat)
minoritym <- xmat==1 & xmatt==1

#for age max 5 year difference / for descriptives
xmat <- matrix(lft, nrow=length(lft), ncol=length(lft))
xmatt <- t(xmat)
lftm <- (abs(xmat - xmatt) < 6)

names(keyf)
table(keyf$Geslacht, useNA="always")
table(vrouw, useNA="always")
head(keyf$Geslacht)
head(vrouw)

###part 1: descriptive statistics / making your own functions
#Q1: Suppose you are going to write a paper on twitter relations among Dutch MPs. Based on the above data, provide some initial descriptive statistics

#With small steps we are going to build a function that calculates the density of a network. 
#Q2a: How many possible ties are there in fnet at wave1?
#Q2b: Replace the diagonal values of the nomination network that are currently 0 to NA
#Q2c: Replace the structural zeros of the nomination network to NA.
#Q2d: How many possible ties do we have? Hint: count the 0s and 1s?
#Q2e: How many actual ties do we have? 
#Q2f: What is the density of the network. 
#Q2g: Make a function that calculates the density in one complete network at one point in time. give the function the name fdensity. Its only argument is a nomination network (which may contain NAs and structural zeros, 10).. 

#answers question 2
{
#With small steps we are going to build a function that calculates the density of a network. 
#Q2a: How many possible ties are there in fnet at wave1?
fnet1 <- fnet[,,1]
table(fnet1, useNA="always")
sum(table(fnet1, useNA="always")[1:2])
#Q2b: Replace the diagonal values of the nomination network that are currently 0 to NA
diag(fnet1) <- NA
#make sure to check if everything worked
fnet1[1:10, 1:10]
#Q2c: Replace the structural zeros of the nomination network to NA.
table(fnet1, useNA="always")
fnet1[fnet1==10] <- NA
table(fnet1, useNA="always")
#Q2d: How many possible ties do we have? Hint: count the 0s and 1s?
sum(table(fnet1, useNA="always")[1:2])
#Q2e: How many actual ties do we have? 
sum(table(fnet1, useNA="always")[2])
#Q2f: What is the density of the network. 
sum(table(fnet1, useNA="always")[2]) / sum(table(fnet1, useNA="always")[1:2])
#Q2g: Make a function that calculates the density in one complete network at one point in time. give the function the name fdensity. Its only argument is a nomination network (which may contain NAs and structural zeros, 10).. 
#see above
}

#We are going to calculate the density for one type of network at one point in time but for each party seperately. 
#Q3a: how to select that part of the network that belongs to a specific party? 
#Q3b: Define an object with correct dimensions in which you would like to store your results. (thus how many parties do we have)
#Q3c: Calculate density for one type of network at one point in time but for each party seperately. use a loop. 

#answers question 3
{
#We are going to calculate the density for one type of network at one point in time but for each party seperately. 
#Q3a: how to select that part of the network that belongs to a specific party? 
#realize that everything is ordered correctly thus 
partij[3] 
#is the party of ego/alter 3
#thus to select we need all egos/alters with a specific party. E.g.:
fnet1_p10 <- fnet1[partij==10, partij==10]

#Q3b: Define an object with correct dimensions in which you would like to store your results. (thus how many parties do we have)
#thus first thing to solve how many parties do we have?
N <- length(unique(partij))
N
#then define to object in which we are going to store results
density_parties <- rep(NA, N)

#Q3c: Calculate density for one type of network at one point in time but for each party seperately. use a loop. 
#store party ids 
uniq_partij<-unique(partij)
#please order, not necessarry but nice
uniq_partij <- uniq_partij[order(uniq_partij)]
uniq_partij
#how many parties do we have. 
N <- length(unique(partij))
N
#then define to object in which we are going to store results
density_parties <- rep(NA, N)
#finally the actual loop.
for (i in 1:N){
  #select one party
  partijnr <- uniq_partij[i]
  density_parties[i] <- fdensity(fnet1[partij==partijnr,partij==partijnr])
}
density_parties
#perhaps add the party names?
names(density_parties) 
names(density_parties) <- as.character(uniq_partij)
names(density_parties) 
density_parties
#just to show how easy it is to work with strings
names(density_parties) <- paste("Party_ID", as.character(uniq_partij), sep="")
density_parties

}

#Q4: check wheter intra-party density is larger than between inter-party density
#pointer: make two new functions one for intra party and one for inter-party. define/select for each the relevant dyads/possible ties

#answer question 4
{
#Q4: check wheter intra-party density is larger than between inter-party density
#let us use the function we already defined above to tells us which dyads are between same/diff parties
#see above for new functions
homo_party <- fhomomat(partij)
homo_party
fdensity(fnet1)
fdensityintra(fnet1, homo_party)
fdensityinter(fnet1, homo_party)
#bit stupid of me to define two functions. 
fdensityintra(fnet1, !homo_party)
#works as well. 
}

#Q5: Calculate normalized degree for each node (on friendship network at time 1).

#answer question 5
{
#Q5: Calculate normalized degree for each node.
#think we already did this
fnet1 <- fnet[,,1]
fnet1[fnet1==10] <- NA
diag(fnet1) <- NA
degree <- rowSums(fnet1, na.rm=T)
degree
mindegree <- min(degree)
mindegree
maxdegree <- max(degree)
maxdegree
degree_norm <- (degree - mindegree) / (maxdegree - mindegree)
degree_norm
}

#Q6a: Calculate closeness for each node. DIFFICULT ONE!
#Q6b: Only if you have nothing else to do. Calculate betweenness for each node. DIFFICULT ONE! 

###We are going to use igraph to check our answers. see:http://igraph.org/
#lets get rid of the structural zeros
fnet[fnet==10] <- NA
rtnet[rtnet==10] <- NA
atmnet[atmnet==10] <- NA

gfnet1 <- graph_from_adjacency_matrix(fnet[,,1], mode = "directed", weighted = NULL, diag = TRUE,  add.colnames = NA, add.rownames = NA)

#degree check
degree(gfnet1)
hist(degree(gfnet1))
hist(degree(gfnet1, mode="out"))
hist(degree(gfnet1, mode="out", normalized = TRUE))
hist(degree(gfnet1, mode="in", normalized = TRUE))

#density check
fnet1 <- fnet[,,1]
diag(fnet1)<-NA
test<- table(fnet1, useNA="always")
test
test[2]/sum(test[1:2])
fdensity(fnet[,,1])
edge_density(gfnet1, loops = FALSE)
test[2]/(nrow(fnet1)*(nrow(fnet1)-1))
#mmm, which one do we like best?

#closeness check
closeness <- closeness(gfnet1, mode="out", normalized=TRUE)
closeness

#betweenness check
betweenness <- betweenness(gfnet1, normalized=TRUE)
betweenness
hist(betweenness(gfnet1, normalized=TRUE))
#let us normalize ourselves
fbetweenness <- function(graph){  (betweenness(graph)- min(betweenness(graph))) / (max(betweenness(graph))- min(betweenness(graph)))}
hist(fbetweenness(gfnet1))

#Q7 which politician is most central? 

#answer question 7
{
which(degree==max(degree))
names(keyf)
keyf$Naam[which(degree==max(degree))]
which(closeness==max(closeness))
which(betweenness==max(betweenness))
###mmmm, how to define centrality on these three measures

#let make an order from large to small
keyf$Naam[order(degree, decreasing=TRUE)]
#etc
}

###part 2: Plotting

#check out the site of Kateto: http://kateto.net/network-visualization. especially from paragraph 3.2 and onwards
#check out the site of igraph: http://igraph.org/r/
#here you can find the manual: https://cran.r-project.org/web/packages/igraph/igraph.pdf
#see also here: http://igraph.org/r/doc/
#see also: http://statmath.wu.ac.at/research/friday/resources_WS0708_SS08/igraph.pdf
# see also http://www.sthda.com/english/articles/33-social-network-analysis/137-interactive-network-visualization-using-r/

#start plotting 
#lets plot the atmention network
atmnet1 <- atmnet[,,1]
atmnet1[atmnet1==10] <- 0

G1 <- graph_from_adjacency_matrix(atmnet1, mode = "directed", weighted = NULL, diag = TRUE,  add.colnames = NA, add.rownames = NA)
plot(G1)
G1 <- simplify(G1) 
plot(G1)
#too dense, I am going to plot only the reciprocated ties. 
#define undirected network 
atmnet1_un <- atmnet1 ==1 & t(atmnet1)==1
head(atmnet1_un)
#check if density is lower.
fdensity(atmnet1)
fdensity(atmnet1_un)

G1 <- graph_from_adjacency_matrix(atmnet1_un, mode = "undirected", weighted = NULL, diag = TRUE,  add.colnames = NA, add.rownames = NA)
plot(G1)
G1 <- simplify(G1) 
plot(G1)


#some other plotting functions 
l4 <- layout.kamada.kawai(G1)
tkplot(G1, layout=l4)
install.packages("rgl")
require("rgl")
l5 <-layout.fruchterman.reingold(G1, dim=3)
rglplot(G1, layout=l5)

#suppose we want to save this
install.packages("rmarkdown")
require(rmarkdown)
test <- writeWebGL(dir = "webGL", filename = file.path("webGL/index.html"), template = system.file(file.path("WebGL", "template.html"), package = "rgl"), snapshot = TRUE, font = "Arial")
attr(test, "reuse")
getwd()
if (interactive()) browseURL(paste0(getwd(),"//",test))

#let go back to the igraph package
#we could remove the isolates, how? would we want that??
noisolates <- rowSums(atmnet1_un, na.rm=T)>0
noisolates
#if you select, select both correct nomination network as ego characteristics
atmnet1_un_sel <- atmnet1_un[noisolates,noisolates]
#if you are going to use the dataset to add characteristics to plot, make sure to run the correct selection as well!!!
keyf_sel<- keyf[noisolates,]

G1_sel <- graph_from_adjacency_matrix(atmnet1_un_sel, mode = "undirected", weighted = NULL, diag = TRUE,  add.colnames = NA, add.rownames = NA)
plot(G1_sel)
G1_sel <- simplify(G1_sel) 
plot(G1_sel)


?V
# What is the stuff we can change?
{# What is the stuff we can change?
#   5.1 Plotting parameters
#
# NODES
# vertex.color  Node color
# vertex.frame.color  Node border color
# vertex.shape  One of "none", "circle", "square", "csquare", "rectangle"
# "crectangle", "vrectangle", "pie", "raster", or "sphere"
# vertex.size  Size of the node (default is 15)
# vertex.size2  The second size of the node (e.g. for a rectangle)
# vertex.label  Character vector used to label the nodes
# vertex.label.family  Font family of the label (e.g."Times", "Helvetica")
# vertex.label.font  Font: 1 plain, 2 bold, 3, italic, 4 bold italic, 5 symbol
# vertex.label.cex  Font size (multiplication factor, device-dependent)
# vertex.label.dist  Distance between the label and the vertex
# vertex.label.degree  The position of the label in relation to the vertex,
# where 0 right, "pi" is left, "pi/2" is below, and "-pi/2" is above
# EDGES
# edge.color  Edge color
# edge.width  Edge width, defaults to 1
# edge.arrow.size  Arrow size, defaults to 1
# edge.arrow.width  Arrow width, defaults to 1
# edge.lty  Line type, could be 0 or "blank", 1 or "solid", 2 or "dashed",
# 3 or "dotted", 4 or "dotdash", 5 or "longdash", 6 or "twodash"
# edge.label  Character vector used to label edges
# edge.label.family  Font family of the label (e.g."Times", "Helvetica")
# edge.label.font  Font: 1 plain, 2 bold, 3, italic, 4 bold italic, 5 symbol
# edge.label.cex  Font size for edge labels
# edge.curved  Edge curvature, range 0-1 (FALSE sets it to 0, TRUE to 0.5)
# arrow.mode  Vector specifying whether edges should have arrows,
# possible values: 0 no arrow, 1 back, 2 forward, 3 both
# OTHER
# margin  Empty space margins around the plot, vector with length 4
# frame  if TRUE, the plot will be framed
# main  If set, adds a title to the plot
# sub  If set, adds a subtitle to the plot 
}

#changing V
V(G1)$size= degree(G1)*1.05 
plot(G1)
V(G1)$label=as.character(keyf$Naam2)
plot(G1)
V(G1)$label.cex=1
plot(G1)
V(G1)$color <- ifelse(keyf$Geslacht == "vrouw", "red", "green")
plot(G1)

#changing E
E(G1)$arrow.size=.4
E(G1)$curved=.3
plot(G1)

#chaning other stuff
#lets change the margins a bit. 
plot.igraph(G1, margin=0)

#adding legend
legend(x=0, y=0, c("Female","Male"), pch=21,
       col="#777777", pt.bg=c("blue", "red"), pt.cex=2, cex=.8, bty="n", ncol=1)

#playing around with layout and coordinates...very annoying
plot(keyf$X, keyf$Y, xlim=c(-18,18), ylim=c(-18,18), col=keyf$Partij_col, pch=16)

owncoords <- cbind(keyf$X, keyf$Y)
owncoords <- owncoords/8
owncoords[,1] <- (owncoords[,1] - mean(owncoords[,1]))
owncoords[,2] <- (owncoords[,2] - mean(owncoords[,2]))
plot.igraph(G1, layout=owncoords, rescale=F, margin=0)
#it really depends on your plotting window (size, resolution etc.) to get consistent results you need to define this beforehand. won't do that now. 

#bonus how to  change color of edges. 
#let us make them pink for women women; blue for men men and black otherwise
edges <- get.adjacency(G1)
edges
nrow(edges)
as.numeric(edges)
edges_mat <- matrix(as.numeric(edges), nrow=nrow(edges))
edges_mat

#because we have undirected, we only need the edges once ...I know ...
edges_mat[lower.tri(edges_mat)] <- 0
table(keyf$Geslacht)

teller <- 1
coloredges <- NA
for (i in 1:nrow(edges)) {
  for (j in 1:ncol(edges)) {
    if (edges_mat[i,j]==1) {
      if (keyf$Geslacht[i] == "vrouw" & keyf$Geslacht[j] == "vrouw") {coloredges[teller] <- "pink"}
      if (keyf$Geslacht[i] == "vrouw" & keyf$Geslacht[j] != "vrouw") {coloredges[teller] <- "black"}
      if (keyf$Geslacht[i] != "vrouw" & keyf$Geslacht[j] == "vrouw") {coloredges[teller] <- "black"}
      if (keyf$Geslacht[i] != "vrouw" & keyf$Geslacht[j] != "vrouw") {coloredges[teller] <- "blue"}
      teller <- teller + 1	  
    }
  }
}

E(G1)$color=coloredges
plot.igraph(G1, layout=owncoords, rescale=F, margin=0)
# I guess it worked

#Q8: make a nice plot!
# show you are able to change edge / vertices attributes / use different attributes as in example
# show you are able to select part of network
# add a legend
# change background colors
# add title to figure
# save as pdf







