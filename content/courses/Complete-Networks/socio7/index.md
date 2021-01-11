---
title: RSiena II (consequences)
author: JochemTolsma
date: '2020-09-22'
slug: socio7
categories:
  - R
  - Social Networks
tags: []
linktitle: Socionets-Consequences-Methods
summary: "RSiena, twitter, social networks, plotting, tutorial, R, Lavaan"
lastmod: '2020-09-15T08:27:34+02:00'
type: book
weight: 47
 
output:
  blogdown::html_page:
    highlight: "haddock"
    number_sections: yes
    self_contained: true
    toc: true
    fig_width: 6
    keep_md: true
editor_options: 
  chunk_output_type: inline
---


<!--set global settings--> 



<!--copy to clipboard-->
<!--html_preserve--><script>
  addClassKlippyTo("pre.r, pre.markdown");
  addKlippy('left', 'top', 'auto', '1', 'Copy code', 'Copied!');
</script><!--/html_preserve-->
<!---
https://www.w3schools.com/w3css/w3css_buttons.asp
https://www.freecodecamp.org/news/a-quick-guide-to-styling-buttons-using-css-f64d4f96337f/
--->

<!---
<button onclick="window.location.href='static/index.Rmd';">download code</button>
--->

# Introduction - RSiena behaviour
This page will teach you how to use the R package RSiena for modeling behavioral change. Thus on this page we will focus on node evolution and influence processes.   
Please visit the RSiena homepage [here](https://www.stats.ox.ac.uk/~snijders/siena/). On the website you may find the exceptionally well written manual. But the RSiena website also contains all kind of useful RSiena scripts and 'lab exercises'. 
When we model both tie-evolution (which is what we almost without exception do with RSiena) and node-evolution, we also call this a co-evolution model. 
Before we start with our own lab exercise, I would like you to:  

1. walk through script number 6 on the RSiena website (which is called [Rscript04SienaBehaviour.R](https://www.stats.ox.ac.uk/~snijders/siena/Rscript04SienaBehaviour.R)).  

My own lab exercise can be found [below](#lab-exercise).  



# RSiena - some additional explanations

Having taught the course social networks for a couple of years now to the students of the Research Master Social and Cultural Sciences, I think there are a couple of aspects that deserve a little bit more attention than they get in the manual and on the RSiena website. Namely,...  

1. How do we model node evolution and are results similar to 'normal' regression models?  
2. What is the difference between an average alter effect and a total alter effect? 
3. Can senders only influence receivers or also vice versa? Do we need both in our models? 

## modelling node evolution

### RSiena-linear and quad effects

### Multi-level hybrid model


## avAlt and totAlt effects  
I think this question deserves a knowledge clip. Please watch the video below. 

<iframe src="https://player.vimeo.com/video/465727691" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>




{{% alert note %}}
After having watched the video you have learned: 
  
1. You may be influenced by (the absence of) ties in the network, regardless of the node attributes.  
2. You may be influenced by others to whom you are connected via an undirected tie, an outgoing tie, and an ingoing tie.  
3. The difference between average alter and total alter effects.  
4. That (positive) influence may also mean that you become similar to an alter to which you are connected with a specific node attribute but thereby become less similar to more other alters to which you are also connected. 
{{% /alert %}}

 

<div class="figure">
<img src="plot2.png" alt="Average Alter Effect" width="100%" />
<p class="caption">(\#fig:influence)Average Alter Effect</p>
</div>

<div class="figure">
<img src="plot3.png" alt="Total Alter Effect" width="100%" />
<p class="caption">(\#fig:influence2)Total Alter Effect</p>
</div>


## ...Alt versus ...InAlt effects

Have a look at the picture below. 

<div class="figure">
<img src="plot1.png" alt="Who is influencing whom?" width="100%" />
<p class="caption">(\#fig:influence3)Who is influencing whom?</p>
</div>
* Undirectied tie: The direction of influence does not depend on the direction tie. In RSiena who is influenced depends on who has the opportunity for change (thus by the behavioral rate function)  
* Directed tie *i* --> *j*. Actor *j* may assimilate to *i* because of an incoming tie. In RSiena these effects are ...inAlt effects (e.g. effects $s^{beh}_{i20}$ and $s^{beh}_{i21}$). Example 1a: I teach you how to apply a social network perspective in your research, you come to value a social network perspective and your research behavior becomes more similar to mine.  
* Directed tie *i* --> *j*. Actor *i* may assimilate to *j* because of an outgoing tie. In RSiena these effects are ...Alt effects (e.g. effects $s^{beh}_{i18}$ and $s^{beh}_{i19}$). Example 2a: I name you as my friend and therefore I will mimic your behavior. 

Naturally, the influence may also be negative: 
Example 1b: I teach you how to apply a social network perspective in your research, you come to dislike a social network perspective and your research behavior becomes less similar to mine.     
Example 2b: I name you as my foe and therefore I will behave as different as possible from you.  

The question is, can we tease these processes apart and can we tell which one is more important? To be honest, I am not sure. But we will try below.  


# lab exercise 
We are going to use data collected among primary and secondary school pupils in the Netherlands during the [MyMovez](http://mymovez.eu/) project.  

During the workgroup I will explain all code. For those of you who don't attend the workgroups, google knows way more than I do.  

{{% alert warning %}}
In the upper left and right corner of the code blocks you will find copy-to-clipboard buttons. Use these buttons to copy the code to your own editor. 
{{% /alert %}}


## Before you start

Before you start, check whether you run the latest RStudio version (from the Help menu, pick 'check for updates' and whether you need to update R. 


```{.r .highlightt .numberLines}
install.packages("installr")  #you  first install packages
require(installr)  #then you will need to activate packages. 
updateR()  #run the function to start the update process
```


Give your script a nice name. Include the author, and data when you last modified the script. Include a lot of comments in your script! Don't forget, always start with cleaning up your workspace. 


```{.r .highlightt .numberLines}
### Author: JOCHEM TOLSMA### Lastmod: 31-08-2020###

# cleanup workspace
rm(list = ls())
```

And set your working directory. 

```{.r .highlightt .numberLines}
# set working directory
setwd("C:\\YOURDIR\\YOURSUBDIR\\YOURSUBSUBDIR\\")  #change to your own workdirectory
```

Install the packages you will need. 


```{.r .highlightt .numberLines}
library(RSiena)
library(sna)
library(ape)
library(network)
```

Define your custom build functions. 

`fMoran.I`:

```{.r .highlightt .numberLines}
fMoran.I <- function(x, weight, scaled = FALSE, na.rm = FALSE, alternative = "two.sided", rowstandardize = TRUE) {
    if (rowstandardize) {
        if (dim(weight)[1] != dim(weight)[2]) 
            stop("'weight' must be a square matrix")
        n <- length(x)
        if (dim(weight)[1] != n) 
            stop("'weight' must have as many rows as observations in 'x'")
        ei <- -1/(n - 1)
        nas <- is.na(x)
        if (any(nas)) {
            if (na.rm) {
                x <- x[!nas]
                n <- length(x)
                weight <- weight[!nas, !nas]
            } else {
                warning("'x' has missing values: maybe you wanted to set na.rm = TRUE?")
                return(list(observed = NA, expected = ei, sd = NA, p.value = NA))
            }
        }
        ROWSUM <- rowSums(weight)
        ROWSUM[ROWSUM == 0] <- 1
        weight <- weight/ROWSUM
        s <- sum(weight)
        m <- mean(x)
        y <- x - m
        cv <- sum(weight * y %o% y)
        v <- sum(y^2)
        obs <- (n/s) * (cv/v)
        if (scaled) {
            i.max <- (n/s) * (sd(rowSums(weight) * y)/sqrt(v/(n - 1)))
            obs <- obs/i.max
        }
        S1 <- 0.5 * sum((weight + t(weight))^2)
        S2 <- sum((apply(weight, 1, sum) + apply(weight, 2, sum))^2)
        s.sq <- s^2
        k <- (sum(y^4)/n)/(v/n)^2
        sdi <- sqrt((n * ((n^2 - 3 * n + 3) * S1 - n * S2 + 3 * s.sq) - k * (n * (n - 1) * S1 - 2 * n * 
            S2 + 6 * s.sq))/((n - 1) * (n - 2) * (n - 3) * s.sq) - 1/((n - 1)^2))
        alternative <- match.arg(alternative, c("two.sided", "less", "greater"))
        pv <- pnorm(obs, mean = ei, sd = sdi)
        if (alternative == "two.sided") 
            pv <- if (obs <= ei) 
                2 * pv else 2 * (1 - pv)
        if (alternative == "greater") 
            pv <- 1 - pv
        list(observed = obs, expected = ei, sd = sdi, p.value = pv)
    } else {
        if (dim(weight)[1] != dim(weight)[2]) 
            stop("'weight' must be a square matrix")
        n <- length(x)
        if (dim(weight)[1] != n) 
            stop("'weight' must have as many rows as observations in 'x'")
        ei <- -1/(n - 1)
        nas <- is.na(x)
        if (any(nas)) {
            if (na.rm) {
                x <- x[!nas]
                n <- length(x)
                weight <- weight[!nas, !nas]
            } else {
                warning("'x' has missing values: maybe you wanted to set na.rm = TRUE?")
                return(list(observed = NA, expected = ei, sd = NA, p.value = NA))
            }
        }
        # ROWSUM <- rowSums(weight) ROWSUM[ROWSUM == 0] <- 1 weight <- weight/ROWSUM
        s <- sum(weight)
        m <- mean(x)
        y <- x - m
        cv <- sum(weight * y %o% y)
        v <- sum(y^2)
        obs <- (n/s) * (cv/v)
        if (scaled) {
            i.max <- (n/s) * (sd(rowSums(weight) * y)/sqrt(v/(n - 1)))
            obs <- obs/i.max
        }
        S1 <- 0.5 * sum((weight + t(weight))^2)
        S2 <- sum((apply(weight, 1, sum) + apply(weight, 2, sum))^2)
        s.sq <- s^2
        k <- (sum(y^4)/n)/(v/n)^2
        sdi <- sqrt((n * ((n^2 - 3 * n + 3) * S1 - n * S2 + 3 * s.sq) - k * (n * (n - 1) * S1 - 2 * n * 
            S2 + 6 * s.sq))/((n - 1) * (n - 2) * (n - 3) * s.sq) - 1/((n - 1)^2))
        alternative <- match.arg(alternative, c("two.sided", "less", "greater"))
        pv <- pnorm(obs, mean = ei, sd = sdi)
        if (alternative == "two.sided") 
            pv <- if (obs <= ei) 
                2 * pv else 2 * (1 - pv)
        if (alternative == "greater") 
            pv <- 1 - pv
        list(observed = obs, expected = ei, sd = sdi, p.value = pv)
    }
    
    
}
```

`fanscsv`:

```{.r .highlightt .numberLines}
fanscsv <- function(ans = ans, filename = "ans.csv", write = TRUE) {
    ans1_mat <- matrix(NA, nrow = length(ans$effects[, 2]), ncol = 3)
    row.names(ans1_mat) <- ans$effects[, 2]
    ans1_mat[, 1] <- (ans$theta)
    ans1_mat[, 2] <- (ans$se)
    ans1_mat[, 3] <- (ans$tconv)
    ans1_mat <- rbind(ans1_mat, c(ans$tconv.max))
    row.names(ans1_mat)[length(row.names(ans1_mat))] <- "Overall maximum convergence ratio:"
    colnames(ans1_mat) <- c("Estimate", "Standard Error", "Convergence t-ratio")
    print(ans1_mat)
    if (write) {
        write.csv(ans1_mat, filename)
    }
}
```

## Data

We are going to play with a subsample of the MyMovez data. The original data are stored at the [Data Archiving and Networked Services](https://doi.org/10.17026/dans-zz9-gn44).   


<!--html_preserve--><a href="data:application/octet-stream;base64,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86Vb73vvTSdNf/yej33ymddtnb7l8v+68o3bzu9+7S/f/bQPHnGxu73/PL750otWfvrnV3W/PXz6o55w11HT0xved9L3fvPQ7n984IYVZ/38O+5595+fO+4Nn3/wlgMeur77k7ue8ZYXnHWDNmxx+2nXd6+4+R/uPONHW7q3jvzlM9950V/3r797/ds3HbTHbe7y9Du++IkLn/qhTvee9e++8SNXXd+965wT3vqBT290z7v7Pz90/Y3X7L1l+sdTmx94+JYvLni8Xrt2b//vlx7+wt9a0f3nTW94z998Zlv//g++/a73/fuFL3LtveP3NH3o2c+4bKM6LPv3P7zte3d/dNuOifu3/emPb3z/m/q3u9/Xf0z//v/Y9p4XdX943LduOmL56d2f/M2FU8fffM70l+7/0B9+5T9P73cjl+152V7v+uTa6dsvP+uf9/rc2un7tj3l/ie85LXdr44f8XuHfuz06W9+9MF/eflJ53fvvuOdT7jt4x92l/uP17u+f/lHoy87Ybd3XTV96/qjv371t7Z2P/e3Jz3t6Rf179e9ef/pD75w1/4wxf0++pf//oM/vu//vOU1/Z+vd7/pb//oFZd87ab39vf7pzPf9d3dN/bbyf0+5evYPZ8Fv5+f3nzNBauGPuBen1uHnrv7cXd/6pn927+/+Wff2vvLz+ne8uLHvuWN/7ml+3933/2hb5/4Yfe6l4+j/b7k38uC3+e9p9y4/0ced5t7HfVfH73Xi3x9dX9y5C//4fA/uVr+PfV/f72/F+v59F+Pt519w/dv+sv13R9fe+nFW765Y5j/8D3T9/7eIe/S2mvHNNfs63v65neet+1Rx13vfi/usrvfgsft/b1t3WXLxs9tuea5/ddt7/flnlf/8V37fGnbx0/9zLHDLi/6t/d+bvd36n4v/ddB7++gv3+vvbrf+86ffPmd3f7vpXv/O1516Wl//tPufX/82z899CN37xiePVjd5edXdx8cu/G8oVe/072Ouz855+zD/vdHb+rn2qeefuy/XvaxTvdnW2/64R+96jlq+4vXef/6f9v1H29+9yFb3d9f97aHn7/6zz9/Q//10MtHlwPdu27ffPJzj33Ngtdtr337OSz+fvr53mvnfju5x3M/Ty9v++3fe97dHz/7cTcd/IXTd7yO/9d1m3/jrLV93eP28qn/PuFy4YFXv/CFH3/4q937v3b86r3+5Cr3d9C9b5+LD9z/gDf1n5/7fbu/E5dPvXZ2eda988VP+tlzrvpqd9uKf3zUuo9d0X89PLjqOx+95rjDu/f9+D17fPjZ/ddTP8+dd/7rt9YceftruvcffNgvfjD9oukffuqTt//Zs1bI98v+5d77Vv94vXyQrz/3PqG+Dh6487OPOXnocPf7lbf3349770f9v5fe4/Ufp5f3/d9/7+9Q5nP/cbeN3XPoQQf9yoLr3fvjL19w9L9ddtr67g++/rSjbv9Cv113vA899I3O3m+7u/8+2Ht+O3Kq97rp/b4WPE7v9yXfj7rfG37vLX9/35H9y/18mv96W/C+3nuduJ/f5Y/8efvv++516V5nIk/c+7D7e1O6yzNnPKP6yzuu3b7CaWOvi7mi06vh/fbY+rw7X39e//K++7/rmO7rnilWnQ3N2X65YEXT6Mh4deDedMvqf/jm679+zXXDu//6yi9uOWB6wTRN/wHFVE/vhbaTB75yVq1LP6drfs+pV77qvHO+pE8tKSudFp4RuPyv9n3WxWuu2Elv/RsLeuv3Hvjpxw/d/I7uvZ8+/lv7DR+RqLe+4Blu32vv3u9JOO+eu7oXz/jE+tGXjE5N9i7vPnHu5OimzSNTYxPj7rpV60c3Vi+v/sV1219t/Yub511cvf6SdfKK+Xs8et3Eho0Tk2MzD/G882fX1M1/GZ4/dt75o9XLeWjmN7O641XzfrrVvSPtu6M9j1zQtI+ebdqd3DC7ZmwnN8w53LxVZnv0DjX/yt5h5l059xC9pWnzDzH/yt4h5i5im7/aYf3Y5OsmxmaWL9BYVmPtNjJ18ujI5NRp46M0l9pcC9fvbl/73ukl0P8Hm2jYENSQEAA=" download="beh_data.Rdata">Download beh_data.Rdata</a><!--/html_preserve-->

<br>



Load the Robject and have a look at it. 


```{.r .highlightt .numberLines}
load("beh_data.RData")  #change to your working directory
str(ExData, 1)
str(ExData$depvars, 1)
```

```
## List of 8
##  $ nodeSets         :List of 1
##  $ observations     : int 3
##  $ depvars          :List of 3
##  $ cCovars          :List of 4
##  $ vCovars          :List of 1
##  $ dycCovars        : list()
##  $ dyvCovars        : list()
##  $ compositionChange: list()
##  - attr(*, "higher")= Named logi [1:9] FALSE FALSE FALSE FALSE FALSE FALSE ...
##   ..- attr(*, "names")= chr [1:9] "friendship,friendship" "advice,friendship" "mvpa_y,friendship" "friendship,advice" ...
##  - attr(*, "disjoint")= Named logi [1:9] FALSE FALSE FALSE FALSE FALSE FALSE ...
##   ..- attr(*, "names")= chr [1:9] "friendship,friendship" "advice,friendship" "mvpa_y,friendship" "friendship,advice" ...
##  - attr(*, "atLeastOne")= Named logi [1:9] FALSE FALSE FALSE FALSE FALSE FALSE ...
##   ..- attr(*, "names")= chr [1:9] "friendship,friendship" "advice,friendship" "mvpa_y,friendship" "friendship,advice" ...
##  - attr(*, "class")= chr "siena"
## List of 3
##  $ friendship: 'sienaDependent' num [1:149, 1:149, 1:3] 0 1 0 1 1 1 0 0 0 0 ...
##   ..- attr(*, "type")= chr "oneMode"
##   ..- attr(*, "sparse")= logi FALSE
##   ..- attr(*, "nodeSet")= chr "Actors"
##   ..- attr(*, "netdims")= int [1:3] 149 149 3
##   ..- attr(*, "allowOnly")= logi TRUE
##   ..- attr(*, "uponly")= logi [1:2] FALSE FALSE
##   ..- attr(*, "downonly")= logi [1:2] FALSE FALSE
##   ..- attr(*, "distance")= int [1:2] 527 527
##   ..- attr(*, "vals")=List of 3
##   ..- attr(*, "nval")= int [1:3] 21580 21609 21579
##   ..- attr(*, "noMissing")= num [1:3] 472 443 473
##   ..- attr(*, "noMissingEither")= num [1:2] 489 473
##   ..- attr(*, "nonMissingEither")= num [1:2] 21563 21579
##   ..- attr(*, "balmean")= num 0.0908
##   ..- attr(*, "structmean")= num 0.0902
##   ..- attr(*, "simMean")= logi NA
##   ..- attr(*, "symmetric")= logi FALSE
##   ..- attr(*, "missing")= logi TRUE
##   ..- attr(*, "structural")= logi TRUE
##   ..- attr(*, "range2")= num [1:2] 0 1
##   ..- attr(*, "ones")= Named int [1:3] 960 1102 967
##   .. ..- attr(*, "names")= chr [1:3] "1" "1" "1"
##   ..- attr(*, "density")= Named num [1:3] 0.0445 0.051 0.0448
##   .. ..- attr(*, "names")= chr [1:3] "1" "1" "1"
##   ..- attr(*, "degree")= Named num [1:3] 6.58 7.55 6.63
##   .. ..- attr(*, "names")= chr [1:3] "1" "1" "1"
##   ..- attr(*, "averageOutDegree")= num 6.92
##   ..- attr(*, "averageInDegree")= num 6.92
##   ..- attr(*, "maxObsOutDegree")= num [1:3] 27 27 27
##   ..- attr(*, "missings")= num [1:3] 0.0214 0.0201 0.0214
##   ..- attr(*, "name")= chr "friendship"
##  $ advice    : 'sienaDependent' num [1:149, 1:149, 1:3] 0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "type")= chr "oneMode"
##   ..- attr(*, "sparse")= logi FALSE
##   ..- attr(*, "nodeSet")= chr "Actors"
##   ..- attr(*, "netdims")= int [1:3] 149 149 3
##   ..- attr(*, "allowOnly")= logi TRUE
##   ..- attr(*, "uponly")= logi [1:2] FALSE FALSE
##   ..- attr(*, "downonly")= logi [1:2] FALSE FALSE
##   ..- attr(*, "distance")= int [1:2] 390 295
##   ..- attr(*, "vals")=List of 3
##   ..- attr(*, "nval")= int [1:3] 21576 21609 21577
##   ..- attr(*, "noMissing")= num [1:3] 476 443 475
##   ..- attr(*, "noMissingEither")= num [1:2] 493 475
##   ..- attr(*, "nonMissingEither")= num [1:2] 21559 21577
##   ..- attr(*, "balmean")= num 0.03
##   ..- attr(*, "structmean")= num 0.0297
##   ..- attr(*, "simMean")= logi NA
##   ..- attr(*, "symmetric")= logi FALSE
##   ..- attr(*, "missing")= logi TRUE
##   ..- attr(*, "structural")= logi TRUE
##   ..- attr(*, "range2")= num [1:2] 0 1
##   ..- attr(*, "ones")= Named int [1:3] 362 294 201
##   .. ..- attr(*, "names")= chr [1:3] "1" "1" "1"
##   ..- attr(*, "density")= Named num [1:3] 0.01678 0.01361 0.00932
##   .. ..- attr(*, "names")= chr [1:3] "1" "1" "1"
##   ..- attr(*, "degree")= Named num [1:3] 2.48 2.01 1.38
##   .. ..- attr(*, "names")= chr [1:3] "1" "1" "1"
##   ..- attr(*, "averageOutDegree")= num 1.96
##   ..- attr(*, "averageInDegree")= num 1.96
##   ..- attr(*, "maxObsOutDegree")= num [1:3] 17 27 17
##   ..- attr(*, "missings")= num [1:3] 0.0216 0.0201 0.0215
##   ..- attr(*, "name")= chr "advice"
##  $ mvpa_y    : 'sienaDependent' num [1:149, 1, 1:3] 1 NA 4 NA 2 1 NA 1 2 3 ...
##   ..- attr(*, "type")= chr "behavior"
##   ..- attr(*, "sparse")= logi FALSE
##   ..- attr(*, "nodeSet")= chr "Actors"
##   ..- attr(*, "netdims")= int [1:3] 149 1 3
##   ..- attr(*, "allowOnly")= logi TRUE
##   ..- attr(*, "uponly")= logi [1:2] FALSE FALSE
##   ..- attr(*, "downonly")= logi [1:2] FALSE FALSE
##   ..- attr(*, "distance")= num [1:2] 105 109
##   ..- attr(*, "vals")=List of 3
##   ..- attr(*, "nval")= int [1:3] 102 113 90
##   ..- attr(*, "noMissing")= int [1:3] 47 36 59
##   ..- attr(*, "noMissingEither")= num [1:2] 59 69
##   ..- attr(*, "nonMissingEither")= num [1:2] 90 80
##   ..- attr(*, "symmetric")= logi NA
##   ..- attr(*, "poszvar")= logi TRUE
##   ..- attr(*, "range")= num 4
##   ..- attr(*, "range2")= num [1:2] 1 5
##   ..- attr(*, "moreThan2")= logi TRUE
##   ..- attr(*, "modes")= num [1:3] 2 4 1
##   ..- attr(*, "missing")= logi TRUE
##   ..- attr(*, "simMean")= num 0.622
##   ..- attr(*, "structural")= logi FALSE
##   ..- attr(*, "balmean")= logi NA
##   ..- attr(*, "structmean")= logi NA
##   ..- attr(*, "name")= chr "mvpa_y"
##   ..- attr(*, "simMeans")= Named num [1:2] 0.849 0.773
##   .. ..- attr(*, "names")= chr [1:2] "friendship" "advice"
```

What do we have? 

- Data on 7 classes. See below how to play with just one class. 
- friendship: dependent tie-variable: who are your friends
- advice: dependent tie-variable: I am not telling you if it is 'to whom do you give advice?' or 'from whom do you receive advice?' that would make for a nice question on the exam.  
- mvpa_y: behavioral dependent variable 'moderate to vigorous physical activity' measured via FitBit. I made five categories (from low to high)
- ethnicNLNA: a covariate (including missing values) on ethnicity of pupils: 0 is native Dutch; 1 is other ethnic background. 
- sex: sex of pupils: 0 is boys; 1 is girls. 
- lft: age of pupils (measured in years)
- primary: primary school (grade 8) or secondary school (grade 9)
- mvpa_x: please ignore this variable for now. 

## Descriptive statistics of similarity in behavior

On the [previous page](../socio6) we focused on tie evolution and selection processes. We started the lab exercise with descriptive statistics on homophily and segregation. Are similar people more likely to be connected. We now take a slightly different angle. We want to know if nodes who are closer to one another in the network are more a like.  
 "Hey, that sounds like some sort of correlation!" Yup, we need some spatial autocorrelation measure. Let us use Moran's I for this.    
We will start with a calculation of the correlation between the score of actor i and the (total/mean) score of the alters of i to whom i is connected directly.

Spatial autocorrelation measures are actually quite complex. A lot of build in functions in different packages of R are not very clear on all the defaults. With respect to Moran's I, its values are actually quite difficult to compare across different spatial/network settings. Results may depend heavily on whether or not you demean your variables of interest, the chosen neighborhood/weight matrix (and hence on distance decay functions and type of standardization of the weight matrix). Anyways, lets get started. 

### formula

Moran's I is given by: 

$$ I= \gamma \Sigma_i\Sigma_jw_{ij}z_iz_j,$$
where $w_{ij}$ is the weight matrix $z_i$ and $z_j$ are the scores in deviations from the mean. And, 

$$ \gamma= S_0 * m_2 = \Sigma_i\Sigma_jw_{ij} * \frac{\Sigma_iz_i^2}{n},  $$
Thus $S_0$ is the sum of the weight matrix and $m_2$ is an estimate of the variance. For more information see [Anselin 1995](https://onlinelibrary.wiley.com/doi/epdf/10.1111/j.1538-4632.1995.tb00338.x).  

### Moran's autocorrelation for outgoing ties: RSiena build-in dataset
 
We need two packages, if we not want to define all functions ourselves: `sna` and `ape`.[^1]

[^1]: I quite frequently need to calculate Moran's I and related statistics in my work/hobby. I commonly use the functions in the R package `spdep`. 

Let us first demonstrate the concept on the build-in dataset of RSiena and then apply it to our own data. 

First use `sna`. And give alters a weight of 1 if they are part of the 1.0 degree egocentric network. 

```{.r .highlightt .numberLines}
library(network)
friend.data.w1 <- s501
friend.data.w2 <- s502
friend.data.w3 <- s503
drink <- s50a
smoke <- s50s

net1 <- network::as.network(friend.data.w1)
net2 <- network::as.network(friend.data.w2)
net3 <- network::as.network(friend.data.w3)

# nacf does not row standardize!
snam1 <- nacf(net1, drink[, 1], type = "moran", neighborhood.type = "out", demean = TRUE)
snam1[2]  #the first order matrix is stored in second list-element
```

```
##         1 
## 0.4331431
```

Lets calculate the same thing with `ape`. 

```{.r .highlightt .numberLines}
geodistances <- geodist(net1, count.paths = TRUE)
geodistances <- geodistances$gdist

# first define a nb based on distance 1.
weights1 <- geodistances == 1

# this function rowstandardizes by default
ape::Moran.I(drink[, 1], scaled = FALSE, weight = weights1, na.rm = TRUE)
```

```
## $observed
## [1] 0.486134
## 
## $expected
## [1] -0.02040816
## 
## $sd
## [1] 0.132727
## 
## $p.value
## [1] 0.000135401
```
Close but not the same value!

Lets use 'my own' function, don't rowstandardize

```{.r .highlightt .numberLines}
fMoran.I(drink[, 1], scaled = FALSE, weight = weights1, na.rm = TRUE, rowstandardize = FALSE)
```

```
## $observed
## [1] 0.4331431
## 
## $expected
## [1] -0.02040816
## 
## $sd
## [1] 0.1181079
## 
## $p.value
## [1] 0.000122962
```

Same result as nacf function!  

What does rowstandardization mean??  

- **rowstandardize**: We assume that each node *i* is influenced equally by its neighbourhood regardless on how large it. You could compare this to the average alter effect in RSiena)  
- **not rowstandardize**: We assume that each alter *j* has the same influence on *i* (if at the same distance). You could compare this to the total alter effect in RSiena.  

To not standardize is default in `sna::nacf`, to standardize is default in `apa::Moran.I`. This bugs me. I thus made a small adaption to `apa::Moran.I` and now in the function `fMoran.I` you can choose if you want to rowstandardize or not.

But...  

> "What you really, really want  
> I wanna, (ha) I wanna, (ha)  
> I wanna, (ha) I wanna, (ha)  
> I wanna really, really, really   
> Wanna zigazig ah"  
> --- Spice Girls - Wannabe

What I really would like to see is a correlation between actor *i* and all the alters to whom it is connected (direct or indirectly) and where alters at a larger distances (longer shortest path lengths) are weighted less. 

step 1: for each acter *i* determine the distances (shortest path lengths) to all other nodes in the network. 
step 2: based on these distances decide on how we want to weigh. That is, determine a distance decay function.   
step 3: decide whether or not we want to row-standardize.


```{.r .highlightt .numberLines}
# step 1: calculate distances
geodistances <- geodist(net1, count.paths = TRUE)
geodistances <- geodistances$gdist
# set the distance to yourself as Inf
diag(geodistances) <- Inf


# step 2: define a distance decay function. This one is pretty standard in the spatial
# autocorrelation literature but actually pretty arbitrary.
weights2 <- exp(-geodistances)

# step 3: I dont want to rowstandardize.
fMoran.I(drink[, 1], scaled = FALSE, weight = weights2, na.rm = TRUE, rowstandardize = FALSE)
```

```
## $observed
## [1] 0.2817188
## 
## $expected
## [1] -0.02040816
## 
## $sd
## [1] 0.07532918
## 
## $p.value
## [1] 6.052458e-05
```
Conclusion: Yes pupils closer to one another are more a like! And 'closer' here means a shorter shortest path length. You also observe that the correlation is lower than we calculated previously. Apparently, we are a like to alters very close by (path length one) and less so (or even dissimilar) to alters furter off.vvv  

### Moran's autocorrelation for outgoing ties: MyMovez dataset

Let's repeat the exercise but now on our own data. The tie variable we will use are the friendship relations. 


```{.r .highlightt .numberLines}
# step 1: calculate distances
fnet <- ExData$depvars$friendship[, , 1]
fnet[fnet == 10] <- 0

geodistances <- geodist(fnet, count.paths = TRUE)
geodistances <- geodistances$gdist
# set the distance to yourself as Inf
diag(geodistances) <- Inf
# head(geodistances) #have a look for yourself.

# step 2: define a distance decay function. This one is pretty standard in the spatial
# autocorrelation literature but actually pretty arbitrary.
weights2 <- exp(-geodistances)

# step 3: In this case I do want to rowstandardize because I think the influence is by the total
# class but class sizes vary.
fMoran.I(ExData$depvars$mvpa_y[, , 1], scaled = FALSE, weight = weights2, na.rm = TRUE, rowstandardize = TRUE)
```

```
## $observed
## [1] 0.07961828
## 
## $expected
## [1] -0.006756757
## 
## $sd
## [1] 0.04212021
## 
## $p.value
## [1] 0.04029821
```

Thus Yes, If we look at all classes together we see that pupils who are closer to one another are more a like with respect to physical activity. But the correlations is quite small! 

Do we see the same within each class? 


```{.r .highlightt .numberLines}
# some background info:
nclass <- c(28, 18, 18, 18, 18, 25, 24)
classid <- rep(1:7, times = nclass)

print("Moran's I: class 1")
```

```
## [1] "Moran's I: class 1"
```

```{.r .highlightt .numberLines}
fMoran.I(ExData$depvars$mvpa_y[, , 1][1:28], scaled = FALSE, weight = weights2[1:28, 1:28], na.rm = TRUE, 
    rowstandardize = TRUE)
```

```
## $observed
## [1] -0.03002763
## 
## $expected
## [1] -0.03703704
## 
## $sd
## [1] 0.02435121
## 
## $p.value
## [1] 0.7734643
```

```{.r .highlightt .numberLines}
print("Moran's I: class 2")
```

```
## [1] "Moran's I: class 2"
```

```{.r .highlightt .numberLines}
fMoran.I(ExData$depvars$mvpa_y[, , 1][29:46], scaled = FALSE, weight = weights2[29:46, 29:46], na.rm = TRUE, 
    rowstandardize = TRUE)
```

```
## $observed
## [1] 0.04152623
## 
## $expected
## [1] -0.05882353
## 
## $sd
## [1] 0.053813
## 
## $p.value
## [1] 0.06221135
```

Correlations within classes are somewhat lower and/or not significant. Probably there is thus also similarity beween pupils because they are in the same class (might be due to selection and influence processes, or class/context effects of course). 

## A quick co-evolution RSiena model to check. 

{{% alert note %}}

Please be aware that in co-evolution models (as in multiplex models) the variables defined as dependent variables in your RSiena data object can be both a 'cause' (or independent variable) and a 'consequence' (or dependent variable). In this influence effect: `includeEffects(myEff, name = "drinkingbeh", outdeg,	interaction1= "friendship" )` the dependent variable "drinkingbeh" is define by `name`, the independent networkvariable "friendship" by `interaction`. 
{{% / alert %}}


```{.r .highlightt .numberLines}
# Step 1: DATA
friend.data.w1 <- s501
friend.data.w2 <- s502
friend.data.w3 <- s503
drink <- s50a
smoke <- s50s

friendship <- sienaDependent(array(c(friend.data.w1, friend.data.w2, friend.data.w3), dim = c(50, 50, 
    3)))  # create tie-dependent variable

drinkingbeh <- sienaDependent(drink, type = "behavior")  # create behavior-dependent variable

smoke1 <- coCovar(smoke[, 1])  #covariate

# Define the data set and obtain the basic effects object
myCoEvolutionData <- sienaDataCreate(friendship, smoke1, drinkingbeh)

# STEP 2: have a look at data.
print01Report(myCoEvolutionData, modelname = "s50_3_CoEvinit")
# look at the created file!!

# STEP 3: Define effects
myCoEvolutionEff <- getEffects(myCoEvolutionData)
# effectsDocumentation(myCoEvolutionEff)

# structural effects
myCoEvolutionEff <- includeEffects(myCoEvolutionEff, transTrip, cycle3)

# homophily effect for the constant covariate smoking
myCoEvolutionEff <- includeEffects(myCoEvolutionEff, simX, interaction1 = "smoke1")

# selection effect related to drinking behavior?
myCoEvolutionEff <- includeEffects(myCoEvolutionEff, egoX, altX, simX, interaction1 = "drinkingbeh")

# INFLUENCE PART!! inline with the above I use totAlt
myCoEvolutionEff <- includeEffects(myCoEvolutionEff, name = "drinkingbeh", totAlt, interaction1 = "friendship")

# Check what effects you have decided to include:

myCoEvolutionEff

# STEP 4: define algorithm
myCoEvAlgorithm <- sienaAlgorithmCreate(projname = "s50CoEv_3")

# STEP 5: estimate the model
(ans <- siena07(myCoEvAlgorithm, data = myCoEvolutionData, effects = myCoEvolutionEff))

# use this function if you want to save as excel fanscsv(ans, write=FALSE) #uncomment if you want.
```

```
##   effectName          include fix   test  initialValue parm
## 1 transitive triplets TRUE    FALSE FALSE          0   0   
## 2 3-cycles            TRUE    FALSE FALSE          0   0   
##   effectName        include fix   test  initialValue parm
## 1 smoke1 similarity TRUE    FALSE FALSE          0   0   
##   effectName             include fix   test  initialValue parm
## 1 drinkingbeh alter      TRUE    FALSE FALSE          0   0   
## 2 drinkingbeh ego        TRUE    FALSE FALSE          0   0   
## 3 drinkingbeh similarity TRUE    FALSE FALSE          0   0   
##   effectName              include fix   test  initialValue parm
## 1 drinkingbeh total alter TRUE    FALSE FALSE          0   0   
##    name        effectName                          include fix   test  initialValue parm
## 1  friendship  constant friendship rate (period 1) TRUE    FALSE FALSE    4.69604   0   
## 2  friendship  constant friendship rate (period 2) TRUE    FALSE FALSE    4.32885   0   
## 3  friendship  outdegree (density)                 TRUE    FALSE FALSE   -1.46770   0   
## 4  friendship  reciprocity                         TRUE    FALSE FALSE    0.00000   0   
## 5  friendship  transitive triplets                 TRUE    FALSE FALSE    0.00000   0   
## 6  friendship  3-cycles                            TRUE    FALSE FALSE    0.00000   0   
## 7  friendship  smoke1 similarity                   TRUE    FALSE FALSE    0.00000   0   
## 8  friendship  drinkingbeh alter                   TRUE    FALSE FALSE    0.00000   0   
## 9  friendship  drinkingbeh ego                     TRUE    FALSE FALSE    0.00000   0   
## 10 friendship  drinkingbeh similarity              TRUE    FALSE FALSE    0.00000   0   
## 11 drinkingbeh rate drinkingbeh (period 1)         TRUE    FALSE FALSE    0.70571   0   
## 12 drinkingbeh rate drinkingbeh (period 2)         TRUE    FALSE FALSE    0.84939   0   
## 13 drinkingbeh drinkingbeh linear shape            TRUE    FALSE FALSE    0.32237   0   
## 14 drinkingbeh drinkingbeh quadratic shape         TRUE    FALSE FALSE    0.00000   0   
## 15 drinkingbeh drinkingbeh total alter             TRUE    FALSE FALSE    0.00000   0   
## siena07 will create an output file s50CoEv_3.txt .
## Estimates, standard errors and convergence t-ratios
## 
##                                                Estimate   Standard   Convergence 
##                                                             Error      t-ratio   
## Network Dynamics 
##    1. rate constant friendship rate (period 1)  6.4714  ( 1.2823   )   -0.0436   
##    2. rate constant friendship rate (period 2)  5.1689  ( 0.8075   )    0.0244   
##    3. eval outdegree (density)                 -2.7653  ( 0.1628   )    0.0442   
##    4. eval reciprocity                          2.3927  ( 0.2379   )    0.0496   
##    5. eval transitive triplets                  0.6507  ( 0.1471   )    0.0403   
##    6. eval 3-cycles                            -0.0799  ( 0.2978   )    0.0439   
##    7. eval smoke1 similarity                    0.1762  ( 0.2153   )    0.0224   
##    8. eval drinkingbeh alter                   -0.0399  ( 0.1113   )   -0.0370   
##    9. eval drinkingbeh ego                      0.0654  ( 0.1129   )   -0.0542   
##   10. eval drinkingbeh similarity               1.3385  ( 0.6253   )    0.0334   
## 
## Behavior Dynamics
##   11. rate rate drinkingbeh (period 1)          1.3061  ( 0.3478   )    0.0225   
##   12. rate rate drinkingbeh (period 2)          1.7778  ( 0.4695   )   -0.0510   
##   13. eval drinkingbeh linear shape             0.4101  ( 0.2213   )   -0.0379   
##   14. eval drinkingbeh quadratic shape         -0.5303  ( 0.2699   )   -0.0671   
##   15. eval drinkingbeh total alter              0.4202  ( 0.2333   )   -0.0270   
## 
## Overall maximum convergence ratio:    0.1491 
## 
## 
## Total of 3197 iteration steps.
```

What would you conclude?  

- Yes, we observe selection based on drinking.  
- Yes, we observe influence via the drinking behavior of befriended alters.  

# Assignment

**Assignment:** Formulate at least three research questions with respect to selection and influence effects among pupils with respect to physical activity. Test these effects on the MyMovez dataset.  

- start with descriptive statistics  
- estimate subsequent models (at least three) and please motivate the order by which you include additional effects/variables    
- include at least two multiplex effects    
- include/try at least four behavioral-evolution effects  

## testing and finding optimal model
You probably need to estimate quite some models. To speed things up, you may want to tweak your algorithm by `sienaAlgorithm` or you may want to run you models on a subsample first. 

### sienaAlgorithm
Have a look at the function: `?sienaAlgorithm`. You could change n3 to 500 and nsub to 2. 


### select only one class

You may want to test your models first on one class only. When you are satisfied, you could run your models on the total class pool. In the code snippet below, you see how to select one class and make a new RSiena dataobject.  


```{.r .highlightt .numberLines}
# these are the respective class sizes.
nclass <- c(28, 18, 18, 18, 18, 25, 24)
classid <- rep(1:7, times = nclass)

test <- ExData[classid == 1]  #change classid to select a different class. 
# because everything needs to be mean centered again also make sure to run the next command
class1 <- sienaDataCreate(test$depvars$friendship, test$depvars$advice, test$depvars$mvpa_y, test$cCovars$ethnicNLNA, 
    test$cCovars$sex, test$cCovars$lft, test$cCovars$primary, test$vCovars$mvpa_x)
```

## An example on the MyMovez dataset


```{.r .highlightt .numberLines}
require(RSiena)
require(xtable)  # for some html output

# Step 1: DATA
load("beh_data.RData")
mydata <- ExData

# Stept 2: some first summary
print01Report(mydata, modelname = "segtest1")
# look at the printed doc!!

# Step 3: set algorithm
myalgorithm <- sienaAlgorithmCreate(projname = "segtest1")
```

```
## siena07 will create an output file segtest1.txt .
```

```{.r .highlightt .numberLines}
# Step 4: set effects
NBeff <- getEffects(mydata)
# have a look at all possible effects effectsDocumentation(NBeff) #uncomment if you want to have a
# look

# possible order?  a: uncontrolled for network structure effects b: controlled for network structure
# effects M1a/b: selection: homophily tendencies demographics: simsex, simethnic, M2a/b: selection:
# homophily tendencies health: MVPA_y M3a/b: influence: on health M4: total

# I am just estimating the total model in this example.

# Structural effects only focus on friendship network in this example, thus specifying 'name'
# argument is not necessary.
NBeff <- includeEffects(NBeff, inPop, transTrip, transRecTrip)
```

```
##   effectName                              include fix   test  initialValue parm
## 1 friendship: transitive triplets         TRUE    FALSE FALSE          0   0   
## 2 friendship: transitive recipr. triplets TRUE    FALSE FALSE          0   0   
## 3 friendship: indegree - popularity       TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
# selection effects
NBeff <- includeEffects(NBeff, egoX, altX, egoXaltX, interaction1 = "ethnicNLNA")
```

```
##   effectName                                    include fix   test  initialValue parm
## 1 friendship: ethnicNLNA alter                  TRUE    FALSE FALSE          0   0   
## 2 friendship: ethnicNLNA ego                    TRUE    FALSE FALSE          0   0   
## 3 friendship: ethnicNLNA ego x ethnicNLNA alter TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
NBeff <- includeEffects(NBeff, egoX, altX, sameX, interaction1 = "sex")
```

```
##   effectName            include fix   test  initialValue parm
## 1 friendship: sex alter TRUE    FALSE FALSE          0   0   
## 2 friendship: sex ego   TRUE    FALSE FALSE          0   0   
## 3 friendship: same sex  TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
NBeff <- includeEffects(NBeff, egoX, altX, absDiffX, interaction1 = "mvpa_y")
```

```
##   effectName                         include fix   test  initialValue parm
## 1 friendship: mvpa_y alter           TRUE    FALSE FALSE          0   0   
## 2 friendship: mvpa_y ego             TRUE    FALSE FALSE          0   0   
## 3 friendship: mvpa_y abs. difference TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
# behavioral model: node effects
NBeff <- includeEffects(NBeff, effFrom, name = "mvpa_y", interaction1 = "sex")
```

```
##   effectName              include fix   test  initialValue parm
## 1 mvpa_y: effect from sex TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
NBeff <- includeEffects(NBeff, effFrom, name = "mvpa_y", interaction1 = "lft")
```

```
##   effectName              include fix   test  initialValue parm
## 1 mvpa_y: effect from lft TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
NBeff <- includeEffects(NBeff, effFrom, name = "mvpa_y", interaction1 = "ethnicNLNA")
```

```
##   effectName                     include fix   test  initialValue parm
## 1 mvpa_y: effect from ethnicNLNA TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
# influence effects
NBeff <- includeEffects(NBeff, totSimRecip, name = "mvpa_y", interaction1 = "friendship")
```

```
##   effectName                                  include fix   test  initialValue parm
## 1 mvpa_y tot. sim. x reciprocity (friendship) TRUE    FALSE FALSE          0   0
```

```{.r .highlightt .numberLines}
# look at all effects
NBeff
```

```
##    name       effectName                                    include fix   test  initialValue parm
## 1  friendship constant friendship rate (period 1)           TRUE    FALSE FALSE    7.28417   0   
## 2  friendship constant friendship rate (period 2)           TRUE    FALSE FALSE    7.27877   0   
## 3  friendship friendship: outdegree (density)               TRUE    FALSE FALSE   -1.25979   0   
## 4  friendship friendship: reciprocity                       TRUE    FALSE FALSE    0.00000   0   
## 5  friendship friendship: transitive triplets               TRUE    FALSE FALSE    0.00000   0   
## 6  friendship friendship: transitive recipr. triplets       TRUE    FALSE FALSE    0.00000   0   
## 7  friendship friendship: indegree - popularity             TRUE    FALSE FALSE    0.00000   0   
## 8  friendship friendship: ethnicNLNA alter                  TRUE    FALSE FALSE    0.00000   0   
## 9  friendship friendship: ethnicNLNA ego                    TRUE    FALSE FALSE    0.00000   0   
## 10 friendship friendship: ethnicNLNA ego x ethnicNLNA alter TRUE    FALSE FALSE    0.00000   0   
## 11 friendship friendship: sex alter                         TRUE    FALSE FALSE    0.00000   0   
## 12 friendship friendship: sex ego                           TRUE    FALSE FALSE    0.00000   0   
## 13 friendship friendship: same sex                          TRUE    FALSE FALSE    0.00000   0   
## 14 friendship friendship: mvpa_y alter                      TRUE    FALSE FALSE    0.00000   0   
## 15 friendship friendship: mvpa_y ego                        TRUE    FALSE FALSE    0.00000   0   
## 16 friendship friendship: mvpa_y abs. difference            TRUE    FALSE FALSE    0.00000   0   
## 17 advice     constant advice rate (period 1)               TRUE    FALSE FALSE    5.39192   0   
## 18 advice     constant advice rate (period 2)               TRUE    FALSE FALSE    4.07544   0   
## 19 advice     advice: outdegree (density)                   TRUE    FALSE FALSE   -1.73553   0   
## 20 advice     advice: reciprocity                           TRUE    FALSE FALSE    0.00000   0   
## 21 mvpa_y     rate mvpa_y (period 1)                        TRUE    FALSE FALSE    2.17740   0   
## 22 mvpa_y     rate mvpa_y (period 2)                        TRUE    FALSE FALSE    2.87832   0   
## 23 mvpa_y     mvpa_y linear shape                           TRUE    FALSE FALSE    0.04291   0   
## 24 mvpa_y     mvpa_y quadratic shape                        TRUE    FALSE FALSE    0.00000   0   
## 25 mvpa_y     mvpa_y tot. sim. x reciprocity (friendship)   TRUE    FALSE FALSE    0.00000   0   
## 26 mvpa_y     mvpa_y: effect from ethnicNLNA                TRUE    FALSE FALSE    0.00000   0   
## 27 mvpa_y     mvpa_y: effect from sex                       TRUE    FALSE FALSE    0.00000   0   
## 28 mvpa_y     mvpa_y: effect from lft                       TRUE    FALSE FALSE    0.00000   0
```

```{.r .highlightt .numberLines}
# Please uncomment this section. I just don't want to reestimate the model. It does take a while.
# (ans <- siena07( myalgorithm, data = ExData, effects = NBeff)) save(ans, file='ans.RData')
# siena.table(ans, type='html', tstat=T, d=2, sig=T)
load("ans.RData")
ans
```

```
## Estimates, standard errors and convergence t-ratios
## 
##                                                          Estimate   Standard   Convergence 
##                                                                       Error      t-ratio   
## Network Dynamics 
##    1. rate constant friendship rate (period 1)            5.2601  ( 0.3035   )   -0.0635   
##    2. rate constant friendship rate (period 2)            5.8955  ( 0.4876   )   -0.0676   
##    3. eval friendship: outdegree (density)                2.7341  ( 2.2175   )   -0.0638   
##    4. eval friendship: reciprocity                        2.9414  ( 1.8683   )   -0.1328   
##    5. eval friendship: transitive triplets                0.9225  ( 0.4882   )   -0.0978   
##    6. eval friendship: transitive recipr. triplets       -0.8119  ( 0.5046   )   -0.1375   
##    7. eval friendship: indegree - popularity             -0.2624  ( 0.1349   )   -0.0828   
##    8. eval friendship: ethnicNLNA alter                  -0.1208  ( 0.3393   )    0.0060   
##    9. eval friendship: ethnicNLNA ego                     0.0291  ( 0.3723   )   -0.0137   
##   10. eval friendship: ethnicNLNA ego x ethnicNLNA alter  0.0181  ( 0.9868   )   -0.0493   
##   11. eval friendship: mvpa_y alter                       0.0624  ( 0.5220   )    0.0570   
##   12. eval friendship: mvpa_y ego                        -0.3947  ( 0.3123   )   -0.0445   
##   13. eval friendship: mvpa_y abs. difference            -3.6551  ( 2.5637   )   -0.0319   
##   14. rate constant advice rate (period 1)                7.3773  ( 0.8998   )    0.0094   
##   15. rate constant advice rate (period 2)                5.4382  ( 0.5426   )   -0.0753   
##   16. eval advice: outdegree (density)                   -1.6276  ( 0.0679   )   -0.0297   
##   17. eval advice: reciprocity                            0.9398  ( 0.1646   )   -0.0359   
## 
## Behavior Dynamics
##   18. rate rate mvpa_y (period 1)                         8.6516  ( 3.4273   )   -0.0135   
##   19. rate rate mvpa_y (period 2)                        25.8909  ( 8.7388   )   -0.0022   
##   20. eval mvpa_y linear shape                           -0.0155  ( 0.0547   )    0.0096   
##   21. eval mvpa_y quadratic shape                         0.0934  ( 0.0701   )   -0.0931   
##   22. eval mvpa_y tot. sim. x reciprocity (friendship)    0.1675  ( 0.1606   )    0.0369   
##   23. eval mvpa_y: effect from ethnicNLNA                 0.2842  ( 0.0969   )    0.0263   
##   24. eval mvpa_y: effect from sex                       -0.1610  ( 0.0993   )   -0.0041   
##   25. eval mvpa_y: effect from lft                       -0.0595  ( 0.0309   )   -0.0271   
## 
## Overall maximum convergence ratio:    0.2810 
## 
## 
## Total of 3944 iteration steps.
```
What would you conclude?

- The selection variable of interest is in the predicted direction but does not reach significance.  
  * Should we model friendship selection based on mvpa_y with a different statistic/effect?  
  * Would we observe the same with respect to advice relations?  
- The influenc variable of interest is in the predicted direction but does not reach significance.  
  * Should we model network influence on mvpa_y with a different statistic/effect?  
  * Would we observe the same with respect to advice relations? 
  
Hopefully, this example gives you enough pointers to make the assignment. 


