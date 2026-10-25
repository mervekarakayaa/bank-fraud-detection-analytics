SELECT 
    t.tx_id,
    t.customer_id,
    c.age,
    c.income,
    c.segment,
    t.amount,
    t.merchant_category,
    t.timestamp,
    EXTRACT(HOUR FROM t.timestamp) AS transaction_hour,
    CASE 
        WHEN EXTRACT(HOUR FROM t.timestamp) BETWEEN 0 AND 5 THEN 'Gece (00-05)'
        ELSE 'Gündüz (06-23)'
    END AS time_period,
    CASE 
        WHEN t.amount >= 800 THEN '4. High Risk (800+)'
        WHEN t.amount >= 500 THEN '3. Medium-High (500-799)'
        WHEN t.amount >= 200 THEN '2. Medium (200-499)'
        ELSE '1. Low Risk (<200)'
    END AS amount_bucket,
    f.is_fraud
FROM fraud_transactions t
JOIN fraud_customers c ON t.customer_id = c.customer_id
JOIN fraud_labels f ON t.tx_id = f.tx_id;