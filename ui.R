#
# This is the user-interface definition of a Shiny web application. You can  
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Design interface for input and output display
shinyUI(fluidPage(
    titlePanel("Prediction of child height given his parents height"),
    sidebarLayout(
        sidebarPanel(
            helpText("Prediction of the child's height given his gender and parents' height"),
            helpText("Parameters:"),
            sliderInput(inputId = "fHeight",
                        label="Father's height (cm):",
                        value=150,
                        min=150,
                        max=220,
                        step=1),
            sliderInput(inputId = "mHeight",
                        label="Mother's height (cm):",
                        value=140,
                        min=140,
                        max=200,
                        step=1),
            radioButtons(inputId = "Gender",
                         label = "Gender of the child:",
                         choices=c("Female"="female","Male"="male"),
                         inline=TRUE)
    ),
    mainPanel(
        htmlOutput("predictionText"),
        htmlOutput("prediction"),
        plotOutput("Plot",width = "50%")
    )
    )
))
