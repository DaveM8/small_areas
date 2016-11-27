require(dplyr)
require(reshape2)
require(ggplot2)
require(lubridate)

source("read_api.R")

## T6_3_RLAH	Rented from Local Authority (Households)
## T6_3_RVBH	Rented from Voluntary Body (Households)
## T6_3_OFRH	Rented Free of Rent (Households)
## T6_3_TH	Total (Households)

sma <- read.csv("AllThemesTablesSA.csv")
house_type <- sma %>% select(1:3,T6_3_RPLH, T6_3_RLAH, T6_3_RVBH, T6_3_OFRH,T6_3_TH)
field_names <- c("Households Rented from Private Landlord", "Households Rented from Local Authority", "Households Rented from Voluntary Body", "Households Rented Free of Rent", "Total Households")
## total rented
names(house_type)[4:8] <- tolower(gsub(" ", "_",field_names ))
house_type$total_rented <- apply(house_type[,4:7], 1, sum)
house_type <- house_type %>%
    mutate(per_rented = total_rented/total_households)
## break it down by private and local authority
house_type <- house_type %>%
    mutate(private_rented = households_rented_from_private_landlord/total_households)

house_type <- house_type %>%
    mutate(local_auth_rented = households_rented_from_local_authority/total_households)

house_type <- house_type %>%
    mutate(vol_body_rented = households_rented_from_voluntary_body/total_households)
## write file to disk will load into postGIS to link GEOGID to
## geographical location 
write.table(house_type, file="rented_types_with_percent.csv", sep="\t", row.names=FALSE)


