-- Напишите запросы, которые выводят следующую информацию:
-- 1. заказы, доставленные в страны France, Germany, Spain (таблица orders, колонка ship_country)
SELECT *
FROM ORDERS ORD
WHERE ORD.SHIP_COUNTRY IN ('France', 'Germany', 'Spain');

-- 2. уникальные города и страны, куда отправлялись заказы, отсортировать по странам и городам (таблица orders, колонки ship_country, ship_city)
SELECT
DISTINCT
ORD.SHIP_CITY AS SHIP_CITY,
ORD.SHIP_COUNTRY AS SHIP_COUNTRY
FROM ORDERS ORD
ORDER BY
ORD.SHIP_COUNTRY,
ORD.SHIP_CITY;

-- 3. сколько дней в среднем уходит на доставку товара в Германию (таблица orders, колонки order_date, shipped_date, ship_country)
SELECT
AVG(ORD.SHIPPED_DATE - ORD.ORDER_DATE) AS DELIVERI_TIME
FROM ORDERS ORD
WHERE ORD.SHIP_COUNTRY = 'Germany';

-- 4. минимальную и максимальную цену среди продуктов, не снятых с продажи (таблица products, колонки unit_price, discontinued не равно 1)
SELECT
MIN(PROD.UNIT_PRICE) AS MIN_PRICE,
MAX(PROD.UNIT_PRICE) AS MAX_PRICE
FROM PRODUCTS PROD
WHERE PROD.DISCONTINUED != 1;

-- 5. минимальную и максимальную цену среди продуктов, не снятых с продажи и которых имеется не меньше 20 (таблица products, колонки unit_price, units_in_stock, discontinued не равно 1)
SELECT
MIN(PROD.UNIT_PRICE) AS MIN_PRICE,
MAX(PROD.UNIT_PRICE) AS MAX_PRICE
FROM PRODUCTS PROD
WHERE PROD.DISCONTINUED != 1
AND PROD.UNITS_IN_STOCK >= 20;