# Sentiment Analysis of Amazon Reviews

**Software:** R <br>
**Presentation:** Shiny App <br>
**Goal:** Analyzing amazon's review data to predict **product sentiments** <br>

### Tasks
1. Data Cleaning <br>
&nbsp;&nbsp;&nbsp;&nbsp;The reviews were clearned using tm package. <br>
&nbsp;&nbsp;&nbsp;&nbsp; Cleaning included removal of HTML tags, punctuations, extra spaces and stopwords.
2. Data Mining<br>
&nbsp;&nbsp;&nbsp;&nbsp;Frequency tables were built for both the normalized reviews and unnormalized reviews.
3. Data Visualization<br>
&nbsp;&nbsp;&nbsp;&nbsp;Interactive wordcloud was built using the rWordCloud package.<br>
&nbsp;&nbsp;&nbsp;&nbsp;Please run the Shiny App and have a good experience of the analysis.
4. Sentiment Analysis<br>
&nbsp;&nbsp;&nbsp;&nbsp;Sentiment Scores were calculated using the AFINN-111 table available online.<br>
&nbsp;&nbsp;&nbsp;&nbsp;Scatter charts were plotted to see the relation between user rating and calculated sentiment.

### NOTE: In the data only top few reviews were considered due to computation constraints.
