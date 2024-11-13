library(data.table)
library(dplyr)
library(sf)
pop<-fread("source/fbs2010/FAOSTAT_data_en_11-13-2024_POP.csv")
pop <- pop %>% select(i=`Area Code (ISO3)`,
                      t = Year,
                      POPit=Value) 
popt<-dcast(pop, formula=i~t)

map<-st_read("geom/world-administrative-boundaries.geojson")
mapdon<-merge(map, popt, by.x="iso3", by.y="i", all.x=T, all.y=F)
mapdon$test<-is.na(mapdon$`2022`)
table(mapdon$test)
plot(mapdon['test'])
mapctr<-st_centroid(mapdon)
plot(mapctr['test'],pch=20, pal=c("red","lightblue"), border="white")

     