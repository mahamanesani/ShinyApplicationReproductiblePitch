#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(HistData)
data(GaltonFamilies)
library(dplyr)
library(ggplot2)

# First, we convert inches to cm
galtons<-GaltonFamilies
galtons$father<-galtons$father*2.54
galtons$mother<-galtons$mother*2.54
galtons$childHeight<-galtons$childHeight*2.54

# Linear model
fit<-lm(childHeight~father+mother+gender,data=galtons)

shinyServer(function(input,output){
    output$predictionText<-renderText({
        df<-data.frame(father=input$fHeight,
                       mother=input$mHeight,
                       gender=factor(input$Gender,levels=levels(galtons$gender)))
        ch<-predict(fit,newdata=df)
        kid<-ifelse(
            input$Gender=="female","Daughter","Son")
        paste0(em(strong(kid)),
               "'s predicted height is ",
               em(strong(round(ch))),
               " cm"
               )
        
    })
    output$prediction <- renderText({
        df <- data.frame(father=input$fHeight,
                         mother=input$mHeight,
                         gender=factor(input$Gender, levels=levels(galtons$gender)))
        ch <- predict(fit, newdata=df)
        kid <- ifelse(
            input$Gender=="female",
            "Daugther",
            "Son"
        )
        paste0(em(strong(kid)),
               "'s predicted height is going to be around ",
               em(strong(round(ch))),
               "cm"
        )
    })
    
    output$Plot<-renderPlot({
        df<-data.frame(father=input$fHeight,
                       mother=input$mHeight,
                       gender=factor(input$Gender,levels=levels(galtons$gender)))
        ch<-predict(fit,newdata=df)
        kid <- ifelse(input$Gender=="female","Daugther","Son")
        df<-data.frame(
            x=factor(c("Father",kid,"Mother"),levels=c("Father",kid,"Mother"),ordered = TRUE),
            y=c(input$fHeight,ch,input$mHeight)
            )
        ggplot(df,aes(x=x,y=y,color("blue","green","red")))+
            geom_bar(stat="identity",width = 0.5)+
            xlab("")+
            ylab("Height (cm)")+
            theme_minimal()+
            theme(legend.position = "none")
        
    })
})



