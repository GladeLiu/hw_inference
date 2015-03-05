library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input,output){
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot<-renderPlot({
    library(ggplot2);
    N<-input$samples; prob<-input$Prob;
    alpha<-input$alpha; bins<-input$bins;
    sd<-sqrt((1/((1-prob)^4))*prob*(1-prob));
    gp<-prob/(1-prob);
    gmean<-rep(0,5000);
    set.seed(2015);
    for (i in 1:5000){
      sample<-rbinom(N,1,prob);
      gmean[i]<-(mean(sample))/(1-mean(sample));
    }
    hist<-sqrt(N)*(gmean-gp);
    data<-data.frame(hist=hist);
    p<-ggplot(data,aes(hist))
    p+geom_histogram(position="identity",
                     alpha=alpha, binwidth=bins,
                     aes(y=..density..,fill=..density..))+
      stat_density(geom="line",aes(colour="Density Estimation"))+
      stat_function(fun=dnorm,args=list(mean=0,sd=sd),aes(hist,colour="Normal Distribution"));
  })
})
