# Data wrangling with dplyr
library(tidyverse)

interviews <- read_csv("data-raw/SAFI_clean.csv",
                       na = "NULL",
                       col_types=cols(
                         key_ID=col_integer(),
                         no_membrs = col_integer(),
                         years_liv = col_integer(),
                       ))
read_csv("data-raw/SAFI_clean.csv", na = "NULL") 
         
glimpse (interviews)

# Subset data -------------------------------------------------------------
interviews |> #Cmd/Ctrl + Shift + M %>% 
  select(village, no_membrs,years_liv) # Subsetting columns

#Alternatively
select(.data = interviews, village, no_membrs, years_liv)

interviews |> 
  select(village:liv_count)

interviews |>
  select(village, no_membrs:rooms)|>
  filter(rooms > 1 & rooms < 5, village == "Chirodzo") |>
  select(!village)|>
  mutate(people_per_room = no_membrs / rooms)

interviews |>
  select (village, no_membrs:rooms)|>
  filter(rooms > 1,
         village == "God") |>
  mutate(people_per_room = no_membrs/rooms)

chirodzo <- interviews_chirodzo |>
  mutate(people_per_room = no_membrs/rooms) |>
  summarise(avg_per_room= mean(people_per_room))


interviews |>
  group_by(village, respondent_wall_type) |>
  summarise(avg_per_room = mean(no_membrs/rooms),
            count= n(),
            .groups="drop") |>
  arrange(desc(avg_per_room))
  
items_owned <- interviews |>
  separate_longer_delim(items_owned, delim = ";") |>
  group_by(key_ID)|>
  summarise(total_items=n()) |>
  left_join(interviews, by = "key_ID")

left_join(items_owned, interviews, by = "key_ID")


