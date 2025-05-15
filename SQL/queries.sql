-- Attempting to load the data from csv using command line instead of import wizard
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/ams/Downloads/transactions_clean.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- These are the final queries used for this project
-- Creating the bins to group users depending on their number of cards.
CREATE TEMPORARY TABLE 
bins AS
SELECT
    u.id AS user_id, 
    u.yearly_income,
    COUNT(c.id) AS card_count,
    CASE
        WHEN COUNT(c.id) < 5 THEN "1-4 cards"
        WHEN COUNT(c.id) < 8 THEN "5-7 cards"
        ELSE "8-9 cards"
    END AS cardcount_group
FROM users u
LEFT JOIN cards c 
    ON u.id = c.client_id
GROUP BY u.id,  u.yearly_income;

-- Getting the number of users per card count group
WITH cardcount_users AS (
    SELECT 
        user_id, 
        SUM(card_count) AS card_count 
    FROM bins
    GROUP BY user_id
)
SELECT 
    card_count, 
    COUNT(user_id) AS user_count
FROM cardcount_users
GROUP BY card_count 
ORDER BY card_count;

-- Do users transact more frequently or spend more as their number of cards increase?
-- Calculate the montly transaction count and the monthly spend per user with card count information
SELECT 
    t.client_id, 
    COUNT(DISTINCT t.card_id) AS cardcount_trans, -- Total number of cards used in transactions
    b.card_count AS cardcount_issued, -- Total number of cards issued
    COUNT(t.id) AS total_trans, 
    COUNT(t.id) / COUNT(DISTINCT CONCAT(YEAR(t.date), '-', MONTH(t.date))) AS monthly_trans,
    SUM(t.amount) AS total_spend,
    SUM(t.amount) / COUNT(DISTINCT CONCAT(YEAR(t.date), '-', MONTH(t.date))) AS monthly_spend
FROM transactions t
LEFT JOIN bins b
	ON  t.client_id = b.user_id
GROUP BY t.client_id, card_count
ORDER BY t.client_id;	

-- Calculating the high income users per cardcount_group
SELECT 
  card_count, 
  COUNT(user_id) AS user_count,
  ROUND(100.0 * COUNT(user_id) / SUM(COUNT(user_id)) OVER (), 2) AS percentage_of_total
FROM bins 
WHERE yearly_income > 52698.50 -- computed 75th percentile in Jupyter Notebook
GROUP BY card_count
ORDER BY percentage_of_total DESC;

-- Getting the Top 10 MCCs per cardcount_group to analyze spend priority
WITH ranked_spend AS (
    SELECT 
        t.mcc,
        m.merchant,
        b.cardcount_group AS bin,
        AVG(t.amount) AS avg_spend,
        COUNT(DISTINCT t.client_id) as user_count,
        ROW_NUMBER() OVER (PARTITION BY b.cardcount_group ORDER BY SUM(t.amount) DESC) AS rn
    FROM transactions t
    LEFT JOIN mcc m ON t.mcc = m.mcc_code
    LEFT JOIN bins b ON t.client_id = b.user_id
    GROUP BY t.mcc, m.merchant, b.cardcount_group
)
SELECT 
    mcc,
    merchant,
    bin,
    avg_spend,
    user_count
FROM ranked_spend
WHERE rn <= 10 -- Getting the Top 10 MCCs
ORDER BY bin, avg_spend DESC;

-- Getting the total spend per user for betting in 8-9 cards.

SELECT 
    t.client_id,
    t.mcc,
    m.merchant,
    b.cardcount_group AS bin,
    YEAR(t.date) AS year,
    SUM(t.amount) AS total_spend
FROM transactions t
LEFT JOIN mcc m ON t.mcc = m.mcc_code
LEFT JOIN bins b ON t.client_id = b.user_id
WHERE t.mcc = '7995'
GROUP BY t.client_id, t.mcc, m.merchant, bin,year
ORDER BY total_spend DESC;
