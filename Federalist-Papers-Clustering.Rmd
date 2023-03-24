---
author: "Nicholas Lichtsinn"
date: "3/29/2022"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Installing packages and importing libraries

```{r}

#install.packages("wordcloud")
library(wordcloud)
#install.packages("tm")
library(tm)
library(slam)
#install.packages("quanteda")
library(quanteda)
library(SnowballC)
library(arules)
library(proxy)
library(cluster)
#install.packages("stringi")
library(stringi)
library(Matrix)
#install.packages("tidytext")
library(tidytext)
library(plyr)
library(ggplot2)
#install.packages("FactoMineR")
library("FactoMineR")
#install.packages("factoextra")
library(factoextra)
#install.packages("mclust")
library(mclust)
library(dplyr)

library(dendextend)
```


```{r}
# Loading the Corpus
FedPapersCorpus <- Corpus(DirSource("FedPapersCorpus"))
(nFedPapersCorpus <- length(FedPapersCorpus))
```
```{r}
# Showing the Corpus
summary(FedPapersCorpus)
```


```{r}
# Data Cleaning
(getTransformations())
```



```{r}
# Getting min and max terms
(minTermFreq <- nFedPapersCorpus * 0.0001)
(maxTermFreq <- nFedPapersCorpus * 1)
```




```{r}
# Building stop words
MyStopWords <- c("will", "one", "two", "may", "less", "well", "might", "without", "small", "single", "several", "but", "very", "can", "must", "also", "any", "and", "are", "however", "into", "almost", "can", "for", "add")

STOPS <- stopwords('english')
```




```{r}
# Building the Document Term Matrix
Papers_DTM <- DocumentTermMatrix(FedPapersCorpus,
                                 control = list(
                                   stopwords = TRUE,
                                   wordLengths = c(3, 15),
                                   removePunctuation = T,
                                   removeNumbers = T,
                                   tolower = T,
                                   stemming = T,
                                   remove_separators = T,
                                   stopwords = MyStopWords,
                                   bounds = list(global = c(minTermFreq, maxTermFreq))
                                 ))

DTM <- as.matrix(Papers_DTM)
(DTM[1:11, 1:10])
```




```{r}
# Inspecting Initial Cleaning Results
WordFreq <- colSums(as.matrix(Papers_DTM))
(head(WordFreq))
```



```{r}
# Looking at word frequencies
(length(WordFreq))
ord <- order(WordFreq)
(WordFreq[head(ord)])
(WordFreq[tail(ord)])
```

```{r}
# Row Sums per Fed Papers
(Row_Sum_Per_Doc <- rowSums((as.matrix(Papers_DTM))))
```

```{r}
# Creating a normalized version of Papers_DTM
Papers_M <- as.matrix(Papers_DTM)
Papers_M_N1 <- apply(Papers_M, 1, function(i) round(i/sum(i),3))
Papers_Matrix_Norm <- t(Papers_M_N1)
# Looking at the original and normalized to check
(Papers_M[c(1:11), c(1000:1010)])
```

```{r}
(Papers_Matrix_Norm[c(1:11),c(1000:1010)])
```

```{r}
# Converting to a matrix to view
Papers_dtm_Matrix <- as.matrix(Papers_DTM)
str(Papers_dtm_Matrix)
```

```{r}
# Converting to a dataframe
Papers_df <- as.data.frame(as.matrix(Papers_DTM))
str(Papers_df)
```
```{r}
# Creating a WordCloud
DisputedPapersWC <- wordcloud(colnames(Papers_dtm_Matrix), Papers_dtm_Matrix[11,])
```

```{r}
# Looking at the top word frequency
(head(sort(as.matrix(Papers_DTM)[11,], decreasing = TRUE, n=50)))
```

```{r}
# Analysis - applying distance metrics to see how the data clusters
#Distance Measure
m <- Papers_dtm_Matrix
m_norm <- Papers_Matrix_Norm

distMatrix_E <- dist(m, method="euclidean")
#print(distMatrix_E)

distMatrix_M <- dist(m, method="manhattan")
#print(distMatrix_M)

distMatrix_C <- dist(m, method="cosine")
#print(distMatrix_C)

distMatrix_C_Norm <- dist(m_norm, method='cosine')
#print(distMatrix_C_Norm)

# Cosine works the best, norm vs not norm about the same due to size of the papers

```

```{r}
# HAC (Hierarchical Algorithm Clustering) Clustering
# Euclidean Similarity
groups_E <- hclust(distMatrix_E, method = "ward.D")
plot(groups_E, cex=0.5, font=22, hang=-1, main= "HAC Cluster Dendogram with Euclidean Similarity")
rect.hclust(groups_E, k=2)

```
```{r}
# Manhattan Similarity
groups_M <- hclust(distMatrix_M, method = "ward.D")
plot(groups_M, cex=0.5, font=22, hang=-1, main= "HAC Cluster Dendogram with Manhattan Similarity")
rect.hclust(groups_M, k=2)
```

```{r}
# Cosine Similarity
groups_C <- hclust(distMatrix_C, method = "ward.D")
plot(groups_C, cex=0.5, font=22, hang=-1, main= "HAC Cluster Dendogram with Cosine Similarity")
rect.hclust(groups_C, k=2)
```

```{r}
# Normalized Cosine Similarity
groups_C_Norm <- hclust(distMatrix_C_Norm, method = "ward.D")
plot(groups_C_Norm, cex=0.5, font=22, hang=-1, main= "HAC Cluster Dendogram with Normalized Cosine Similarity")
rect.hclust(groups_C_Norm, k=2)
```

```{r}
# K Means Clustering Methods
X <- m_norm
k2 <- kmeans(X, centers = 2, nstart = 100, iter.max = 50)
str(k2)
```

```{r}
k3 <- kmeans(X, centers = 7, nstart = 50, iter.max = 50)
str(k3)
```

```{r}
# K Means Visualization Results
# distance vis for Manhattan
distanceM <- get_dist(X, method = "manhattan")
fviz_dist(distanceM, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
```

```{r}
# distance vis for Euclidean
distanceE <- get_dist(X, method = "euclidean")
fviz_dist(distanceE, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
```

```{r}
# Distance vis Spearman
distanceS <- get_dist(X, method = "spearman")
fviz_dist(distanceS, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
```

```{r}
str(X)
```

```{r}
## K Means Fit
kmeansFIT_1 <- kmeans(X, centers = 2)
summary(kmeansFIT_1)
```

```{r}
## K Means Fit cluster
(kmeansFIT_1$cluster)
cluster <- table(Papers_df$author, kmeansFIT_1$cluster)

Papers_df$Clusters <- as.factor(kmeansFIT_1$cluster)
```

```{r}


ggplot(data=Papers_df, aes(x=author, fill=Clusters))+
  geom_bar(stat="count") +
  labs(title = "K = ?") +
  theme(plot.title = element_text(hjust=0.5), text=element_text(size=15))
```

```{r}
#install.packages("reshape")
library(reshape)
library(ggplot2)
KMC <- kmeans(Papers_df, 4, nstart = 20)
KCT <- table(Papers_df$author, KMC$cluster)
melted_kmeans <- melt(KCT)
ggplot(data = Papers_df, aes(x=author, y=2, fill=Clusters)) + 
  geom_tile() + 
  labs(x = 'Cluster', y = 'Author', title = 'Author vs Cluster')
```
