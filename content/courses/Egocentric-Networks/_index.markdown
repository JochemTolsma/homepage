+++
  title = "Egocentric Networks"
  linktitle = "Egocentric Networks"
  date = 2020-09-05
  toc = true  # Show table of contents? true/false
  type = "book"  # Do not modify.
  weight = 2
+++




<!---
---
# Course title, summary, and position.
linktitle: Egocentric Networks
summary: Influence and selection among alters.
weight: 2

# Page metadata.
title: Egocentric Networks
date: "2018-09-09T00:00:00Z"
lastmod: "2018-09-09T00:00:00Z"
draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: book  # Do not modify.
---> 


## Network degree  

We could define an egocentric social network as a set of actors that all have relationships with ego. This definition is quite similar to Marsden's (1990) definition: "Sets of ties surrounding sampled individual units."[^M] To illustrate what is meant by these definitions, let us us consider the following 'world'. And visualize the best-friend-forever relationships in this world.

[^M]: Marsden, P.V. (1990) Network data and measurement. *Annual review of sociology, 16*(1), 435-463



<img src="/courses/Egocentric-Networks/_index_files/figure-html/unnamed-chunk-2-1.png" width="672" />
And now sample a random person. The person we sampled, ego, is made red and square in our network. 

<img src="/courses/Egocentric-Networks/_index_files/figure-html/unnamed-chunk-3-1.png" width="672" />

Let us zoom in a little bit. 

<img src="/courses/Egocentric-Networks/_index_files/figure-html/unnamed-chunk-4-1.png" width="672" />

### 1.0 degree  

Let's suppose we had asked this person to name all its best-friend-forevers (BFFs). If we would assume that BFF relations are undirected, then this person's egocentric or 1.0 degree network would look like this: 

<img src="/courses/Egocentric-Networks/_index_files/figure-html/unnamed-chunk-5-1.png" width="672" />
The alters with whom ego is not connected are not part of the egocentric network. And generally, if we collect data we do not have any information on these unconnected alters. 

### 1.5 degree network  

We may have asked ego - with the question below - whether its BFFs are also BFFs of one another.

> Please think about the relations between the people you just mentioned. Some of them may be total strangers in the sense that they wouldn’t recognize each other if they bumped into each other on the street. Others may be especially close, as close or closer to each other as they are to you. Are they especially close? PROBE: As close or closer to each other as they are to you?


It turns out that two alters in ego's BFF-network are also BFFs of each other. If we know the relations between the alters in a 1.0 degree network it becomes a 1.5 degree network. See below: 

<img src="/courses/Egocentric-Networks/_index_files/figure-html/unnamed-chunk-6-1.png" width="672" />
In the lower-left corner we see a closed *Triad*. For more information on Triads jump to this [section]({{< ref "../Intermezzo-I-Triads" >}}) 


### 2.0 degree network

Perhaps, instead of asking whether there are BFF relations between the BFFs of ego, we  could also have used a snowball sampling method and interviewed the alters (or BFFs) of ego. Note that the focal actor (initial sampled unit) remains ego. 
Thus, if we would have asked ego's alters to name their BFFs, we would have discovered the following 2.0 degree network: 
<img src="/courses/Egocentric-Networks/_index_files/figure-html/unnamed-chunk-7-1.png" width="672" />
The newly discovered alters are in light blue. Naturally, we also observe the BFF relation between ego's alters appearing. Please note that in a 2.0 degree network the number of alters within the 1.0 degree network of ego will remain the same (assuming that ego did not forget to mention a BFF). 

### 2.X degree network

Any ideas about what a 2.5 degree network would look like. To be honest, I don't. Do these networks include all relations between all nodes, or only the relations between the alters in the separate 1.0 degree networks? Perhaps we could call the latter a 2.5 degree network and the former a 2.75 degree network. 

### Six degrees of seperation 
Teaser...

![](/smallworld.PNG)  

The idea that all people are connected through just six degrees of separation is based on Stanley Milgram's famous 'The small world problem' paper.[^6] We will discuss the small world concept in more detail when we will discuss complete networks. Luckily, you don't need to read the book. Just watch the movie: 


{{< youtube id="JWr5hBNWBOI" autoplay="true" >}}



[^6]: Milgram, S. (1967). The small world problem. *Psychology today*, 2(1), 60-67.

## network size

### core network

#### confidants

We don't have many BFFs. Perhaps it is even a bad example because don't you have at most only one BFF by definition? That said, my daughter (6 years old) claims that all her classmates are BFFs. Anyways. It turns out that if we ask a random sample of adults the following question... 

> From time to time, most people discuss important matters with other people. Looking back over the last six months—who are the people with whom you discussed matters important to you? 
 

...that there are not many people naming more than five persons.[^1] For example, have a look at the table below. Data is from a dataset called CrimeNL.[^2] 

**Table.** Number of confidants in CDN (row %) 

|                            | *Zero*  | *One*   | *Two*   | *Three* | *Four* | *Five* | **Mean** | **SD**   |
|----------------------------|-------|-------|-------|-------|------|------|------|------|
| All Confidants             | 17.71 | 31.48 | 23.71 | 14.45 | 6.65 | 6.00    | 1.79 | 1.39 |
| Higher educated confidants | 39.91 | 31.53 | 15.26 | 7.69  | 3.50  | 2.11 | 1.10  | 1.23 |

*Source: CrimeNL*  
N=3.834  
(own calculations)


[^1]: In many surveys respondents are not even given the opportunity to give more than five persons. 
[^2]: Tolsma, J., Rokven, J., Groenestijn, P. van, Gouweleeuw, J., &  Goudriaan, H. (2015). CrimeNL wave 4: Experiences with crime of the Dutch population in the ten largest communities.
 	(dataset). Radboud University Nijmegen: Sociology


The network of our so-called confidants is called the Core-Discussion-Network (CDN). And the literature accompanying this section deals with the causes and consequences of CDNs.

#### Loved ones

Our CDN network thus commonly consists of maximum 5 confidants. The same holds true if we would ask about our loved ones. 

### Dunbar's number

How would we get to know people with whom you form meaningful relations. That is, the people with whom you form stable social relations with and of whom you know how everyone is connected to one another.  

> Who would you not feel embarrassed about joining uninvited for a drink if you happened to bump into them in a bar? 

My answer would definitely depend on whether it was asked to me before or after corona. ;-)

> Who do you send a Christmas card? 

Mind you, this question to tap into your meaningful relations was constructed before e-cards existed. 

According to Robin Dunbar most people are able to maintain stable social relations with approximately 100-200 people, with 150 being a typical number and it is hence known as Dunbar's number.[^3] 

According to Dunbar each *layer* of our social network has a typical size, where the size of each layer increasing as emotional closeness decreases: 

- loved ones: 5  
- good friends: 15
- friends: 50
- meaningful contacts: 150
- acquaintances: 500
- people you can recognize: 1500

[^3]: Dunbar, R. (2010). *How many friends does one person need?: Dunbar's number and other evolutionary quirks.* London: Faber & Faber.  
Dunbar, R. I., Arnaboldi, V., Conti, M., & Passarella, A. (2015). The structure of online social networks mirrors those in the offline world. *Social networks*, 43, 39-47.

### online 'friends' 

Many people are active on online social networks like FaceBook, Instagram, Strava or what have you. According to this [site](www.statista.com), approximately 40% of U.S Facebook users in the United States (in 2016) had between 0-200 friends, 38% 200-500 friends and 21% 500+ friends. 
There are several crucial differences between the connections we have online versus offline. First of all, it does not cost many resources to make and maintain an online friendship. It may require some social media skills though, which I found out the hard way. After having joined FB at a time when youngster were already moving on to other online communities, it annoyed me to see all kind of uninteresting stories of distant relatives about their cats. I consequently decided to unfriend these persons. This was not appreciated by some other relatives. It turned out I should simply have hidden their content from my timeline. There apparently is a social norm not to unfriend people on FB.   
We already discussed that selection processes should be seen as distinct from deselection processes. I would argue that especially with respect to online social relations within the selection part we need to distinguish processes explaining sending friendship invitations and accepting/declining friendship invitations. 
But notwithstanding these differences, online social networks consist of a series of embedded layers just as offline personal social networks. 

## Literature

**Part 1: Selection** 

McPherson, M., Smith-Lovin, L., & Cook, J. M. (2001). Birds of a feather: Homophily in social networks. Annual review of
sociology, 415-444. 

Small, M. L., Pamphile, V. D., & McMahan, P. (2015). How stable is the core discussion network? Social Networks, 40, 90-102.

**Part 2: Influence** 
Brechwald, W. A., & Prinstein, M. J. (2011). Beyond homophily: A decade of advances in understanding peer influence processes. Journal of Research on Adolescence, 21(1), 166- 179.

Rokven, J. J., de Boer, G., Tolsma, J., & Ruiter, S. (2017). 
How friends’ involvement in crime affects the risk of offending and victimization. European journal of criminology , 14(6), 697-719.

**Recommended:**
Smith, K. P., & Christakis, N. A. (2008). Social networks and health. Annual Review of Sociology, 34, 405-429.

McPherson, M., Smith-Lovin, L., & Brashears, M. E. (2006). Social isolation in America: Changes in core discussion networks over two decades. American sociological review,
71(3), 353-375.

Bennink, M. Croon, M.A. & Vermunt, J.K. (2013). Micro-Macro Multilevel analysis for Discrete Data: A Latent Variable Approach and an Application on Personal Network Data. 
Social Methods & Research, 42(4),431-457

Martí, J., Bolíbar, M., & Lozares, C. (2017). Network cohesion and social support. Social networks, 48, 192-201.

## <i class="fas fa-lightbulb"></i> SELF-TEST <i class="fas fa-lightbulb"></i> 

Each chapter ends with a **SELF-TEST**. Using what you learned in this chapter you should be able to answer both the theoretical and methodological part of this [SELF-TEST]({{< ref "/ego5.md" >}}). 

## Definitions

- network layer  
- density  
- triad



