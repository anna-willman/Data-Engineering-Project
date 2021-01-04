# Data-Engineering-Project
Assignment: Create an end to end process of gathering, preparing and storing data in databases

Project Summary: Using data from Yelp, Zomato, and the COVID Track Project, we created a database of restaurants in Las Vegas and COVID case metrics in Nevada.
  1. Data was extracted from site APIs using Python
  2. Data was transformed using Python and OpenRefine
  3. DDL for database was created with SQL
  4. Database was created by loading DDL SQL into Google Cloud Platforms, then tables were populated with datasets from step 2
  5. Database was also connected to Tableau to pull reports and insights

Business Case: Help customers find the best and safest restaurants in the Las Vegas area

Files:
  Data Export & Transform
  - COVID_Data.ipynb - Extract, clean, and transform data from COVID Tracking Project's API
  - Yelp_data.ipynb - Extract and clean data from Yelp's academic dataset
  - Category_Data_Yelp.ipynb - Transform data within Yelp's category column to parse out categories and create a separate category table
  - Zomato Data.ipynb - Extract, clean, and transform data from Zomato's API (LIMIT 100)
  
  Create database
  - FINAL PROJECT DDL_V2.sql - DDL for OLAP dimensional database
  
  
