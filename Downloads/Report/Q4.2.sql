SELECT AVG(purchasedItemCount) AS averageItem
FROM receipts1
WHERE rewardsReceiptStatus != 'rejected'