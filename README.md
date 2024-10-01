# E-commerce Data Analysis Project

This project represents a comprehensive analysis of e-commerce data and showcases my ability to clean, analyze, and visualize large datasets. The project is designed to be a complete end-to-end demonstration of my data analysis skills, making it a showcase project for potential employers. It involves data cleaning with Python and pandas, writing SQL queries for data retrieval and analysis, and creating insightful visualizations using various tools.

## Project Overview

The key objectives of this project are:
- **Data Cleaning**: Cleaning raw e-commerce data using Python's pandas library.
- **SQL Queries**: Writing advanced SQL queries to extract insights from the cleaned data.
- **Data Visualization**: Creating meaningful and interactive visualizations that tell a story using the insights gathered.

## Dataset

The dataset used for this project contains e-commerce transactional data, including:
- **Order ID**: Unique identifier for each order.
- **Product**: Details about the products sold.
- **Customer**: Customer information, including ID and location.
- **Price**: Price of each product.
- **Quantity**: Number of units sold for each product.
- **Order Date**: Date when the order was placed.
- **Payment Method**: The method used for payment (e.g., credit card, PayPal).
- **Shipping Information**: Details about shipping, including delivery time and shipping cost.

## Key Steps

### 1. Data Cleaning in Python

In the first stage of the project, the raw data is cleaned using Python’s pandas library. This Jupyter Notebook demonstrates:
- Handling missing or null values.
- Removing duplicates.
- Correcting inconsistent or malformed data (e.g., incorrect dates or prices).
- Standardizing the format of the dataset for ease of analysis.

Some key cleaning steps:
```python
import pandas as pd

# Load the clean data
df = pd.read_csv('ecommerce_data_clean.csv')

# Example: Handling missing values
df['Price'] = df['Price'].fillna(df['Price'].mean())

# Example: Converting columns to the correct data type
df['Order Date'] = pd.to_datetime(df['Order Date'])
