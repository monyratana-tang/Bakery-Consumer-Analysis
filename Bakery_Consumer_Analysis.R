# Load packages
library(tidyverse)
library(arules)
library(arulesViz)

# Load dataset
Bakery <- read.csv("bakery_sales_revised.csv")

# Count item purchases
item_counts <- Bakery %>%
  count(Item, sort = TRUE)

# View item variety and top/bottom products
length(unique(Bakery$Item))
head(item_counts, 10)
tail(item_counts, 10)

# Top purchased items
ggplot(item_counts[1:15, ], aes(x = reorder(Item, n), y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  coord_flip() +
  labs(
    title = "Top 10 Most Purchased Bakery Items",
    x = "Bakery Item",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Georgia")
  )

# Bottom purchased items
ggplot(item_counts[74:94, ], aes(x = reorder(Item, n), y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  coord_flip() +
  labs(
    title = "Bottom 20 Most Purchased Bakery Items",
    x = "Bakery Item",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Georgia")
  )

# Purchases by time of day
daypart_counts <- Bakery %>%
  count(period_day, sort = TRUE)

ggplot(daypart_counts, aes(x = reorder(period_day, n), y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  labs(
    title = "Bakery Purchases by Time of Day",
    x = "Time of Day",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(face = "bold", size = 16)
  )

# Weekday vs weekend purchases
behavior_counts <- Bakery %>%
  count(weekday_weekend, sort = TRUE)

ggplot(behavior_counts, aes(x = weekday_weekend, y = n)) +
  geom_bar(stat = "identity", fill = "maroon") +
  labs(
    title = "Bakery Purchases: Weekday vs Weekend",
    x = "Day Type",
    y = "Purchase Frequency"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(face = "bold", size = 16)
  )

# Top items by weekday vs weekend
top_items_daytype <- Bakery %>%
  count(weekday_weekend, Item, sort = TRUE) %>%
  group_by(weekday_weekend) %>%
  slice_max(order_by = n, n = 10)

ggplot(top_items_daytype, aes(x = reorder(Item, n), y = n, fill = weekday_weekend)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  facet_wrap(~weekday_weekend, scales = "free") +
  scale_fill_manual(values = c(
    "weekday" = "#8B1E3F",
    "weekend" = "#C94C6D"
  )) +
  labs(
    title = "Top 10 Purchases on a Weekend & Weekday"
  ) +
  theme(
    legend.position = "none",
    text = element_text(family = "Georgia"),
    plot.title = element_text(face = "bold", size = 16)
  )

# Top items by time of day
top_items_time <- Bakery %>%
  count(period_day, Item, sort = TRUE) %>%
  group_by(period_day) %>%
  slice_max(order_by = n, n = 5)

ggplot(top_items_time, aes(x = reorder(Item, n), y = n, fill = period_day)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  facet_wrap(~period_day, scales = "free") +
  theme(legend.position = "none")

# Convert to transactions for Apriori
transactions <- split(Bakery$Item, Bakery$Transaction)
transactions <- as(transactions, "transactions")

# Run Apriori model
rules <- apriori(
  transactions,
  parameter = list(
    supp = 0.01,
    conf = 0.3,
    target = "rules"
  )
)

# Inspect top rules
inspect(sort(rules, by = "lift")[1:10])
inspect(sort(rules, by = "lift"))

# Prepare top rules for plotting
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