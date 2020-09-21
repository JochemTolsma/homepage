---
#Page title
title: Social Networks

# Title for the menu link if you wish to use a shorter link title, otherwise remove this option.
linktitle: Social Networks 2020

# Page summary for search engines.
summary: social networks dyads egoncentric micro-level macro-level definitions social network perspective

# Date page published
date: 2020-08-26

# Academic page type (do not modify).
type: book

# Position of this page in the menu. Remove this option to sort alphabetically.
weight: 1
---

<!---

{{< highlight go >}} A bunch of code here 
2 + 2  
{{< /highlight >}}

{{< youtube id="w7Ft2ymGmfc" autoplay="true" title="my title" >}} 
  

{{% alert note %}}
A Markdown aside is useful for displaying notices, hints, or definitions to your readers.
{{% /alert %}}

{{% alert warning %}}
Here's some important information...
{{% /alert %}}


--->  

## Overview  

Sociologists study how societies affect the lives of their members and, vice versa, how individuals shape the societies in which they live. Within societies people make and break relations with specific others and thereby form ***social networks***.  
Individuals are embedded in many different social networks (e.g. based on friendships, bullying, family relations). Within these social networks individuals influence each others' attitudes, behaviors and relations via complex dynamic processes. 
The attitudes, behaviors and relations of individuals shape, in turn, the societies they live in. They give rise to *social phenomena* such as inequality, segregation, polarization and cohesion. 
It is not possible to explain many macro-level social phenomena, let alone to solve many urgent *social problems*, without taking into account social networks. For example, you may have a good idea about where my personal political attitudes come from but this does not explain political polarization, why specific groups in society hold ever more opposing, extreme political attitudes. It can thus be no surprise that the study of the causes and consequences of social networks lies at the core of sociology.   


{{% alert note %}}
Throughout this course you will find words in *italics*. These words are defined near the bottom of each page. 
{{% /alert %}}

## Aim 

The intended learning outcomes of the course are:
1. Theoretical knowledge and insight: you will be able to define core concepts related to a social network perspective and are able to summarize what a *social network perspective* in social science research entails.  
2. Academic attitude: you develop a positive attitude towards applying a social network perspective in social science research.   
3. Research skills: you will be able to apply a social network perspective in social science research. This encompasses being able to deduce relevant and new social network hypotheses from existing theories and being able to test these hypotheses with different social network analysis techniques. 

## Structure
This course is structured along three different dimensions: (1) the Type of Social Network; (2) Causes versus Consequences of social networks; (3) Theoretical versus Methodological implications of applying a social network perspective. 

**Table.** Structure of the course Social Networks 2020** 

| Type of Social Network | Causes or Consequences| Theory or Method 
| ----------- | ----------- | ----------- |
| Dyads | Causes | Theory |
| Dyads | Causes | Method |
| Dyads | Consequences | Theory |
| Dyads | Consequences | Method |
| Egocentric networks | Causes | Theory |
| Egocentric networks | Causes | Method |
| Egocentric networks | Consequences | Theory |
| Egocentric networks | Consequences | Method |
| Complete (longitudinal) networks | Causes | Theory |
| Complete (longitudinal) networks | Causes | Method |
| Complete (longitudinal) networks | Consequences | Theory |
| Complete (longitudinal) networks | Consequences | Method |

<!---
[dyadscausestheory](dyads/dyads1)

--->

{{% alert note %}}
Feel free to jump to the section you are most interested in. But there is a clear order in the sections. The best way to accumulate theoretical and methodological knowledge, and to gain the necessary R-skills to successfully apply a social network perspective to your own research is by going through the sections one by. 
{{% /alert %}}

## Causes and Consequences
**...or Selection and Influence**  
Social networks consist of social relations between people. For example friendships, bullying relations or working-together-during-the-course-social-networks relations.  
The continuous process of making and breaking social relations is also called **selection**. And the reasons why we make and brake relations with specific persons are important **causes** for the structures of the social networks we observe. Thus the causes of social networks are strongly related to selection processes.  
The people with whom we form social relations also **influence** our attitudes, behaviors and future relations. How we think, behave and with whom we make, break or maintain social relations is for an important part the **consequence** of the social networks in which we are embedded. Thus the consequences of social networks are strongly related to influence processes (but also to selection processes).  
Selection and influence processes are firmly entangled. See below for an example. We could call the selection process 'Opposite Attracts' and we could call the influence process 'circle beats square'.[^1] 

[^1]: The shapes represent social agents (e.g. individuals).  
  The shape (circle or square) of the social agent is a time-stable characteristic (e.g. sex).  
  The fill of the shape (no fill, pattern fill, solid fill) is a time-varying characteristic (e.g. music taste).  
  The line between the shapes (no line, dashed, solid) signifies the strength of the relationship (e.g. romantic relationship)


{{< vimeo id="451942562" autoplay="true" title="A continous dance of selection and influence processes" >}} 

## What makes this course stand out? 
This course is not an introduction to Social Networks or Social Network Analysis. It is also not a course in R. I assume you have some intuitive understanding of what social networks are and have opened R or RStudio at one point in your life but both are not necessary prerequisites to follow this course. There are very good (online) introductions to the study of Social Networks, see for example [here](https://bookdown.org/markhoff/social_network_analysis/) and [here](https://eehh-stanford.github.io/SNA-workshop/).[^2] A good short introduction to R for this course would be [this one](https://www.jtolsma.nl/TutorialCSR/) or have a look [here](https://rafalab.github.io/dsbook/) for a more thorough introduction to Data Science with R.  
This course is tailored for research master and PhD students. I will assume that you are interested in and have studied social problems in your academic career and that your research interests fits one of the following broad themes: **inequality**, **cohesion** and **diversity**. However, up to this point, when you deduced hypotheses from existing theories you did not explicitly acknowledge that individuals are interconnected in social networks. You were neither aware that this may have theoretical consequences for existing hypotheses nor that this gives rise to new research questions. Up to this point, when you tested your hypotheses you assumed that your observations were independent (e.g. OLS) or, at most, that the nonindependence was relatively easy to take into account (e.g. multi-level analysis).[^3]  
In this course you will learn to apply a social network perspective in the study of inequality, cohesion and diversity. You will become able to deduce more precise and new hypotheses. You will become able to test these hypotheses with social network techniques that take into account and explain complex interdependencies.



[^2]: Chapter 7 in: Van Tubergen, F. (2020). Introduction to Sociology. New York, NY: Routledge  
  Wasserman, S., & Faust, K. (1994). *Social network analysis: Methods and applications.* Cambridge, UK: Cambridge University Press  
  Borgatti, S.P., Everett, M.G., & Johnson, J.C. (2018). *Analyzing social networks.* London, UK: Sage Publications Ltd.

[^3]: That individuals are interconnected and hence that observations are not independent can be seen as a **nuisance**. That our observations are not independent violates many assumptions of analysis techniques that social scientists commonly apply (e.g. OLS). In order to correctly estimate the effects of interest we need to take these interdependencies into account with social network analysis techniques.  
  However, that individuals are interconnected and hence that observations are correlated or co-vary also is **theoretically interesting**. It gives rise to a complete new type of research questions. Where normally our research questions refer to describing or explaining the variance between individuals (e.g. why individuals differ) the new set of research questions refer to describing and explaining the covariance between individuals (why some people are more (dis)similar to one another than others.)

## Definitions  

Social Networks
:  A social network is an finite set of actors and the relation(s) defined on this set. The actors are social entities (people, organizations, countries, etc.) whose specific ties (friendship, competition, collaboration, etc.), constitute the network. (Wasserman and Faust, 1994, p. 20)  
Networks are also called: graphs or sociograms  
Actors are also called: points, nodes, agents or vertices.  
Relations are also called: ties, edges or connections.  

{{% alert warning %}}  

**Social Networks is/are no theory nor a method.**

Social networks are social phenomena with causes and consequences.
The size, composition, structure, and development of social networks can be explained. Social networks have an impact on individuals (i.e. attitudes and behavior), dyads (i.e. relations), institutions (e.g. efficiency) and societies (e.g. segregation, opinion polarization). 
{{% /alert %}}


Social Network Perspective
: It is the acknowledgment that individuals are embedded within social networks - no man is an island -  and that this has theoretical and methodological consequences.  
Theoretical consequences: A social network perspective may force to a rethinking of existing hypotheses and may lead to new research questions on the causes and consequences of social networks.  
Methodological consequences: A social network perspective will make explicit that empirical observations of individuals are not always independent and that the (complex) interdependencies between observations that result from social networks have  consequences for many of our traditional research methods which assume independence of observations. It may lead to the development and adoption of new social network analysis techniques.  

Applying a social network perspective leads to theoretical and methodological advancements.  




Social phenomenon
: collective human behavior  

Social problem
: a social phenomenon which people consider undesired. 



<!---
To: Update R tutorial 
--->

<!---
## Definitions  


--->
