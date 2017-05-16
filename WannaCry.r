library(rgeolocate)
library(wordcloud)
library(RColorBrewer)
library(plotrix)
file <- system.file("extdata","GeoLite2-Country.mmdb", package = "rgeolocate")
ips <- c('188.166.23.127','91.219.236.222','46.101.166.19','193.23.244.244','62.210.124.124','2.3.69.209',
         '144.76.92.176','91.121.65.179','146.0.32.144','148.244.38.101','91.219.237.229','50.7.161.218',
         '149.202.160.69','217.79.179.177','87.7.10.93','163.172.149.155','212.47.232.237','192.42.115.101',
         '171.25.193.9','81.30.158.223','178.62.197.82','195.22.26.248','79.172.193.32','212.47.244.98',
         '197.231.221.221','38.229.72.16','5.35.251.247','198.96.155.3','46.101.166.19','128.31.0.39',
         '213.61.66.117','23.254.167.231')
results <- maxmind(ips, file, c("continent_name", "country_code", "country_name"))
results
wordcloud(results$country_name, max.words = 100, min.freq = 1, random.order = TRUE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
ct <- count(results$country_name)
plotH(freq~x,data=ct,ylab="Frequency",xlab="Country",col="blue")