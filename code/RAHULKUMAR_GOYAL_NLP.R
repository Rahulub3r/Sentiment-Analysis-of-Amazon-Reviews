library(readr)
library(shiny)
library(shinythemes)
library(tm)
library(stringr)
library(DT)
library(rWordCloud)
library(ggplot2)
library(plyr)
library(dplyr)

ui <- shinyUI(navbarPage(theme = shinytheme("united"),"RAHULKUMAR_GOYAL_NLP", fluid = TRUE,
                         tabPanel('Tables',
                                  sidebarLayout(
                                          sidebarPanel(
                                                br(),
                                                p("Please wait for the table to load", align = "Justify"),
                                                br(),
                                                br(),
                                                tags$style(type = "text/css",
                                                           "label {font-size: 15px;}"
                                                           ),
                                                radioButtons("TT",label = h3("Please choose a table"),
                                                             c("Unnormalized Table" = "UT",
                                                                "Normalized Table" = "NT")),
                                                br(),
                                                br(),
                                                h4('Description:'),
                                                h3('The normalization of the reviews included removal of
                                                  html tags, removal of punctuations,
                                                  converting all text to lower, removal of stop words and
                                                  removal of extra spaces')
                                        ),
                                 mainPanel(
                                         h2("Amazon Reviews Table"),
                                        br(),
                                        br(),
                                        tags$div(tags$h4(tags$style(type = "text/css",
                                                                 "#Table1{color: black;
                                                                  font-size: 18px;
                                                                  font-style: italic;
                                                                  }"
                                                         )
                                                 )),
                                        h4(div(DT::dataTableOutput("Table1"),
                                                     style = 'width: 90%'))
                         ))),
                         tabPanel('Frequencies',
                                  sidebarLayout(
                                          sidebarPanel(
                                                  br(),
                                                  tags$style(type = "text/css",
                                                             "label {font-size: 15px;}"
                                                  ),
                                                  radioButtons("Freqs",label = h3("Choose one of the below"),
                                                               c("Unnormalized Review Frequencies of Unigrams" = "UF",
                                                               "Normalized Word Frequencies of Unigrams" = "NF",
                                                               "Unnormalized Reviews Frequencies of Bigrams" = "BUF",
                                                               "Normalized Reviews Frequencies of Bigrams" = "BNF")),
                                                  br(),
                                                  br(),
                                                  h4('Description:'),
                                                  h3('As we can see the Unnormalized reviews table shows stopwords which 
                                                     are of no meaning to the analysis. Seeing 
                                                     different pages in the bigrams will give a gist of what people are
                                                     taking about like "Highly recommended", "Dogs love", etc.,')
                                                  ),
                                          mainPanel(
                                                  h3('Showing top 200 words'),
                                                  br(),
                                                  br(),
                                                  tags$div(tags$h4(tags$style(type = "text/css",
                                                                              "#Table1{color: white;
                                                                              font-size: 18px;
                                                                              font-style: italic;
                                                                              }"
                                                         )
                                                  )),
                                                  h4(div(DT::dataTableOutput("Table2"), style = 'width: 30%')),
                                                  br(),
                                                  br()
                                                  )
                                          )
                                  ),
                         tabPanel('Word Clouds of Bigrams',
                                  fluidPage(
                                          sidebarLayout(
                                                  sidebarPanel(
                                                          br(),
                                                          h4('Please wait while you slide as the clouds may take time to form', align = 'Justify'),
                                                          br(),
                                                          sliderInput('nums', 'Choose the number of words you want to see', min = 1, max = 1000,
                                                                      value = 200),
                                                          br(),
                                                          br(),
                                                          h4('Description:'),
                                                          h3('Bigrams seem more intuitive than unigrams for this dataset. Vanilla flavor and flavored
                                                             coffees and some others are the ones which are being spoken about the most. Also, be it the
                                                             unigrams or bigrams for the unnormalized text it is not intuitive because they show stop words
                                                             which are of no use')
                                                  ),
                                                  mainPanel(
                                                          h3("Click on any word to see it's frequency below the wordcloud"),
                                                          br(),
                                                          tabsetPanel(
                                                                  tabPanel('Unnormalized Word Cloud of Unigrams', d3CloudOutput('plot1', width = '80%', height = 400),
                                                                           h2(htmlOutput('text1'))),
                                                                  tabPanel('Normalized Word Cloud of Unigrams', d3CloudOutput('plot2', width = '85%', height = 400),
                                                                           h2(htmlOutput('text2')))
                                                          )
                                                          
                                                  )
                                          )
                                          )
                                  ),
                         tabPanel('Affinities',
                                  fluidPage(
                                          h2('Description: ', align = "Justify"),
                                          br(),
                                          h4("The first 6 rows in the table below
                                             are the most reviewd products. The average
                                             score and average sentiments were calculated for each product", align = "Center"),
                                          br(),
                                          br(),
                                          
                                          fluidRow(column = 8,
                                                   h4(div(DT::dataTableOutput("Table3")),
                                                      tags$div(tags$h4(tags$style(type = "text/css",
                                                                                  "#Table1{color: white;
                                                                                  font-size: 18px;
                                                                                  font-style: italic;
                                                                                  }"
                                                         )
                                                      )),
                                                       style = "font-size: 110%; width: 30%"), align = "Center",
                                                   width = "80%")   
                                  )
                         ),
                         tabPanel('Scatter Chart',
                                  fluidPage(
                                          h2('Description', align = "Justify"),
                                          br(),
                                          h4('The correlations (displayed in the plots) are very low which does not say
                                             a lot about the relation. But, there seems to be a general
                                             increase in sentiment score as the rating increases.
                                             There are a lot of positive reviews where the "Sentiment" is less
                                             than zero. The problem is due to weak afinn table i.e.,if a customer says "no problem" for a rating 5 the afinn table
                                             given table will throw a negative score for both the words
                                             "no" and "problem" resulting in a negative sentiment. To improve
                                             the sentiment analysis we can:', align = "Center"),
                                          h4('1) Do more processing on the dataset like stemming and lemmatization', align = "Center"),
                                          h4('2) Use affinity scores for bigrams and trigrams as well', align = "Center"),
                                          h4('3) Build a prediction model to calculate sentiment where the dependent variable will be rating and the independednt variable will be the text
                                             which will tell us better about the sentiment', align = "Center"),
                                          br(),
                                          fluidRow(column = 8, align = "Center",
                                                   plotOutput('plot3', width = '70%', height = "500px"))
                                  ))
                         )
              )

server <- function(input,output){
        reviews <- read_csv('data/FewProducts.csv')
        
        tagremover <- function(htmlstring){
                return(gsub("<.*?>", "", htmlstring))
        }
        
        reviews$Text <- mapply(tagremover, reviews$Text)
        #created a function called normalizer but it was taking more time than tm_map so used tm_map for normalization
        # normalizer <- function(x){
        #         a <- unlist(str_split(tolower(gsub("[[:punct:]]","",x)), " "))
        #         if(length(which(a == "")) > 0){
        #                 a <- a[-which(a == "")]
        #         }
        #         require(tm)
        #         words <- stopwords('en')
        #         return(a[!(a %in% words)])
        # }
        # x <- mapply(normalizer, x = reviews$Text)
        # names(x) <- NULL
        # a <- x
        # for(i in 1:length(x)){
        #         a[[i]] <- paste(x[[i]], collapse = " ")  
        # }
        # a <- unlist(a)
        documents <- Corpus(VectorSource(reviews$Text))
        
        documents = tm_map(documents, content_transformer(tolower))
        documents = tm_map(documents, removePunctuation)
        documents = tm_map(documents, removeWords, stopwords("english"))
        
        dataframe<-data.frame(text=unlist(sapply(documents, `[`)), stringsAsFactors=F)
        
        dataframe$text <- str_trim(dataframe$text)
        dataframe$text <- gsub("\\s+"," ",dataframe$text)
        dataframe$text1 <- dataframe$text
        dataframe$text1 <- str_split(dataframe$text, " ")
        
        x <- dataframe$text1
        
        ########calculating affintties#########
        afinn <- read.table('data/AFINN-111.txt', sep= "", fill = TRUE, stringsAsFactors = F)
        colnames(afinn) <- c('words', 'score')
        ScoreCalculator <- function(x){
                return(sum(afinn[afinn$words %in% x, 2]))
        }
        scores <- unlist(lapply(dataframe$text1, ScoreCalculator))
        reviews$AfinnScore <- scores
        
        itemlevel <- reviews %>% group_by(ProductId) %>% summarise(NumberOfReviews = n(),
                                                                   MeanAffinityScore = mean(AfinnScore),
                                                                   MeanRating = mean(Score)) %>% arrange(desc(NumberOfReviews))
        itemlevel$MeanRating <- round(itemlevel$MeanRating, digits = 2)
        itemlevel$MeanAffinityScore <- round(itemlevel$MeanAffinityScore, digits = 2)
        
        reviews1 <- reviews
        reviews1$NormalizedText <- dataframe$text
        
        ########words and frequencies for unnormalized unigrams########
        unnormalizedwords <- unlist(str_split(reviews$Text, " "))
        a <- unnormalizedwords
        unnormalizedwords <- sort(table(unnormalizedwords), decreasing = TRUE)
        unnormalizedwords1 <- unnormalizedwords[1:200]
        wrds1 <- names(unnormalizedwords1)
        freqs1 <- as.vector(unnormalizedwords1)
        
        ########words and frequencies for unnormalized bigrams########
        bigramtable1 <- sort(table(unlist(lapply(1:(length(a)-1), function(x)paste(a[x],a[x+1])))), decreasing = TRUE)
        wrds3 <- names(bigramtable1)[1:200]
        freqs3 <- as.numeric(bigramtable1)[1:200]
        
        ########words and frequencies for normalized unigrams########
        normalizedwords <- unlist(str_split(reviews1$NormalizedText, " "))
        b <- unlist(str_split(dataframe$text, " "))
        normalizedwords <- sort(table(normalizedwords), decreasing = TRUE)
        normalizedwords1 <- normalizedwords[1:200]
        wrds2 <- names(normalizedwords1)
        freqs2 <- as.vector(normalizedwords1)
        
        ########words and frequencies for normalized bigrams########
        bigramtable2 <- sort(table(unlist(lapply(1:(length(b)-1), function(x)paste(b[x],b[x+1])))), decreasing = TRUE)
        wrds4 <- names(bigramtable2)[1:200]
        freqs4 <- as.numeric(bigramtable2)[1:200]
        
        cols1 <- c("Id", "ProductId", "UserId", "Text")
        cols2 <- c("Id", "ProductId", "UserId", "Text", "NormalizedText")
         
        output$Table1 <- DT::renderDataTable({
                datatable(switch(input$TT, UT = reviews[,cols1], NT = reviews1[,cols2]),
                          options = list(pageLength = 3), rownames = FALSE
                          ) %>%
                        formatStyle(switch(input$TT, UT = cols1, NT = cols2),
                                    fontWeight = 'bold',
                                    background = 'skyblue',
                                    filter = 'top'
                                    )
        })
        
        output$Table2 <- DT::renderDataTable({
                datatable(switch(input$Freqs, UF = data.frame(words = wrds1, frequencies = freqs1),
                                        NF = data.frame(words = wrds2, frequencies = freqs2),
                                        BUF = data.frame(words = wrds3, frequencies = freqs3),
                                        BNF = data.frame(words = wrds4, frequencies = freqs3)),
                          options = list(pageLength = 7, scrollX = TRUE), rownames = FALSE
                          ) %>%
                        formatStyle(c('words', 'frequencies'),
                                    fontWeight = 'bold',
                                    background = 'skyblue',
                                    filter = 'top',
                                    fontSize = '150%'
                                    )
        })
        
        output$Table3 <- DT::renderDataTable({
                datatable(itemlevel,options = list(pageLength = 8), rownames = FALSE) %>%
                        formatStyle(colnames(itemlevel),
                                    fontWeight = 'bold',
                                    background = 'skyblue',
                                    filter = 'top'
                        )
        })
        
        
        output$plot1 <- renderd3Cloud({
                d3Cloud(text = names(bigramtable1[1:input$nums]), size = as.vector(bigramtable1[1:input$nums]))
        })
        output$plot2 <- renderd3Cloud({
                d3Cloud(text = names(bigramtable2[1:input$nums]), size = as.vector(bigramtable2[1:input$nums]))
        })
        
        output$text1 <- renderText({
                if(!any(names(input)=='d3word')) return ("You havent clicked")
                paste ("The Frequency of the word ",input$d3word,"is ",
                       as.vector(bigramtable1[1:input$nums])[which(names(bigramtable1[1:input$nums]) == input$d3word)])
        })
        output$text2 <- renderText({
                if(!any(names(input)=='d3word')) return ("You havent clicked")
                paste ("The Frequency of the word ",input$d3word,"is ",
                       as.vector(bigramtable2[1:input$nums])[which(names(bigramtable2[1:input$nums]) == input$d3word)])
        })
        
        mostreviewed <- head(itemlevel)
        analysis_products <- list()
        
        for(i in 1:nrow(mostreviewed)){
                analysis_products[[i]] <- reviews[which(reviews$ProductId == mostreviewed$ProductId[i]),
                                                  c('AfinnScore', 'Score')]
        }
        names(analysis_products) <- mostreviewed$ProductId
        
        newdf <- ldply(analysis_products, data.frame)
        colnames(newdf)[1] <- 'ProductId'
        cors <- ddply(newdf, c('ProductId'), summarise, cor = round(cor(AfinnScore, Score), 2))
        
        output$plot3 <- renderPlot({
                ggplot(newdf, aes(x = AfinnScore, y = Score)) + geom_point() +
                        geom_smooth(method = 'lm', formula = y~x)+
                        facet_wrap(~ProductId)+
                        theme(panel.background = element_rect(fill = "aliceblue"),
                              plot.background = element_rect(fill = 'lightblue1'),
                              panel.grid.major = element_blank(),
                              panel.grid.minor = element_blank(),
                              text = element_text(size = 20)) +
                        xlab('Affinity Score') + ylab('Rating') +
                        ggtitle('Scatter plot of the 6 most reviewed products')+
                        geom_text(data = cors, aes(label = paste("Correlation=",cor)), x = 18, y = 6)
        })
}

shinyApp(ui = ui, server = server)
