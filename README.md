# Sentiment Analysis of Amazon Reviews

**Software:** R
**Presentation:** Shiny App
**Goal:** Analyzing amazon's review data to predict **product sentiments**

### Tasks
1. Data Cleaning
&nbsp;&nbsp;&nbsp;&nbsp;The reviews were clearned using tm package. Cleaning included removal of HTML tags, punctuations, extra spaces and stopwords.
2. Data Mining
&nbsp;&nbsp;&nbsp;&nbsp;Frequency tables were built for both the normalized reviews and unnormalized reviews.
3. Data Visualization
&nbsp;&nbsp;&nbsp;&nbsp;Interactive wordcloud was built using the rWordCloud package.
&nbsp;&nbsp;&nbsp;&nbsp;Please run the Shiny App and have a good experience of the analysis.
4. Sentiment Analysis
&nbsp;&nbsp;&nbsp;&nbsp;Sentiment Scores were calculated using the AFINN-111 table available online.
&nbsp;&nbsp;&nbsp;&nbsp;Scatter charts were plotted to see the relation between user rating and calculated sentiment.

### NOTE: In the data only top few reviews were considered due to computation constraints.
