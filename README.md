# Healthcare-Data-Analysis-With-SQL
A complete healthcare analytics project done entirely with SQL, featuring database design, data cleaning, and insightful queries on hospital operations and patient statistics.
# Introduction
The Healthcare Data Analysis Using SQL project demonstrates how structured query language (SQL) can be used to clean, organize, and analyze raw healthcare data to generate meaningful insights.
This project was completed entirely using SQL (Microsoft SQL Server) — no external analytics or visualization tools — showcasing the power of SQL for data modeling, transformation, and analytical reporting.
# Problem Statement
To uncover insights that can drive better healthcare decisions, optimize costs, and improve patient outcomes.
## Key Question
1.	What are the most common age groups, genders, and blood types among patients? Are certain groups being admitted more often than others?

2.	Which medical conditions are diagnosed the most, and do they affect certain groups of people more than others?

3.	How long do patients typically stay in the hospital for different conditions? Does this vary depending on the hospital or type of admission (emergency, urgent, or planned)?

4.	How much does treatment usually cost for each condition? Are there big differences in costs between hospitals or insurance providers?

5.	Which hospitals are treating the most patients, and how do they compare in terms of patient outcomes, like test results?

6.	What medications are most often prescribed for each condition? Are they being used consistently across hospitals?

7.	How are patients admitted - mostly through emergency, urgent, or planned admissions - and how does that impact the length of stay or treatment costs?

8.	Which insurance companies are covering the most patients, and how does that relate to treatment costs and patient outcomes?
# Skills Demonstration
- Data Modelling
- Data Cleaning
- SQL CTEs, Subqueries, Windows function, etc
- Analysis
# Data Sourcing
 I got the dataset from Onyx Data Challenge
# Data Transformation
A fact table was only given containing fiels such as age, gender, blood type, medical condition, hospital, insurance provider, medication, billing amount, admission type, and test results.
- I checked and remove duplicates
- I created Four Dimensions table namely: DimHospital(for hospitals), DimInsuranceProviders(for insurance providers), DimMedicalCondition(for medical conditions of patient), DimMedication( for medication issued).
- Exported distinct values of Hospitals to DimHospital and others to their corresponding dimensions table, then i created an ID field in all the dimensions table to serve as primary key of the Dimensions table, their coresponding foreign keys was also created in the Facts Table
- The dimensions and fact tables were connected appropriately.
- A duration field was also created to get the number of days patients spent in the hospital.
# Modelling
a star schema was created
![](ER_Diagram.JPG)
# Analysis/Queries
