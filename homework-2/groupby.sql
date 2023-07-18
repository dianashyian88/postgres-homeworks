-- Напишите запросы, которые выводят следующую информацию:
-- 1. заказы, отправленные в города, заканчивающиеся на 'burg'. Вывести без повторений две колонки (город, страна) (см. таблица orders, колонки ship_city, ship_country)
SELECT
DISTINCT
ORD.SHIP_CITY AS SHIP_CITY,
ORD.SHIP_COUNTRY AS SHIP_COUNTRY
FROM ORDERS ORD
WHERE ORD.SHIP_CITY LIKE '%burg';

-- 2. из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. Заказ отгружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.
SELECT
ORD.ORDER_ID AS ORDER_ID,
ORD.CUSTOMER_ID AS CUSTOMER_ID,
ORD.FREIGHT AS FREIGHT,
ORD.SHIP_COUNTRY AS SHIP_COUNTRY
FROM ORDERS ORD
WHERE ORD.SHIP_COUNTRY LIKE 'P%'
ORDER BY ORD.FREIGHT DESC
LIMIT 10;

-- 3. фамилию, имя и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees)
SELECT
EMP.LAST_NAME AS LAST_NAME,
EMP.FIRST_NAME AS FIRST_NAME,
EMP.HOME_PHONE AS HOME_PHONE
FROM EMPLOYEES EMP
WHERE EMP.REGION IS NULL;

-- 4. количество поставщиков (suppliers) в каждой из стран. Результат отсортировать по убыванию количества поставщиков в стране
SELECT
SUP.COUNTRY AS COUNTRY,
COUNT(SUP.SUPPLIER_ID) AS COUNT
FROM SUPPLIERS SUP
GROUP BY SUP.COUNTRY
ORDER BY COUNT(SUP.SUPPLIER_ID) DESC;

-- 5. суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight)
SELECT
ORD.SHIP_COUNTRY AS SHIP_COUNTRY,
SUM(ORD.FREIGHT) AS FREIGHT
FROM ORDERS ORD
GROUP BY ORD.SHIP_COUNTRY
HAVING SUM(ORD.FREIGHT) > 2750
ORDER BY SUM(ORD.FREIGHT) DESC;

-- 6. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees).
SELECT
DISTINCT
CUST.COUNTRY AS COUNTRY
FROM CUSTOMERS CUST
INNER JOIN SUPPLIERS SUP
ON CUST.COUNTRY = SUP.COUNTRY
INNER JOIN EMPLOYEES EMP
ON CUST.COUNTRY = EMP.COUNTRY;

-- 7. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), но не зарегистрированы работники (employees).
SELECT
DISTINCT
CUST.COUNTRY AS COUNTRY
FROM CUSTOMERS CUST
INNER JOIN SUPPLIERS SUP
ON CUST.COUNTRY = SUP.COUNTRY
WHERE CUST.COUNTRY NOT IN (SELECT
						   DISTINCT EMP.COUNTRY
						   FROM EMPLOYEES EMP);