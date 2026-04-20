# Bakery Consumer Insights 🍞☕

This project applies data-driven analysis to bakery transaction data to understand customer purchasing behavior, evaluate product performance, and uncover meaningful product relationships.

Using R, the analysis combines exploratory data analysis (EDA) and association rule modeling to generate actionable insights that can support business decision-making.


## Overview

The goal of this project is to analyze bakery sales data to answer key business questions:

- What products are customers buying?
- When are purchases occurring?
- How do purchasing patterns differ across time?
- Which products are frequently bought together?

By answering these questions, the project provides insights into demand patterns and opportunities for improving sales strategies.


## Methods

This project was conducted in **R** using the following techniques:

### Data Analysis
- Data cleaning and preparation
- Product demand analysis
- Time-based purchasing analysis (daypart, weekday vs weekend)

### Visualization
- Bar charts using `ggplot2`
- Faceted comparisons across time periods

### Modeling
- **Apriori Association Rule Mining** (`arules`)
- Identification of frequently purchased item combinations
- Evaluation using support, confidence, and lift


## Key Insights

- **Coffee is the most purchased item**, acting as a central driver of sales  
- Demand is **highly concentrated** around a few core products (e.g., coffee, bread)  
- Customer purchasing behavior varies across **time of day and day type**  
- Strong product associations exist, especially between:
  - Coffee and toast  
  - Coffee and pastries  
  - Coffee and breakfast items  


## Recommendations

Based on the analysis:

- **Bundle complementary products**  
  (e.g., coffee + toast or pastry) to increase transaction value  

- **Optimize store layout**  
  Place coffee near high-demand items to encourage cross-selling  

- **Focus on peak-time promotions**  
  Target breakfast and high-traffic periods  

- **Reevaluate low-performing items**  
  Consider repositioning or promoting underperforming products  


## Files

- `Bakery_Consumer_Analysis.Rmd` → Full analysis with explanations  
- `Bakery_Consumer_Analysis.html` → Final knitted report  
- `Bakery_Consumer_Analysis.R` → Clean R script  
- `bakery_sales_revised.csv` → Dataset  


## Tools & Libraries

- R  
- tidyverse (dplyr, ggplot2)  
- arules  
- arulesViz  


## Notes

This project focuses on transaction-level data and does not include pricing or customer demographic information, which may limit deeper segmentation and profitability analysis.


## Author

Monyratana (Ratana) Tang
