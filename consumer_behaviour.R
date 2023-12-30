install.packages("plotly")
library(plotly)
library(readr)
library(dplyr)
library(tidyr)

ecommerce_customer_data <- read_csv("ecommerce_customer_data.csv")

# Display the first few rows of the dataset
head(ecommerce_customer_data)

# Summary statistics for numeric columns
numeric_summary <- summary(ecommerce_customer_data)
print(numeric_summary)

# Function to summarize categorical columns
summarize_categorical <- function(data) {
  data %>%
    select_if(is.character) %>%
    gather() %>%
    group_by(key) %>%
    summarise(count = n(), unique_values = n_distinct(value))
}

# Summary for non-numeric (categorical) columns
categorical_summary <- summarize_categorical(ecommerce_customer_data)
print(categorical_summary)

# Create a histogram for the 'Age' column
age_histogram <- plot_ly(data = ecommerce_customer_data, x = ~Age, type = "histogram") %>%
  layout(title = "Distribution of Age")
age_histogram

# Get counts for 'Gender'
gender_counts <- table(ecommerce_customer_data$Gender)

# Convert counts to a data frame
gender_counts_df <- data.frame(Gender = names(gender_counts), Count = as.numeric(gender_counts))

# Create a bar chart for 'Gender'
gender_bar_chart <- plot_ly(data = gender_counts_df, x = ~Gender, y = ~Count, type = "bar") %>%
  layout(title = "Gender Distribution")
gender_bar_chart


# Let's examine the correlation between the amount of time spent browsing a product and the total number of pages viewed:

# Fit a linear regression model
lm_model <- lm(Total_Pages_Viewed ~ Product_Browsing_Time, data = ecommerce_customer_data)

# Create a scatter plot for 'Product_Browsing_Time' vs 'Total_Pages_Viewed' and overlay a single trendline
scatter_plot <- plot_ly(data = ecommerce_customer_data, x = ~Product_Browsing_Time, y = ~Total_Pages_Viewed, type = "scatter", mode = "markers") %>%
  add_trace(x = ecommerce_customer_data$Product_Browsing_Time, y = predict(lm_model), mode = "lines", line = list(color = "blue"), showlegend = FALSE) %>%
  layout(title = "Product Browsing Time vs. Total Pages Viewed")

# Display the scatter plot with a single trendline
scatter_plot

cat("The scatter plot doesn't reveal a strong correlation between browsing time and the number of viewed pages. This suggests that spending more time on the website doesn't consistently result in exploring more pages. Factors like website design, content relevance, and individual preferences may influence this observation.")

# Now, let's find the average total pages viewed by gender:

# Calculate the average total pages viewed by gender
gender_grouped <- aggregate(Total_Pages_Viewed ~ Gender, data = ecommerce_customer_data, FUN = mean)

# Rename the columns
colnames(gender_grouped) <- c('Gender', 'Average_Total_Pages_Viewed')

# Create a bar chart for average total pages viewed by gender
bar_chart_gender <- plot_ly(data = gender_grouped, x = ~Gender, y = ~Average_Total_Pages_Viewed, type = "bar") %>%
  layout(title = 'Average Total Pages Viewed by Gender')

# Display the bar chart
bar_chart_gender

# Now, let's find the average total pages viewed by devices:

# Calculate the average total pages viewed by device type
devices_grouped <- aggregate(Total_Pages_Viewed ~ Device_Type, data = ecommerce_customer_data, FUN = mean)

# Rename the columns
colnames(devices_grouped) <- c('Device_Type', 'Average_Total_Pages_Viewed')

# Create a bar chart for average total pages viewed by device type
bar_chart_devices <- plot_ly(data = devices_grouped, x = ~Device_Type, y = ~Average_Total_Pages_Viewed, type = "bar") %>%
  layout(title = 'Average Total Pages Viewed by Devices')

# Display the bar chart
bar_chart_devices

# Now,let's examine the customer lifetime value and create a segmentation based on that value:

# Calculate Customer Lifetime Value (CLV) and create segments
ecommerce_customer_data$CLV <- (ecommerce_customer_data$Total_Purchases * ecommerce_customer_data$Total_Pages_Viewed) / ecommerce_customer_data$Age

ecommerce_customer_data$Segment <- cut(ecommerce_customer_data$CLV,
                                       breaks = c(1, 2.5, 5, Inf),
                                       labels = c('Low Value', 'Medium Value', 'High Value'))

# Count the number of customers in each segment
segment_counts <- as.data.frame(table(ecommerce_customer_data$Segment))
colnames(segment_counts) <- c('Segment', 'Count')

# Create a bar chart to visualize customer segments
bar_chart_segment <- plot_ly(data = segment_counts, x = ~Segment, y = ~Count, type = "bar") %>%
  layout(title = 'Customer Segmentation by CLV',
         xaxis = list(title = 'Segment'),
         yaxis = list(title = 'Number of Customers'))

# Display the bar chart
bar_chart_segment

# Now, let us examine the customer attrition rate:

# Calculate churn rate
ecommerce_customer_data$Churned <- ecommerce_customer_data$Total_Purchases == 0

churn_rate <- mean(ecommerce_customer_data$Churned)
print(churn_rate)

cat("After analyzing the eCommerce customer dataset, several key insights have emerged. The relationship between product browsing time and total pages viewed showed no consistent pattern, indicating that more time spent browsing doesn't necessarily correlate with exploring more pages. Segmentation based on Customer Lifetime Value (CLV) revealed distinct customer segments categorized as Low, Medium, and High Value, providing valuable insights into customer behavior. Additionally, the calculated churn rate of approximately 19.8% highlights the proportion of customers with no purchases, aiding in understanding customer retention. These insights can guide further exploration and targeted strategies to enhance user experience, optimize marketing efforts, and improve customer retention strategies for sustained business growth.")
