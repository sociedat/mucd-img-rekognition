library(purrr)
library(tidyverse)
library(jsonlite)
library(stringr)

files <- list.files(path='imgs/MARINA IMAGENES FB/', pattern='*.json', full.names=TRUE, recursive=FALSE)
data <- data.frame()
for (file in files) {
  data <- data %>% 
    bind_rows(fromJSON(file, flatten=T)[[1]] %>% 
                select(c(1,2)) %>% 
                mutate(Source = str_split(str_split(file,'/')[[1]][3],'.json')[[1]][1]))
}

summarised_data <- data %>% group_by(Name) %>% summarise(mean(Confidence))


write_csv(data, 'fb_scores.csv')

write_csv(summarised_data, 'fb_summary.csv')