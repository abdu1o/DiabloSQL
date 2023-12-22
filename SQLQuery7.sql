UPDATE Item
SET price = price - price * 0.05,
    delivery_date = COALESCE(delivery_date, GETDATE());

SELECT 
  type AS [Item],

  price AS [Price],
  CASE WHEN type IN ('bow', 'sword') THEN ROUND(SUM(price - price * 0.2), 2) END AS [Price after discount 20%],

  delivery_date AS [Delivery date],

  amount AS [Amount],
  CASE WHEN amount > 10 AND 
  (DATEDIFF(DAY, delivery_date, GETDATE()) = 0 OR 
  DATEDIFF(DAY, delivery_date, GETDATE()) = 1) THEN amount
  END AS [Amount > 10 && delivery date > yesterday]

FROM Item
GROUP BY type, price, delivery_date, amount;

DELETE FROM Item
WHERE amount < 10 AND price > 6666; --вместо 70 грн

DELETE FROM Item
WHERE type IN ('amulet', 'ring'); --вместо алкогол€ и кондитерских изделий

DELETE FROM Item
WHERE DATEDIFF(DAY, delivery_date, GETDATE()) > 3; --дата доставки более 3 дн€ вместо 3 мес€ца от текущей

DELETE FROM Item
WHERE aspect IS NULL OR gem_slots IS NULL; --если информаци€ об аспекте неизвестна (производителе) или количество слотов NULL (вместо скидки 10%)