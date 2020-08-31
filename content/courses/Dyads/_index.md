---
# Course title, summary, and position.
linktitle: Dyads
summary: Influence and selection between partners.
weight: 1

# Page metadata.
title: Dyads
date: "2018-09-09T00:00:00Z"
lastmod: "2018-09-09T00:00:00Z"
draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: book  # Do not modify.

---
## Overview

The smallest possible social network is a network between two persons (or, more precisely, between two social agents). A network between two persons is also called a dyad. In the clip below I will introduce you to the the main concepts involved in a dyad. Naturally, the same concepts also play a role in larger social networks. 

{{< vimeo id="452233600" autoplay="true" title="Dyads" >}}
  
  
{{% alert note %}}
After having watched the video you should be able to:  
- give a definition of a dyad.  
- explain what is meant by time-varying and time-constant actor attributes and dyad attributes.  
- explain that relations between ego and alter can be classified  based on whether relations are directed or undirected and on the level of measurement of the relation (i.e. nominal, ordinal, interval, ratio). 
- be familiar with al the synonyms for networks, agents and relations. 
- provide examples of dyads, and the relations between ego and alter.
{{% /alert %}}
  
    
## Causes of dyads (theory)

An important research topic within sociology is **assortative mating** (or intermarriage). Scholars in this field try to explain why two people in an exclusive relationship like marriage are more similar to one another with respect to defining characteristics than two random persons. Assortative mating is a special case of homophily. Assortative mating is an important topic within sociology because it is, next to social mobility, an important indicator of the openness of society.  
In [this section]({{< ref "/dyads1.md" >}}), I will introduce you to a general theoretical model than can be used to explain why people decide to make, break or maintain relationships with specific others. This model closely resembles the theoretical model that is commonly used to explain assortative mating. 

## Causes of dyads (methods)

When testing hypotheses on assortative mating two methodological approaches can be used. We may predict the **frequency of specific dyads** in our population with loglinear models and the data we use is commonly structured in a table like the one below. 

**Table.** Dyad frequencies 

|  | Wife educ-high| Wife educ-low 
| ----------- | ----------- | ----------- |
| **Husband educ-high** | 350 | 150 |
| **Husband educ-low** | 200 | 400 |

Another approach is to take the **characteristics of the dyad** (e.g. endogamy versus mixed) as the dependent variable. This dependent variable can than be explained by applying (conditional) (multinomial) logistic regression techniques. In this case, the data is commonly structured in long format and looks something like the table below. 

**Table.** Dyad characteristics 

|Dyad_id  | Wife educ| Husband educ | dyad_educ   
| ----------- | ----------- | ----------- | ----------- | 
| 1 | high | low | high-low |  
| 2 | high | low | high-low |  
| 3 | low | low | low-low |  
| 4 | low | high | low-high |  
| 5 | high | low | high-low |  
| ... | ... | ... | ... |  



Which methodology is preferred should depend on your hypotheses and on the data you have to your availability. Since I assume most readers are raised within the regression tradition, in [this section]({{< ref "/dyads2.md" >}}) we will practice with estimating conditional multinomial logistic regression models. 

{{% alert warning %}}
Please be aware that in both approaches we normally do not have information on (the frequency or characteristics of) dyads in which there is no relation between ego and alter. Thus, you may have information on characteristics of me and my wife but you do not have information on all other women (or men) I could have married but didn't. I fished my wife out of the sea but we don't know what the other fish looked like. (Luckily my wife is no scientist and won't read this clarification.)
{{% /alert %}}



## Consequences of dyads (theory)

Assortative mating has consequences for both partners. Just to mention a few: relationship quality; time spend together on culture consumption; divorce rates; household income.
In [this section]({{< ref "/dyads3.md" >}}) I will explain a general theoretical framework for explaining how (1) dyad characteristics impact partner characteristics (e.g. number of children on working hour preferences); (2) how characteristics/behavior of one partner may impact characteristics/behavior of the other partner (e.g. my working hours may impact your working hours) and subsequently (3) how the characteristics/behaviors of both partners impact dyad-characteristics (e.g. our working hours on household income). 

## Consequences of dyads (methods)
The method used to explain consequences of dyads depends on our Unit of Analysis. If it is the dyad itself (e.g. relationship quality) methods are relatively straightforward, because we may assume that the observations at the dyad-level are independent. If, on the other hand, the unit of analysis are the partners that make up the dyad, we need to acknowledge that these observations are not independent. In part exactly because partners select and influence each other. In [this section]({{< ref "/dyads4.md" >}}) I will demonstrate how to use actor-partner interdependence models for these situations.

# Selection and influence  
Selection and influence processes are important reasons why nonindependent observations
may arise in dyads. A third reason is that both ego and alter share the same context (e.g. neighbourhood) which influence their charactersitics. 

## Literature

**Part 1: Causes**  

Kalmijn, M. (1998). Intermarriage and homogamy: Causes, patterns, trends. *Annual review of sociology*, 395-421.  

Schwartz, C. R. (2013). Trends and variation in assortative mating: Causes and consequences. *Annual Review of Sociology*, 39, 451-470.  

**Part 2: Consequences**  

Cook, W. L., & Kenny, D. A. (2005). The actor–partner interdependence model: A model of bidirectional effects in developmental studies. *International Journal of Behavioral Development*, 29(2), 101-109.  

Popp, D., Laursen, B., Kerr, M., Stattin, H., & Burk, W. K. (2008). Modeling homophily over time with an actor-partner interdependence model. *Developmental psychology*, 44(4), 1028.  

Recommended:  

Blossfeld, H. P. (2009). Educational assortative marriage in comparative perspective. *Annual review of sociology*, 35, 513-530.  

Verbakel, E., & De Graaf, P. M. (2009). Partner effects on labour market participation and job level: opposing mechanisms. *Work, Employment & Society*, 23(4), 635-654.  

Keizer, R., Schenk, N., 2012. Becoming a parent and relationship satisfaction: A longitudinal dyadic perspective. *Journal of Marriage and Family*, 74, 759-773.  

<!---

## Knowledge clips



## Slides

## Assignments
--->

<!---

# ## Flexibility

# This feature can be used for publishing content such as:
# 
# * **Online courses**
# * **Project or software documentation**
# * **Tutorials**
# 
# The `courses` folder may be renamed. For example, we can rename it to `docs` for software/project documentation or `tutorials` for creating an online course.
# 
# ## Delete tutorials
# 
# **To remove these pages, delete the `courses` folder and see below to delete the associated menu link.**
# 
# ## Update site menu
# 
# After renaming or deleting the `courses` folder, you may wish to update any `[[main]]` menu links to it by editing your menu configuration at `config/_default/menus.toml`.
# 
# For example, if you delete this folder, you can remove the following from your menu configuration:
# 
# ```toml
# [[main]]
#   name = "Courses"
#   url = "courses/"
#   weight = 50
# ```
# 
# Or, if you are creating a software documentation site, you can rename the `courses` folder to `docs` and update the associated *Courses* menu configuration to:
# 
# ```toml
# [[main]]
#   name = "Docs"
#   url = "docs/"
#   weight = 50
# ```
# 
# ## Update the docs menu
# 
# If you use the *docs* layout, note that the name of the menu in the front matter should be in the form `[menu.X]` where `X` is the folder name. Hence, if you rename the `courses/example/` folder, you should also rename the menu definitions in the front matter of files within `courses/example/` from `[menu.example]` to `[menu.<NewFolderName>]`.

--->
