# Bakery Consumer Insights 🍞☕ 
<img src="images/clay-banks-oNm9NkTFLfA-unsplash.jpg" align="right" width="275" style="margin-left: 15px;"/>

The purpose of this project is to analyze bakery transaction data to better understand customer purchasing behavior and identify opportunities for business growth. Specifically, the project explores what products customers buy, when purchases occur, how purchasing patterns differ across time, and which products are frequently bought together. The goal is to transform transaction data into actionable insights that can support sales growth, operational efficiency, and customer experience improvements.

## Overview

The goal of this project is to analyze bakery sales data to answer key business questions:

- What products are customers buying?
- When are purchases occurring?
- How do purchasing patterns differ across time?
- Which products are frequently bought together?

By answering these questions, the project provides insights into demand patterns and opportunities for improving sales strategies.

## Dataset
The dataset used in this project was obtained from Kaggle and contains bakery transaction records used to analyze customer purchasing behavior, product demand, and item associations.

Source: [Bakery Dataset – Kaggle](https://www.kaggle.com/datasets/akashdeepkuila/bakery) The dataset used in this project was obtained from Kaggle and contains bakery transaction records used to analyze customer purchasing behavior, product demand, and item associations.

### Variables
- `weekday_weekend`: Whether the purchase was made on a weekday or weekend
- `period_day`: The time of day when the transaction happened (ex: morning, afternoon, evening, and night)
- `transaction`: Unique purchaes/basket ID
- `item`: The actual product purchased
- `date_time`: Calendar date of purchase

## Data Mining Operations

This project was conducted in R using exploratory data analysis (EDA), visualization techniques, and association rule mining.

### Data Wrangling
- Cleaned and prepared transaction-level bakery data
- Reviewed duplicate transactions and missing values
- Converted `date_time` into usable time variables
- Created additional variables such as:
  - hour
  - month
  - day of week
  - weekday vs weekend

### Modeling & Analysis
- Product demand analysis
- Time-based purchasing behavior analysis
- Weekday vs weekend comparisons
- Apriori Association Rule Mining using `arules`

### Why Apriori?
The Apriori algorithm was selected because it is highly effective for market basket analysis and identifying products that are frequently purchased together within transaction-based datasets.

### Libraries Used
- tidyverse (`dplyr`, `ggplot2`)
- lubridate
- arules
- arulesViz

## Limitations

This project focuses on transaction-level purchase behavior and does not include financial variables such as product pricing, revenue, or profit margins. As a result, the analysis identifies high-demand products but cannot determine profitability or overall revenue contribution.

Additionally, the dataset does not include customer demographic information, limiting deeper segmentation analysis. Some months were also missing from the dataset, preventing full-year seasonal analysis.

## Model Outputs & Insights

- **Coffee is the most purchased item**, acting as a central driver of sales  
- Demand is **highly concentrated** around a few core products (e.g., coffee, bread)  
- Customer purchasing behavior varies across **time of day and day type**  
- Strong product associations exist, especially between:
  - Coffee and toast  
  - Coffee and pastries  
  - Coffee and breakfast items  

### Top Purchased Bakery Products
<img src="images/Top 5 Product Purchased.png" width="700"/>

Coffee and bread dominate overall purchase frequency, suggesting customer demand is highly concentrated around a small group of core products. These items likely act as anchor products that drive repeat customer traffic and create opportunities for cross-selling complementary items.

### Top Products Purchased by Day of Week
<img src="images/Top 10 Most Purchased.png" width="700"/>
Customer purchasing behavior remains relatively consistent throughout the week, with coffee and bread frequently among the top-selling products across nearly all days. However, purchase volume tends to increase toward the weekend, suggesting stronger leisure-driven demand and opportunities for weekend-focused promotions.

### Product Association Analysis

<img src="images/Top Product Association.png" width="700"/>

Association rule mining revealed strong relationships between coffee and several bakery items, particularly toast, pastries, and breakfast products. These findings suggest opportunities for bundled promotions, optimized store layouts, and cross-selling strategies to increase transaction value.

Customer purchasing behavior remains relatively consistent throughout the week, with coffee and bread frequently among the top-selling products on nearly all days. However, purchase volume tends to increase toward the weekend, suggesting stronger leisure-driven demand and opportunities for weekend-focused promotions.

## Recommendations
Based on the analysis, several strategic recommendations can be made to improve bakery performance. First, staffing and promotional efforts should be aligned with peak demand periods. Promotional efforts should align with peak demand, such as a bundle deal on coffee and pastry at a slightly lower cost. Particularly on Friday through Sunday and during the morning and afternoon hours, there should be more employees on duty than usual to ensure efficient service and maximize sales opportunities. 

Additionally, the bakery should introduce complementary product bundles, such as grab-and-go options and leisure-focused promotions, to increase basket size and enhance the customer experience. From this analysis, it could be inferred that more people can come on Friday - Sunday because of the leisure time they have. Bundles can be made to suit their needs, such as more relaxed, comforting meals. For Monday - Thursday, foods that are easy to warm up or pack would be essential for people who are in a rush for something quick. Optimizing store layout through clear signage and strategic product placement—especially pairing high-demand items like coffee with pastries—can further encourage additional purchases. Understanding what consumers often compare their coffee to is important, as it is an anchor item for the bakery. 

From a product strategy perspective, maintaining stock availability of top-performing items is essential, while low-performing products should be reevaluated or rotated to improve overall portfolio efficiency. Especially when the product portfolio has 94 items, which can lead to inventory and financial waste, as many bakery items have low liquidity. Expanding successful product categories can also drive growth, such as bread. There are multiple variations of bread, and they can be easily adjusted to trends while not steering away from the core products that are frequently purchased and consumers are seeking to buy on a daily basis.

Lastly, future data collection efforts should focus on gathering customer ratings, reviews, and survey feedback, and on incorporating pricing and profit data. This would allow for deeper insights into customer preferences and more informed decision-making, including the ability to segment customers and develop more targeted marketing strategies.


## Files

- `Bakery_Consumer_Analysis.Rmd` → Full analysis with explanations  
- `Bakery_Consumer_Analysis.html` → Final knitted report  
- `Bakery_Consumer_Analysis.R` → Clean R script  
- `bakery_sales_revised.csv` → Dataset  


## References
Akashdeepkuila. Bakery Dataset. Kaggle.
https://www.kaggle.com/datasets/akashdeepkuila/bakery 

Heeral Dedhia. *Market Basket Analysis Using Apriori Algorithm*. Kaggle. 
https://www.kaggle.com/code/heeraldedhia/market-basket-analysis-using-apriori-algorithm

talitacgs. *Market Basket Analysis with Apriori*. GitHub. 
https://github.com/talitacgs/Market_basket_analysis_with_Apriori

MNoorFawi. *Association Rules with R*. GitHub. 
https://github.com/MNoorFawi/association-rules-with-R

OpenAI. *ChatGPT*. Supplemental support used for R coding assistance.  
https://chat.openai.com/

Wickham, H., & Grolemund, G. *R for Data Science: Dates and Times*. 
https://r4ds.had.co.nz/dates-and-times.html

Wickham, H., Çetinkaya-Rundel, M., & Grolemund, G. *R for Data Science: Data Visualization*. 
https://r4ds.hadley.nz/data-visualize.html
