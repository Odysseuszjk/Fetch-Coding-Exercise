SELECT AVG(purchasedItemCount), rewardsReceiptStatus
FROM receipts1
WHERE rewardsReceiptStatus = 'REJECTED'
GROUP BY rewardsReceiptStatus