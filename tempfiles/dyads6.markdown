+++
  title = "1 article"
  date = 2019-12-21
  toc = true  # Show table of contents? true/false
  type = "book"  # Do not modify.
  weight = 80
+++

## Egocentric networks  

Let us consider the following 'world'. And visualize the best friend relationships. 

```
## Loading required package: igraph
```

```
## 
## Attaching package: 'igraph'
```

```
## The following objects are masked from 'package:stats':
## 
##     decompose, spectrum
```

```
## The following object is masked from 'package:base':
## 
##     union
```


```r
set.seed(37676)
l4 <- layout.kamada.kawai(g4)
g4 <- graph_from_adjacency_matrix(edges_mat, mode = "undirected")
#changing V
V(g4)$label=""
V(g4)$color <- "blue"
#changing E
E(g4)$arrow.size=.4
E(g4)$curved=.3
E(g4)$color="black"
plot(g4, layout=l4, margin=0,)
```

<img src="/courses/Dyads/dyads6_files/figure-html/unnamed-chunk-2-1.png" width="672" />
And now sample a random person. The person we sampled is made red and square in our network. 


```r
V(g4)$color[96]="red"
V(g4)$shape="circle"
V(g4)$shape[96]="square"
plot(g4, layout=l4)
```

<img src="/courses/Dyads/dyads6_files/figure-html/unnamed-chunk-3-1.png" width="672" />
Let's suppose we had asked this person to name all its best friends. Then this person's egocentric or 1.0 degree network would look like this: 


```r
edges_mat[c(1:100)[-96], c(1:100)[-96]] <- 0
noisolates <- rowSums(edges_mat, na.rm=T)>0

#same appearance
g5 <- graph_from_adjacency_matrix(edges_mat[noisolates,noisolates], mode = "undirected")
V(g5)$label=""
V(g5)$color <- V(g4)$color[noisolates]
E(g5)$arrow.size=.4
E(g5)$curved=.3
E(g5)$color="black"
V(g5)$shape <- V(g4)$shape[noisolates]
plot(g5, layout=l4[noisolates,])
```

<img src="/courses/Dyads/dyads6_files/figure-html/unnamed-chunk-4-1.png" width="672" />


```r
edges <- get.adjacency(g4)
edges_mat <- matrix(as.numeric(edges), nrow=nrow(edges))
edges_mat[4,24] <- 1
connected <- adjacent_vertices(g4, 96)
subnet <- c(96, as.numeric(unlist(connected)))


g6 <- graph_from_adjacency_matrix(edges_mat[subnet,subnet], mode = "undirected")

#same appearance
V(g6)$label=""
V(g6)$color <- V(g4)$color[subnet]
E(g6)$arrow.size=.4
E(g6)$curved=.3
E(g6)$color="black"
V(g6)$shape <- V(g4)$shape[subnet]
plot(g6,layout=l4[subnet,])
```

<img src="/courses/Dyads/dyads6_files/figure-html/unnamed-chunk-5-1.png" width="672" />


```r
subnet_new <- list()
for (i in 1:length(subnet)) {
  connected <- adjacent_vertices(g4, subnet[i])
  subnet_new[[i]] <- as.numeric(unlist(connected))
}
subnet_new <- unique(unlist(subnet_new))

g7 <- graph_from_adjacency_matrix(edges_mat[subnet_new,subnet_new], mode = "undirected")

#same appearance
V(g7)$label=""
V(g7)$color <- V(g4)$color[subnet_new]
E(g7)$arrow.size=.4
E(g7)$curved=.3
E(g7)$color="black"
V(g7)$shape <- V(g4)$shape[subnet_new]
plot(g7,layout=l4[subnet_new,])
```

<img src="/courses/Dyads/dyads6_files/figure-html/unnamed-chunk-6-1.png" width="672" />




subedges <- function(vid, graph) {
  vids2 <- adjacent_vertices(graph, vid)
  get.edge.ids(graph, vp=as.numeric(rbind(vid, as.numeric(unlist(vids2)))))
}

subedges(96, g4)

vids2
g4_sel <- subgraph.edges(g4, eids=subedges(96, g4), delete.vertices = TRUE)

plot.igraph(g4_sel, layout=l4[noisolates,])

```



## test   


text  



## test 2 

tasd 

## test 3

adf d 

