library("shiny")
library("tidyverse")
library("fs")
library("patchwork")
library("broom")
library("vroom")

load("data/gravier.RData")

#Data
gravier_data <- bind_cols(
  gravier %>% pluck("y") %>% as_tibble,
  gravier %>% pluck("x") %>% as_tibble
) %>%
  mutate(outcome = case_when(value == "good" ~ 0, 
                             value == "poor" ~ 1)) %>%
  select(outcome,everything(),-value) 

#Make data long (100 samples)
gravier_data_long <- gravier_data %>%
  pivot_longer(!outcome, names_to = "gene", values_to = "log2_expr_level")

#Nested
gravier_data_long_nested <- gravier_data_long %>%
  group_by(gene) %>%
  nest() %>%
  ungroup() %>%
  sample_n(20)

#List of gene names
gene_id <- gravier_data_long_nested %>%
  select(gene) %>%
  unique() 

ui <- fluidPage(
  fluidRow(
    column(6,
           selectInput("Gene","Please select a gene", choices = gene_id))
    ),
    fluidRow(
      column(4, tableOutput("counting"))))

server <- function(input, output, session) {
  selected <- reactive(gravier_data_long_nested %>% filter(gene == input$Gene))
  
  output$counting <- renderTable(
    selected() %>% mean()
  )}
  
 # output$log2_exp <- renderPlot({
    #ggplot(gravier_data_long_nested, mapping = aes(x = c(1:168), log2_expr_level)) +
      #geom_line()})}

shinyApp(ui = ui, server = server)
    
    
  
#gravier_data_long_nested %>% 
#  select()
  

