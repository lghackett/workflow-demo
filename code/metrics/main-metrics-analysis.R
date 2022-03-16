## Set up ----------------------------------------------------------------

setwd("/users/hackettl/drive_berkeley/resources/demo-workflow")

library(pacman)
p_load(fixest, tidyverse, ggplot2, plm, fastDummies, modelsummary)

options(box.path = '/users/hackettl/documents/github/r-modules/')
box::use(outputHelpers/msout, regHelpers/reghelp, plotHelpers/plothelp)

## Load data -------------------------------------------------------------

dt <- read_csv('data/out/diabetes_clean.csv')

## Estimate --------------------------------------------------------------

m1 <- feols(formula("diabetes ~ age"), data = dt)
m2 <- feols(formula("diabetes ~ age + sex"), data = dt)
m3 <- feols(formula("diabetes ~ age + sex + bmi"), data = dt)


##Table set-up   ----------------------------------------------------------
outdir <- 'tex/tabs/'
models <- list(m1, m2, m3) %>% setNames(c("Simple", "Expanded", "Pro"))

options(modelsummary_format_numeric_latex = "mathmode")
gm <- tibble::tribble(
  ~raw,        ~clean,          ~fmt,
  "nobs",      "N",             0,
  "adj.r.squared", "Adj. $R^2$", 2)

# Write a function to strip float
# later I'll add this to the R modules
strip_table <- function(table){
  # replace the \begin{table}, \end{table} stuff with ''
  tabout <- gsub('[\\\\]+begin[{]table[}]\\[H\\]\n[\\\\]+centering|[\\\\]+end[{]table[}]',
                 '', table, perl=TRUE)
  match <- stringr::str_extract(string = tab, pattern = '[\\\\]+toprule((?s).*)[\\\\]+bottomrule') 
  return(tabout)
}

## Make and export the table -------------------------------------------------
tab <- modelsummary(models, 
                    stars = c('*' = .1, '**' = .05, '***' = 0.01), 
                    output = "latex", 
                    coef_omit = "(Intercept)",
                    coef_rename = c("age" = "Age", 
                                    "sex" = "Sex", 
                                    "bmi" = "BMI"),
                    gof_map = gm)

strip_table(tab) %>% kableExtra::save_kable(paste0(outdir, 'regs.tex'))
