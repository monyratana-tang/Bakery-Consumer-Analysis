# Bakery Consumer Analysis
# Author: Monyratana Tang

# ----------------------------
# 1. Load Libraries
# ----------------------------

library(tidyverse)
library(lubridate)
library(arules)
library(arulesViz)

# ----------------------------
# 2. Load Dataset
# ----------------------------

Bakery <- read.csv("bakery_sales_revised.csv", stringsAsFactors = FALSE)

# ----------------------------
# 3. Data Preparation
# ----------------------------

Bakery$date_time_parsed <- mdy_hm(Bakery$date_time)

Bakery$day_name <- weekdays(Bakery$date_time_parsed)

Bakery$day_name <- factor(
  Bakery$day_name,
  levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
)

Bakery$month_num <- month(Bakery$date_time_parsed)

Bakery$month_name <- factor(
  Bakery$month_num,
  levels = 1:12,
  labels = c(
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  )
)

# ----------------------------
# 4. Product Demand Analysis
# ----------------------------

item_counts <- Bakery %>%
  dplyr::count(Item, sort = TRUE)

length(unique(Bakery$Item))
head(item_counts, 10)
tail(item_counts, 10)

ggplot(item_counts[1:15, ], aes(x = reorder(Item, n), y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  coord_flip() +
  labs(
    title = "Top 15 Most Purchased Bakery Items",
    x = "Bakery Item",
    y = "Purchase Frequency"
  ) +
  theme_minimal()

ggplot(item_counts[74:94, ], aes(x = reorder(Item, n), y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  coord_flip() +
  labs(
    title = "Bottom 20 Most Purchased Bakery Items",
    x = "Bakery Item",
    y = "Purchase Frequency"
  ) +
  theme_minimal()

# ----------------------------
# 5. Time-Based Analysis
# ----------------------------

daypart_counts <- Bakery %>%
  dplyr::count(period_day, sort = TRUE)

ggplot(daypart_counts, aes(x = reorder(period_day, n), y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  labs(
    title = "Bakery Purchases by Time of Day",
    x = "Time of Day",
    y = "Purchase Frequency"
  ) +
  theme_minimal()

top_items_time <- Bakery %>%
  dplyr::count(period_day, Item, sort = TRUE) %>%
  group_by(period_day) %>%
  slice_max(order_by = n, n = 5) %>%
  ungroup()

ggplot(top_items_time, aes(x = reorder(Item, n), y = n, fill = period_day)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  facet_wrap(~period_day, scales = "free") +
  scale_fill_manual(values = c(
    "morning" = "#5C1328",
    "afternoon" = "#8B1E3F",
    "evening" = "#C94C6D",
    "night" = "#E07A8D"
  )) +
  labs(
    title = "Top Products Purchased by Time of Day",
    x = "Product",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------
# 6. Weekday vs Weekend Analysis
# ----------------------------

behavior_counts <- Bakery %>%
  dplyr::count(weekday_weekend, sort = TRUE)

ggplot(behavior_counts, aes(x = weekday_weekend, y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  labs(
    title = "Bakery Purchases: Weekday vs Weekend",
    x = "Day Type",
    y = "Purchase Frequency"
  ) +
  theme_minimal()

top_items_daytype <- Bakery %>%
  dplyr::count(weekday_weekend, Item, sort = TRUE) %>%
  group_by(weekday_weekend) %>%
  slice_max(order_by = n, n = 10) %>%
  ungroup()

ggplot(top_items_daytype, aes(x = reorder(Item, n), y = n, fill = weekday_weekend)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  facet_wrap(~weekday_weekend, scales = "free") +
  scale_fill_manual(values = c(
    "weekday" = "#8B1E3F",
    "weekend" = "#C94C6D"
  )) +
  labs(
    title = "Top 10 Purchases on Weekdays and Weekends",
    x = "Product",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------
# 7. Day of Week Analysis
# ----------------------------

top_items_day <- Bakery %>%
  dplyr::count(day_name, Item, sort = TRUE) %>%
  group_by(day_name) %>%
  slice_max(order_by = n, n = 5) %>%
  ungroup()

ggplot(top_items_day, aes(x = reorder(Item, n), y = n, fill = day_name)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  facet_wrap(~day_name, scales = "free") +
  scale_fill_manual(values = c(
    "Monday" = "#5C1328",
    "Tuesday" = "#8B1E3F",
    "Wednesday" = "#A61E4D",
    "Thursday" = "#C94C6D",
    "Friday" = "#E07A8D",
    "Saturday" = "#B03060",
    "Sunday" = "#7A1B3A"
  )) +
  labs(
    title = "Top 5 Products Purchased by Day of Week",
    x = "Product",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------
# 8. Monthly Purchase Analysis
# ----------------------------

month_counts <- Bakery %>%
  filter(!is.na(month_name)) %>%
  dplyr::count(month_name)

ggplot(month_counts, aes(x = month_name, y = n, group = 1)) +
  geom_line(color = "#8B1E3F", linewidth = 1.2) +
  geom_point(size = 3, color = "#C94C6D") +
  labs(
    title = "Bakery Purchases by Month",
    x = "Month",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold", size = 16)
  )

# ----------------------------
# 9. Apriori Association Rule Mining
# ----------------------------

transactions_list <- split(Bakery$Item, Bakery$Transaction)
transactions <- as(transactions_list, "transactions")

rules <- apriori(
  transactions,
  parameter = list(
    supp = 0.01,
    conf = 0.3,
    target = "rules"
  )
)

inspect(sort(rules, by = "lift")[1:10])

top_rules_df <- as(sort(rules, by = "lift"), "data.frame")[1:5, ]

ggplot(top_rules_df, aes(x = reorder(rules, lift), y = lift)) +
  geom_bar(stat = "identity", fill = "maroon") +
  coord_flip() +
  geom_text(aes(label = round(lift, 2)), hjust = -0.2) +
  labs(
    title = "Top Product Associations by Lift",
    x = "Association Rule",
    y = "Lift Score"
  ) +
  theme_minimal()