# Federalist Papers Investigation Using Clustering Models

## Introduction

The Federalist Papers were a collection of eighty-five essays pushing New Yorkers to ratify the newly formed United States Constitution. The pieces were first published anonymously in New York newspapers in 1787 and 1788 under the pen name “Publius,” and were written by Alexander Hamilton, James Madison, and John Jay. The Federalist Papers are regarded as one of the most important sources for analyzing and comprehending the Constitution’s original intent.

Seventy-four of the eighty-five articles have an identified author, however there are eleven articles that have a disputed author. Both Alexander Hamilton and James Madison claimed to have written these documents and the truth is unknown. This had led to the use of a variety of machine learning and natural language processing techniques to determine the correct author of the disputed articles.

To figure out the appropriate author for the eleven disputed documents this paper will utilize K-Means Clustering and Hierarchical Algorithm Clustering techniques.

## Analysis

#### Data Preprocessing:

The data files consisted of eighty-five text files, one for each of the Federalist Papers. Showing the author and the written body of each specific article. For the eleven disputed articles the author is unknown.

The documents were then read into a Corpus and the files were stripped of anypunctuation, numbers and spaces to identify word frequencies and create a document term matrix.

![image](https://user-images.githubusercontent.com/94664740/227407116-93d6b6f5-1803-40b2-a573-ab634d0a3e6f.png)

The word vectors were then normalized to allow the use of standard analysis techniques.

![image](https://user-images.githubusercontent.com/94664740/227407164-0fcec435-f8e0-46f8-b55f-b1907a74ec58.png)

After normalizing the data was converted to a matrix and a dataframe to make it easier to work with.

![image](https://user-images.githubusercontent.com/94664740/227407199-8e4fa777-0169-4dab-bc4d-d88cc86fe1f9.png)

A word cloud was then created from the document term matrix of the most frequently used words in the corpus.

![image](https://user-images.githubusercontent.com/94664740/227407231-232b5bea-3f6b-4c89-8221-9bd14d4e547b.png)

This gives an insight into what the texts are concerning and what they are talking about. Mainly people, government, senate etc.

Since the data has been vectorized analyses could be performed and data clusters were created using HAC and K-Means methods. Using the HAC method clusters were created with Euclidean, Manhattan, and Cosine methods as well as a normalized Cosine method as well. From these dendograms were plotted to show the results. For K-Means clustering clusters of two and seven were used as well as Manhattan and Euclidean visualization models. 

## Results

Here are the resulting dendograms from the HAC models after computing a variety of distance matrices:

![image](https://user-images.githubusercontent.com/94664740/227407340-5c1aa7cd-2c59-4f80-b86b-6798d82a8643.png)

![image](https://user-images.githubusercontent.com/94664740/227407370-b5cd9d59-3a34-4684-bce5-f604d6d579d3.png)

![image](https://user-images.githubusercontent.com/94664740/227407385-d964885d-be85-44df-a4ab-2b864e7b1666.png)

![image](https://user-images.githubusercontent.com/94664740/227407398-337888db-d92f-4df1-a430-80f6585b977e.png)

From these it appears that the Manhattan and Euclidean models have outperformed the Cosine models as they have all the disputed articles in closely related branches, and they are linked more closely with James Madison.

Next K-Means Clustering was used to see which author the articles related more closely to using a cluster of two and seven. 

![image](https://user-images.githubusercontent.com/94664740/227407443-dd24aed3-c53e-49e4-8fcf-8abb6704b0c4.png)

Here are the results of the k-means visualizations for Manhattan and Euclidean methods as they were the highest performing with the HAC models.

![image](https://user-images.githubusercontent.com/94664740/227407474-4bbac3dd-6303-48e6-bf5c-9718b19ea51a.png)

![image](https://user-images.githubusercontent.com/94664740/227407496-d4ce3cee-8eae-4040-8151-4888a0eeb259.png)

These results are much harder to see so included is the two cluster visualization and results matrix:

![image](https://user-images.githubusercontent.com/94664740/227407527-e2307f78-1aba-49f1-8675-addb76aaf311.png)

Here the breakdown is shown with all of Madison’s articles and the disputed articles in cluster one and most Hamilton’s articles in cluster two.

![image](https://user-images.githubusercontent.com/94664740/227407566-e9def7d4-3303-4971-8174-20848d6cdc93.png)

## Conclusion

From the results of the HAC and K-Means clustering models used, James Madison looks to be the author of the disputed Federalist Papers articles. Both models showed the same result and classification. 

Historically this does present an issue as there are two of America’s founding fathers claiming authorship of key documents in out nations history and that casts a negative light on both men who were very crucial to the founding of this country and our laws.

This paper was successful in solving the historical problem as both models predicted the same outcome, however there are additional classification models that can be used and might return a different result.

