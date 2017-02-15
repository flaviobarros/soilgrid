## Arquivo da interface
library(shiny)
library(shinyjs)

appCSS <- "
#loading-content {
  position: absolute;
  background: #000000;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #FFFFFF;
}
"

ui <- fluidPage(
  useShinyjs(),
  inlineCSS(appCSS),
  
  # Loading message
  div(
    id = "loading-content",
    h2("Loading...")
  ),
  
  # The main app code goes here
  hidden(
    div(
      id = "app-content",
        
        ## Título da página  
        titlePanel('Escolha uma coordenada geografica'),
        
        ## Definição do layout com barra lateral
        sidebarLayout(
          
          ## Definições da ui para a barra lateral
          sidebarPanel(
            
            ## Input para arquivo
            fileInput('file1', 'Escolha um arquivo CSV',
                      accept=c('text/csv', 
                               'text/comma-separated-values,text/plain', 
                               '.csv')),
            tags$hr(),
            
            ## Checkbox para o arquivo com cabeçalho ou não
            checkboxInput('header', 'Cabeçalho', TRUE),
            
            ## Indicação para separador
            radioButtons('sep', 'Separador',
                         c(Comma=',',
                           Semicolon=';',
                           Tab='\t'),
                         ','),
            
            ## Indicação de quota
            radioButtons('quote', 'Quote',
                         c(None='',
                           'Double Quote'='"',
                           'Single Quote'="'"),
                         '"')
          ),
          
          ## Painel principal
          mainPanel(
            
            ## Define conjunto de abas
            tabsetPanel(
              
              ## Primeira aba
              tabPanel("Dados",
                       h4(textOutput("caption1")),
                       tableOutput('raw'),
                       value = 1),
              
              ## Segunda aba
              tabPanel("Download",
                       tableOutput('filtrado'),
                       downloadButton('downloadData', 'Download')
              )
            )
          )
        )
      
    )
  )
)

  
  