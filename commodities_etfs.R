# comparing major commodities ETFs: gold (GLD), oil(USO), silver(SLV), natural gas(UNG) 
# decided to look at 2020 onwards for post-covid performance 
library(quantmod)
library(PerformanceAnalytics)
library(xts)
library(zoo)
library(ggplot2)

start_date <- as.Date("2020-01-01")

tickers <- c("GLD", "USO", "SLV", "UNG")

getSymbols(tickers, from = start_date)

prices <- merge(Ad(GLD), Ad(USO), Ad(SLV), Ad(UNG))
colnames(prices) <- c("Gold", "Oil", "Silver", "NatGas")
head(prices)
tail(prices)

cols <- c("black", "red","green", "blue")
plot.zoo(prices, plot.type = "single",col = cols, main = "Adjusted Prices")
legend("topleft", legend = colnames(prices), col = cols, lty = 1)

plot(prices, type = "l")

#charts performance is for returns not prices- simple returns not for log as it will be misleading
charts.PerformanceSummary(Return.calculate(Ad(GLD)))
charts.PerformanceSummary(Return.calculate(Ad(USO)))
charts.PerformanceSummary(Return.calculate(Ad(SLV)))
charts.PerformanceSummary(Return.calculate(Ad(UNG)))
#comparison
simple_returns <- (Return.calculate(prices))
charts.PerformanceSummary(simple_returns, main = "Simple Returns: All Commodities")

#log returns 
plot(dailyReturn(Ad(GLD), type = 'log'), type = 'l', main = 'GLD log returns')
plot(dailyReturn(Ad(USO), type = 'log'), type = 'l', main = 'USO log returns')
plot(dailyReturn(Ad(SLV), type = 'log'), type = 'l', main = 'SLV log returns')
plot(dailyReturn(Ad(UNG), type = 'log'), type = 'l', main = 'UNG log returns')

#cumulative log returns
plot(exp(cumsum(dailyReturn(Ad(GLD), type = 'log'))), main = "GLD cumulative log returns")
plot(exp(cumsum(dailyReturn(Ad(USO), type = 'log'))), main = "USO cumulative log returns")
plot(exp(cumsum(dailyReturn(Ad(SLV), type = 'log'))), main = "SLV cumulative log returns")
plot(exp(cumsum(dailyReturn(Ad(UNG), type = 'log'))), main = "UNG cumulative log returns")

#Return type	Correct cumulative
#Simple (arithmetic)	cumprod(1 + simple_return)
#Log	exp(cumsum(log_return))

#difference between log returns and simple returns 
plot(cumprod(1 + dailyReturn(Ad(GLD), type = "arithmetic")) - exp(cumsum(dailyReturn(Ad(GLD), type = "log"))),main = "GLD - Difference (Simple vs Log)")
plot(cumprod(1 + dailyReturn(Ad(USO), type = "arithmetic")) - exp(cumsum(dailyReturn(Ad(USO), type = "log"))),main = "USO - Difference (Simple vs Log)")
plot(cumprod(1 + dailyReturn(Ad(SLV), type = "arithmetic")) - exp(cumsum(dailyReturn(Ad(SLV), type = "log"))),main = "SLV - Difference (Simple vs Log)")
plot(cumprod(1 + dailyReturn(Ad(UNG), type = "arithmetic")) - exp(cumsum(dailyReturn(Ad(UNG), type = "log"))),main = "UNG - Difference (Simple vs Log)")

# AnnualizedReturns uses simple returns, not raw prices.
# Drawdowns are calculated on simple returns.

# sharpe ratio
table.AnnualizedReturns(simple_returns, scale =252, Rf= 0.0465/252)
table.Drawdowns(simple_returns)
SharpeRatio.annualized(simple_returns, Rf = 0)

#rolling volatility 
rolling_vols <- rollapply(simple_returns, width = 20, FUN = function(x) apply(x, 2, sd), fill = NA) * sqrt(252)
plot.zoo(rolling_vols, plot.type = "single",  col = cols, main = "20-Day Rolling Volatility (Annualised)")
legend("topright", legend = colnames(rolling_vols), col = 1:ncol(rolling_vols), lty = 1)

#rolling correlation- measures how two cassets move together - how their relationship changes over time 
#gold vs oil
returns <- na.omit(Return.calculate(prices))
data <- as.data.frame(returns[, c("Gold", "Oil")])
rolling_corr <- rollapply(data, width = 20 ,FUN = function(x) cor(x[, 1], x[, 2]), by.column = FALSE ,fill = NA)
rolling_corr <- xts(rolling_corr, order.by = index(returns))
plot(rolling_corr, type = "l", main = "20-Day Rolling Correlation: Gold vs Oil", ylab = "Correlation", col = "blue")

#gold vs silver
data2 <- as.data.frame(returns[, c("Gold", "Silver")])
rolling_corr <- rollapply(data2, width = 20 ,FUN = function(x) cor(x[, 1], x[, 2]), by.column = FALSE ,fill = NA)
rolling_corr <- xts(rolling_corr, order.by = index(returns))
plot(rolling_corr, type = "l", main = "20-Day Rolling Correlation: Gold vs Silver", ylab = "Correlation", col = "purple")

#oil vs gas
data3 <- as.data.frame(returns[, c("Oil", "NatGas")])
rolling_corr <- rollapply(data3, width = 20 ,FUN = function(x) cor(x[, 1], x[, 2]), by.column = FALSE ,fill = NA)
rolling_corr <- xts(rolling_corr, order.by = index(returns))
plot(rolling_corr, type = "l", main = "20-Day Rolling Correlation: Oil vs NatGas", ylab = "Correlation", col = "orange")
