# 🚗 Predicting UK Vehicle Market Trends (2024-2040) using MATLAB

## 📌 Project Overview

This project forecasts the UK vehicle market trends from **2024 to 2040** by analyzing historical data on vehicle stock and new registrations. The study is aligned with the UK government's **net-zero strategy**, aiming for a full transition to zero-emission vehicles by **2035**.

## 📊 Dataset

- **Source:** [VEH1111 dataset from the UK Department for Transport](https://www.gov.uk/government/statistical-data-sets/vehicle-licensing-statistics-data-tables#all-vehicles)  
- **Size:** 3.14 MB (ODS format)  
- **Key Features:**
  - **Vehicle Type:** Cars, LGVs, HGVs, Buses & Coaches, Motorcycles  
  - **Fuel Type:** Diesel, Petrol, Battery Electric, Hybrid  
  - **First Year of Use:** 1994-2023  
  - **Annual Registration & Market Stock Data**  

## 🎯 Objectives

1. **Forecast the total market demand** for different vehicle types from **2024 to 2040**.
2. **Estimate survival rates** of different vehicle types and fuel systems based on historical data.
3. **Predict annual new vehicle registrations** needed to maintain market demand.

## 🛠️ Methodology

### 1️⃣ Estimating Market Demand (2024-2040)
- Analyzed **total vehicle stock trends** (Cars, LGVs, HGVs, Buses, Motorcycles) from **1994-2023**.
- Applied **time-series forecasting** (ARIMA, exponential smoothing) to project the required number of vehicles in the market each year.

### 2️⃣ Survival Rate Estimation
- Analyzed **historical survival rates** by vehicle type and fuel system.
- Derived **survival rate curves** from 1994-2023 new vehicle registrations:
  - Tracked retention rates of different vehicle types at different ages.
  - Created **age-based survival probability functions**.

### 3️⃣ Predicting New Vehicle Registrations
- Used the formula:  
  \[
  \text{Market Stock} = \sum (\text{Surviving Older Vehicles}) + \text{New Registrations}
  \]
- Solved for **new registrations** by applying survival rate curves to estimate the retention of past vehicle registrations.
- Adjusted for **policy-driven shifts** in vehicle demand (e.g., increasing electric vehicle adoption).

## 📈 Key Findings

-**Battery Electric Vehicles (BEVs) will dominate the UK market by 2040.** The market share of petrol and diesel cars will decline sharply post-2025, with BEVs experiencing exponential growth and surpassing both fuel types in total market stock by 2035. A similar trend is observed in LGVs, where BEVs will replace diesel-powered LGVs as the primary choice before 2040.

-**Diesel and petrol vehicle registrations will decline to near-zero levels after 2035.** Diesel new registrations will see a rapid drop after 2025, aligning with government policies banning new sales of fossil-fuel vehicles by 2030. Petrol registrations will fluctuate in the short term but follow a long-term downward trajectory, with LGVs already nearing zero new registrations.

-**The transition period from 2025 to 2035 will be critical for market adaptation.** The sharp decline in new petrol and diesel vehicle registrations will necessitate infrastructure expansion, particularly in EV charging networks. Government policies and incentives will play a crucial role in ensuring a smooth transition to meet the net-zero 2035 target.
