# 💳 Behind the Cards: An Exploratory Banking Data Analysis

A deep-dive into user spending behavior, card ownership patterns, and potential fraud signals, based on a decade of transaction data. This project uses SQL, Python, and Excel to perform exploratory data analysis (EDA) on over **13 million financial records** provided by Caixabank Tech during the 2024 AI Hackathon.

---

## 📌 Objective

To uncover trends, behavioral patterns, and anomalies across user card usage and transaction histories using advanced data tools. The goal is to generate insights that could be useful for **risk detection**, **product strategy**, and **customer segmentation** in a banking context.

---

## 🧰 Tools & Technologies

- **Python** (Jupyter Notebook): data cleaning, EDA, visualization
- **SQL** (MySQL Workbench): data wrangling, grouping, statistical queries
- **Excel**: pivot tables, quick checks, preliminary visuals
- **Canva & Flourish**: data storytelling and presentation design

---

## 📂 Dataset Overview

> Source: [Kaggle - Transactions Fraud Dataset](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)

The dataset spans from **2010 to 2019** and includes:

| File | Description | Rows |
|------|-------------|------|
| `transactions_data.csv` | Detailed transaction records | 13,305,916 |
| `cards_data.csv` | Card-level data | 6,146 |
| `users_data.csv` | User-level demographics & income | 2,000 |
| `mcc_codes.json` | Merchant category codes (MCCs) | 109 |

---

## 🧼 Data Cleaning & Preprocessing

- Large transaction data (>13M rows) was cleaned using Python (Pandas).
- Users were binned into **card count groups** (1–4, 5–7, 8+).
- SQL scripts were used to join datasets, extract insights, and identify patterns based on MCCs and transaction behavior.
- Statistical tests (e.g., Pearson correlation) were run in Python to measure relationships.

---

## 🔍 Key Questions Explored

- Do users with more cards spend or transact more?
- Do high-income earners tend to own more cards?
- Are there behavioral differences in users with 8 or more cards?
- Are there any **suspicious or anomalous transaction patterns**?

---

## 📈 Key Insights

- **Card Ownership**:  
  > 81% of users have 1–4 cards; only 1% have 8 or more.

- **Spending Patterns**:  
  > Weak but statistically significant correlation between card count and spending/transaction volume (r ≈ 0.12–0.17).

- **Income vs. Card Count**:  
  > High earners don't necessarily own more cards. Among $100K+ earners, **females earn 29% more than males** on average.

- **Risk Signal – MCC 7995 (Betting & Casinos)**:  
  > High discretionary spend found only in 8–9 cardholders. Geographic transaction anomalies suggest potential **fraud or account misuse**.

---

## 🚨 Fraud Case Example

Two top spenders conducted transactions in **distant geographic locations within a short time window**—an unlikely scenario for a single legitimate user. These cases may warrant review by a fraud risk team.

---

## 📊 Visualizations

Key charts include:

- Card Count Distribution
- Monthly Spend and Transactions 
- MCC Spend Comparison
- High Income Useres & Card Count
- Suspicious Transactions

See full slides [here](https://www.canva.com/design/DAGmz39dzx8/hMsHnhsICrkRvahy_0jIOQ/edit?utm_content=DAGmz39dzx8&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)
---
## 🔗 Links

- 💻 [Full Python Code on GitHub](https://github.com/CodeKissed/Behind-The-Cards/tree/main/Python)
- 💻 [Full SQL Queries on GitHub](https://github.com/CodeKissed/Behind-The-Cards/blob/main/SQL/queries.sql)
- 🌐 [Kaggle Dataset](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)
- 🧠 Author: [Andromeda Canete-Borys](mailto:andromeda@canete.me)

---

## 💬 Contact

**Andromeda Canete-Borys**  
Data Analyst | Burnaby, BC  
📞 236-979-3140  
📧 andromeda@canete.me  
🌐 [GitHub: CodeKissed](https://github.com/CodeKissed)
