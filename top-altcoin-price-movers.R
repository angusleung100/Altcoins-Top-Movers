# Packages
library(httr)


currencyTarget <- "cad" # Currency to pair altcoin against

page <- 1 # Page to get data for

url <- paste(cbind("https://api.coingecko.com/api/v3/coins/markets?vs_currency=",currencyTarget,"&order=market_cap_desc&per_page=100&page=",page,"&sparkline=false"), collapse="")

# Retrieve top coins by market cap on CoinGecko

getCoins <- GET(url)
  
data <- content(getCoins, "parsed")

topCoinsID <- data[[1]]['id'][[1]]
topCoinsDeltaChange <- data[[1]]['price_change_percentage_24h'][[1]]
topCoinsVolume <- data[[1]]['total_volume'][[1]]

for(i in 2:length(data))  {

  topCoinsID <- c(topCoinsID, data[[i]]['id'][[1]])
  topCoinsDeltaChange <- c(topCoinsDeltaChange, data[[i]]['price_change_percentage_24h'][[1]])
  topCoinsVolume <- c(topCoinsVolume, data[[i]]['total_volume'][[1]])
}

# Create Data Frame For Data

topCoins <- data.frame("coinID"=topCoinsID, "deltaChange24"=topCoinsDeltaChange, "volume24"=topCoinsVolume)



# Display Top 10 price gainers

topGainers <- topCoins[order(-topCoins["deltaChange24"]),]

print("Displaying Top 10 Price Gainers")

topGainersID <- topGainers[1,"coinID"]
topGainersDeltaChange <- topGainers[1,"deltaChange24"]
topGainersVolume <- topGainers[1,"volume24"]

for(i in 2:10)  {
  topGainersID <- c(topGainersID, topGainers[i,"coinID"])
  topGainersDeltaChange <- c(topGainersDeltaChange, topGainers[i,"deltaChange24"])
  topGainersVolume <- c(topGainersVolume, topGainers[i,"volume24"])
}

topGainersDF <- data.frame("coinID"=topGainersID, "deltaChange24"=topGainersDeltaChange, "volume24"=topGainersVolume)

View(topGainersDF)

# Display Top 10 price losers

topLosers <- topCoins[order(topCoins["deltaChange24"]),]

print("Displaying Top 10 Price Losers")

topLoserssID <- topLosers[1,"coinID"]
topLosersDeltaChange <- topLosers[1,"deltaChange24"]
topLosersVolume <- topLosers[1,"volume24"]

for(i in 2:10)  {
  topLoserssID <- c(topLoserssID, topLosers[i,"coinID"])
  topLosersDeltaChange <- c(topLosersDeltaChange, topLosers[i,"deltaChange24"])
  topLosersVolume <- c(topLosersVolume, topLosers[i,"volume24"])
}

topLosersDF <- data.frame("coinID"=topLoserssID, "deltaChange24"=topLosersDeltaChange, "volume24"=topLosersVolume)

View(topLosersDF)



