require(dplyr)
require(reshape2)
require(ggplot2)
require(lubridate)

source("read_api.R")

## T6_3_RLAH	Rented from Local Authority (Households)
## T6_3_RVBH	Rented from Voluntary Body (Households)
## T6_3_OFRH	Rented Free of Rent (Households)
## T6_3_NSH	Not Stated (Households)
## T6_3_TH	Total (Households)

sma <- read.csv("../small_areas/AllThemesTablesSA.csv")
house_type <- sma %>% select(1:3,T6_3_RPLH)
names(house_type)[4] <- tolower(gsub(" ", "_", "Households Rented from Private Landlord"))
