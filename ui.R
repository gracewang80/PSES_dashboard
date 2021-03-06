
## ~~~~~~~~~~~~ UI ~~~~~~~~~~~~~ ##

 # Created by: Sijia Wang
 # Team: Data Analytics and Business Solutions (DABS)
 # Version: 1.1
 # Last modified: 2020-03-10
 # Description: User interface for 2019 PSES/SAFF dashboard for ROEB and its
 #   directorates.

## ~~~~ Dashboard components (header, sidebar, body) ~~~~~~~~~~~~~~~~~~~~~~~~~~~

header <- dashboardHeader(title = textOutput(outputId="title"))

sidebar <- dashboardSidebar(
  
  # Tabs:
  #
  #   A/B. Summary by Directorate / Résumé par direction - convenient display
  #         of high-level trends and statistics by theme
  #
  #   1/4. Compare Data / Comparer les données - allows users to compare the
  #         2019 results for individual directorates of ROEB against previous
  #         years or ROEB overall; specify questions of interest by theme,
  #         directorate, and/or amount of change vs ROEB or a previous year;
  #         view results and trends in an easy-to-read, visual format
  #
  #   2/5. Full Results by Year / Résultats complets par année - full breakdown
  #         of all responses for each question from 2017-2019 surverys for
  #         Public service, Health Canada, ROEB, and all directorates of ROEB
  #
  #   3/6. About PSES / À propos du SAFF - information and link to PSES website
  
  sidebarMenu(
    id="tabs",
    # A:
    menuItem("Summary by Directorate", tabName="summary_en",
             icon=icon("chart-line"), selected=TRUE),
    menuItem("Compare Data", tabName="compare_en",
             icon=icon("project-diagram")),
    menuItem("Full Results by Year", tabName="full_en", icon=icon("map")),
    menuItem("About PSES", tabName="about_en",icon=icon("question")),
    # B:
    menuItem("Résumé par direction", tabName="summary_fr",
             icon=icon("chart-line")),
    menuItem("Comparer les données", tabName="compare_fr",
             icon=icon("project-diagram")),
    menuItem("Résultats complets par année", tabName="full_fr",
             icon=icon("map")),
    menuItem("À propos du SAFF", tabName="about_fr", icon=icon("question"))
  ),
  uiOutput(outputId="langselector"),
  absolutePanel(
    bottom=10, left=50, style="opacity:0.8;", fixed=TRUE, draggable = FALSE,
    actionButton(inputId="top", label=textOutput(outputId="toptxt"))
  ))

body <- dashboardBody(
  tabItems(
    
    # Tab A -----------------------------
    tabItem(
      tabName="summary_en",
      fluidPage(
        titlePanel("Summary of Changes in ROEB"),
        fluidRow(
          id="selectorpA",
          style="margin:30px 30px 10px 30px;",
          tags$table(
            tags$tr(
              tags$td(class="textlabel",strong("Organization:")),
              tags$td(
                selectInput(
                  inputId="directoratepA",label=NULL,              
                  c("Regulatory Operations and Enforcement Branch (ROEB)"="ROEB",
                    DIRECTORATES_EN),
                  selected="ROEB", width="540px"))
            ),
            tags$tr(tags$td(colspan=6,p(""))),
            tags$tr(
              tags$td(),
              tags$td(colspan=3,
                      actionButton(inputId="retrievepA",label="Retrieve data",
                                   style="border-radius:5px;")),
              tags$td(colspan=2)
            ))),
        fluidRow(
          id="displaypA",
          style="margin:30px 30px 10px 30px;",
          uiOutput(outputId="resultspA")
        )
      )),
    
    # Tab 1 -----------------------------
    tabItem(
      tabName="compare_en",
      fluidPage(
        titlePanel("Compare Data for ROEB"),
        fluidRow(
          id="selectorp1",
          style="margin:30px 30px 10px 30px;",
          tags$table(
            tags$tr(
              tags$td(class="textlabel",strong("Compare against:")),
              tags$td(selectInput(inputId="againstp1",label=NULL,
                                  c("--"="2019","2018"="2018","2017"="2017"),
                                  selected="2018",
                                  width="90px"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Directorates:")),
              tags$td(colspan=5,uiOutput(outputId="dir_outputp1"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Theme:")),
              tags$td(colspan=5,selectInput(inputId="themep1",label=NULL,
                                            themes$THEME_EN,width="600px"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Change with respect to:"),
                      width="120px"),
              tags$td(uiOutput(outputId="chng1_outputp1")),
              tags$td(class="textlabel2",strong("of at least +/-"),
                      width="95px"),
              tags$td(style="padding-left:5px; padding-bottom:5px;",
                      numericInput(inputId="change2p1",label=NULL,value=0,min=0,
                                   step=1,width="42px")),
              tags$td(class="textlabel2",strong("% in"),width="48px"),
              tags$td(uiOutput(outputId="chng3_outputp1"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Question:")),
              tags$td(colspan=5,uiOutput(outputId="ques_outputp1"))
            ),
            tags$tr(tags$td(colspan=6,p(""))),
            tags$tr(
              tags$td(),
              tags$td(colspan=3,
                      actionButton(inputId="retrievep1",label="Retrieve data",
                                   style="border-radius:5px;")),
              tags$td(colspan=2)
            ))),
        fluidRow(
          id="displayp1",
          style="margin:30px 30px 10px 30px;",
          uiOutput(outputId="resultsp1")
        )
        )),
    
    # Tab 2 -----------------------------
    tabItem(
      tabName="full_en",
      fluidPage(
        titlePanel("Full Results by Year"),
        fluidRow(
          id="selectorp2",
          style="margin:20px 30px 30px 30px;",
          div(
            style="display:inline-block;",
            selectInput(inputId="yearp2",label="Year:",
                        c("2019"="2019","2018"="2018","2017"="2017"),
                        width="80px")),
          div(
            style="display:inline-block; padding-left:5px;",
            selectInput(inputId="themep2",label="Theme:",themes$THEME_EN,
                        width="550px"))
        ),
        fluidRow(
          uiOutput(outputId="graphsp2") %>% withSpinner(color="#777777")
        ))),
    
    # Tab 3 -----------------------------
    tabItem(
      tabName="about_en",
      fluidPage(
        titlePanel("About PSES"),
        p("The Public Service Employee Survey (PSES) is a survey conducted 
          by the Treasury Board of Canada Secretariat. Its objective is to
          measure the opinions of federal public servants on their engagement,
          leadership, workforce, workplace, workplace well-being and
          compensation."),
        p("Click",
          tags$a(href="https://www.canada.ca/en/treasury-board-secretariat/services/innovation/public-service-employee-survey.html",
                 style="",
                 target="_blank",
                 "here"),
          "to learn more."
        ))),
    
    # Tab B -----------------------------
    tabItem(
      tabName="summary_fr",
      fluidPage(
        titlePanel("Résumé des variations dans la DGORAL"),
        fluidRow(
          id="selectorpB",
          style="margin:30px 30px 10px 30px;",
          tags$table(
            tags$tr(
              tags$td(class="textlabel",strong("Organization:")),
              tags$td(
                selectInput(
                  inputId="directoratepB",label=NULL,              
                  c("Direction générale des opérations réglementaires et de l’application de la loi (DGORAL)"=
                      "DGORAL",
                    DIRECTORATES_FR),
                  selected="DGORAL", width="580px"))
            ),
            tags$tr(tags$td(colspan=6,p(""))),
            tags$tr(
              tags$td(),
              tags$td(colspan=3,
                      actionButton(inputId="retrievepB",
                                   label="Rechercher les données",
                                   style="border-radius:5px;")),
              tags$td(colspan=2)
            ))),
        fluidRow(
          id="displaypB",
          style="margin:30px 30px 10px 30px;",
          uiOutput(outputId="resultspB")
        )
      )),
    
    # Tab 4 -----------------------------
    tabItem(
      tabName="compare_fr",
      fluidPage(
        titlePanel("Comparer les données pour la DGORAL"),
        fluidRow(
          id="selectorp4",
          style="margin:30px 30px 10px 30px;",
          tags$table(
            tags$tr(
              tags$td(class="textlabel",strong("Comparer contre:")),
              tags$td(selectInput(inputId="againstp4",label=NULL,
                                  c("--"="2019","2018"="2018","2017"="2017"),
                                  selected="2018",width="90px"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Directions:")),
              tags$td(colspan=5,uiOutput(outputId="dir_outputp4"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Thème:")),
              tags$td(colspan=5,selectInput(inputId="themep4",label=NULL,
                                            themes$THEME_FR,width="629px"))
            ),
            tags$tr(
              tags$td(class="textlabel",
                      strong("Changement par rapport à (la):"),width="120px"),
              tags$td(uiOutput(outputId="chng1_outputp4")),
              tags$td(class="textlabel2",strong("d'au moins +/-"),
                      width="102px"),
              tags$td(style="padding-left:5px; padding-bottom:5px;",
                      numericInput(inputId="change2p4",label=NULL,value=0,min=0,
                                   width="50px")),
              tags$td(class="textlabel2",strong("% dans"),width="62px"),
              tags$td(uiOutput(outputId="chng3_outputp4"))
            ),
            tags$tr(
              tags$td(class="textlabel",strong("Question:")),
              tags$td(colspan=5,uiOutput(outputId="ques_outputp4"))
            ),
            tags$tr(tags$td(colspan=6,p(""))),
            tags$tr(
              tags$td(),
              tags$td(colspan=3,
                      actionButton(inputId="retrievep4",
                                   label="Rechercher les données",
                                   style="border-radius:5px;")),
              tags$td(colspan=2)
            ))),
        fluidRow(
          id="displayp4",
          style="margin:30px 30px 10px 30px;",
          uiOutput(outputId="resultsp4")
        ))),
    
    # Tab 5 -----------------------------
    tabItem(
      tabName="full_fr",
      fluidPage(
        titlePanel("Résultats complets par année"),
        fluidRow(
          id="selectorp5",
          style="margin:20px 30px 30px 30px;",
          div(
            style="display:inline-block;",
            selectInput(inputId="yearp5",label="Année:",
                        c("2019"="2019","2018"="2018","2017"="2017"),
                        width="80px")),
          div(
            style="display:inline-block; padding-left:5px;",
            selectInput(inputId="themep5",label="Thème:",themes$THEME_FR,
                        width="550px"))
        ),
        fluidRow(
          uiOutput(outputId="graphsp5") %>% withSpinner(color="#777777")
        ))),
    
    # Tab 6 -----------------------------
    tabItem(
      tabName="about_fr",
      fluidPage(
        titlePanel("À propos du SAFF"),
        p("Le Sondage auprès des fonctionnaires fédéraux (SAFF) est un sondage
          mené par le Secrétariat du Conseil du Trésor du Canada. Son objectif
          est de mesurer les opinions des fonctionnaires fédéraux concernant
          leur mobilisation, le leadership, l’effectif, le milieu de travail,
          le bien-être en milieu de travail et la rémunération."),
        p("Cliquez",
          tags$a(href="https://www.canada.ca/fr/secretariat-conseil-tresor/services/innovation/sondage-fonctionnaires-federaux.html",
                  style="",
                  target="_blank",
                  "ici"),
          "pour en apprendre plus."
        )))))

## ~~~~ Main UI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ui <- tagList(
  useShinyjs(),
  extendShinyjs("www/scripts.js"),
  tags$link(rel="stylesheet",type="text/css",href="style.css"),
  
  # Main display ----------------------
  div(id="mainscrn", style="display:none;",
      dashboardPage(
        title="PSES Results/Résultats du SAFF", header,sidebar,body
      )),
  
  # Loading screen --------------------
  div(
    id="loadingscrn",
    fluidPage(
      br(style="line-height:100px;"),
      h1("PSES Results / Résultats du SAFF"),
      img(id="spinner", src="spinner.gif"),
      div(id="continuebtns", style="height:151px; display:none;",
          actionButton(inputId="selecteng", label="Continue in English"),
          actionButton(inputId="selectfr", label="Continuer en français")
      ),
      h4("Welcome! / Bienvenue!")
    )))
