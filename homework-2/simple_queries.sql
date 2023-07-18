-- Напишите запросы, которые выводят следующую информацию:
-- 1. "имя контакта" и "город" (contact_name, country) из таблицы customers (только эти две колонки)
SELECT
CUST.CONTACT_NAME AS CONTACT_NAME,
CUST.COUNTRY AS COUNTRY
FROM CUSTOMERS CUST;

-- 2. идентификатор заказа и разницу между датами формирования (order_date) заказа и его отгрузкой (shipped_date) из таблицы orders
SELECT
ORD.ORDER_ID AS ORDER_ID,
ORD.SHIPPED_DATE - ORD.ORDER_DATE AS DELTA_DATE
FROM ORDERS ORD;

-- 3. все города без повторов, в которых зарегистрированы заказчики (customers)
SELECT
DISTINCT
CUST.CITY AS CITY
FROM CUSTOMERS CUST;

-- 4. количество заказов (таблица orders)
SELECT
COUNT(*)
FROM ORDERS ORD;

-- 5. количество стран, в которые отгружался товар (таблица orders, колонка ship_country)
SELECT
COUNT(DISTINCT ORD.SHIP_COUNTRY) AS COUNT_COUNTRY
FROM ORDERS ORD;