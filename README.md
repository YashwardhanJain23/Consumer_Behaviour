# eCommerce Customer Analysis with R

This project performs an analysis of an eCommerce customer dataset using R to derive insights into customer behavior, segmentation, and churn rate.

## Overview

The analysis focuses on understanding various aspects of customer behavior and patterns within an eCommerce platform using R. It includes:

- **Data Exploration:** Summary statistics, visualization of distributions, and categorical summaries.
- **Relationship Analysis:** Investigates the correlation between browsing behavior and page views.
- **Customer Segmentation:** Segments customers based on Customer Lifetime Value (CLV).
- **Churn Rate Calculation:** Determines the proportion of customers with no purchases.

## Usage

The analysis is performed entirely in R and uses several libraries, including `plotly`, `dplyr`, `tidyr`, and `readr`.

## Files

- `analysis.R`: R script containing the entire analysis conducted.
- `ecommerce_customer_data.csv`: Dataset used for analysis.

## Analysis Steps

The analysis script `analysis.R` is divided into several sections, including:

- Data loading and summary statistics.
- Visualization of distributions (e.g., histograms, bar charts).
- Exploration of relationships (e.g., scatter plots, trendlines).
- Customer segmentation based on CLV.
- Calculation of churn rate.

## Results

- No consistent pattern found between browsing time and total pages viewed.
- Segmentation into Low, Medium, and High Value customers based on CLV.
- Churn rate calculated at approximately 19.8%.

## Conclusion

The insights derived from this R-based analysis provide valuable information for understanding customer behavior and trends within the eCommerce platform. The lack of a strong correlation between browsing time and page views suggests several factors influencing user engagement. Segmentation based on CLV and the calculated churn rate can guide strategies for user engagement, marketing efforts, and customer retention.
