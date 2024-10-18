SELECT AVG(totalSpent) AS averageSpent
FROM receipts1
WHERE rewardsReceiptStatus != 'rejected'