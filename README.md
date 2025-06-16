# Commodities_ETFS

The aim of this project was to analyse and compare the risk and return characteristics of four major commodities ETFs — Gold (GLD), Oil (USO), Silver (SLV), and Natural Gas (UNG) — from 2020 onward, to understand post-COVID market behaviour.

## Process
Retrieved daily adjusted price data using the quantmod package.

Calculated daily simple and log returns.

Visualised daily and cumulative returns to show price trends and growth.

Computed 20-day rolling annualised volatility to track changes in risk over time.

Analysed 20-day rolling correlation for key pairs:
-Gold and Oil
-Gold and Silver
-Oil and Natural Gas

Summarised annualised performance, Sharpe ratios, and drawdowns to understand return consistency and risk exposure.

## Key Insights
- Gold delivered the strongest risk-adjusted performance with an annualised return of about 15.6% and the highest Sharpe ratio (0.65 when accounting for a 4.65% risk-free rate, or 0.98 with zero risk-free rate). It was also the least volatile, with annualised standard deviation around 16%.
- Silver showed a solid annualised return of 13.2%, but with higher volatility (31%) and a more moderate Sharpe ratio (0.26 to 0.42 depending on risk-free rate). This reflects its tendency to track gold but with greater swings.
- Oil had a slightly negative annualised return (-4.4%) with high volatility (43%) and a negative Sharpe ratio, highlighting the impact of large price swings and supply-demand shocks in energy markets.
- Natural Gas had the weakest performance, with a significant negative annualised return (-22.6%) and the highest volatility (62%). Its Sharpe ratio was strongly negative, indicating poor risk-adjusted performance over this period.
- Rolling volatility plots show that Natural Gas and Oil had the largest fluctuations, with spikes during periods of geopolitical and supply chain disruption.
- Rolling correlation charts reveal that Gold and Silver maintained a consistently strong positive relationship, confirming their role as linked precious metals. Oil and Natural Gas also showed phases of high correlation, reflecting their shared exposure to energy market factors, though correlation weakened at times due to separate market drivers.
- Cumulative return plots clearly illustrate that Gold and Silver preserved and grew value through the post-COVID period, whereas Oil and Natural Gas returns were far more volatile and less rewarding overall.
- The drawdown table shows that the largest peak-to-trough decline across the commodities was about 22%, lasting over 898 trading days, highlighting the risk of prolonged losses in commodities investing.

## Files
 [commodities_etfs.R](commodities_etfs.R):: — full script for data download, return calculations, rolling statistics, and plots.

## Reflections
This project strengthened my understanding of practical risk and return analysis for commodities. It reinforced how rolling metrics and correlation help investors evaluate diversification and market trends over time.

