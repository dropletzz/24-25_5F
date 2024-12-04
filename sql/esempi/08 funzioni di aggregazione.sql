-- FUNZIONI DI AGGREGAZIONE
-- Le funzioni di aggregazione ricevono in ingresso un elenco di valori
-- e resituiscono un unico valore.
-- Sono spesso usate insieme a GROUP BY.
-- Esempi di funzione di aggregazione sono:
-- * COUNT: conteggio
-- * MAX: calcola il massimo
-- * MIN: calcola il minimo
-- * SUM: calcola la somma
-- * AVG: calcola la media
-- * VARIANCE: calcola la varianza

USE ecommerce;

-- seleziona tutti i prodotti che sono stati acquistati almeno 10 volte
SELECT products.name, SUM(quantity) AS total_quantity
FROM products JOIN products_orders ON products.id = products_orders.product_id
GROUP BY products.id
HAVING total_quantity >= 10;
-- NOTA: la clausola HAVING e' simile a WHERE, con la differenza che
-- ha effetto dopo il GROUP BY (quindi ha accesso a valori calcolati
-- con funzioni di aggregazione, come "total_quantity")

-- seleziona tutti i prodotti che non sono stati mai acquistati
SELECT products.name
FROM products LEFT JOIN products_orders ON products.id = products_orders.product_id
WHERE products_orders.order_id IS NULL;

-- selezionare tutti gli utenti che hanno fatto almeno 3 ordini
SELECT users.email, COUNT(*) AS orders_count
FROM users
JOIN orders ON users.id = orders.user_id
GROUP BY users.id 
HAVING orders_count >= 3;

-- selezionare gli utenti e per ognuno calcolare la spesa totale
-- ordinare i risultati partendo da chi ha speso di piu'
SELECT u.email, SUM(po.quantity * po.price) AS tot
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
LEFT JOIN products_orders po ON o.id = po.order_id
GROUP BY u.id
ORDER BY tot DESC;

-- calcolare, per ogni prodotto, la varianza del suo prezzo
SELECT p.name, VARIANCE(po.price) AS var
FROM products p
LEFT JOIN products_orders po ON p.id = po.product_id
GROUP BY p.id
ORDER BY var DESC;
-- NOTA: varianza alta significa che il prezzo e' cambiato molto, 
-- varianza bassa che e' rimasto piu' o meno uguale