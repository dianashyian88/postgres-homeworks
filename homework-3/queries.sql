-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT
DISTINCT
CUST.COMPANY_NAME,
EMP.EMP_NAME
FROM ORDERS ORD
INNER JOIN (SELECT
            CUSTOMER_ID,
            COMPANY_NAME
            FROM CUSTOMERS
            WHERE CITY = 'London') CUST
ON ORD.CUSTOMER_ID = CUST.CUSTOMER_ID
INNER JOIN (SELECT
            EMPLOYEE_ID,
            CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EMP_NAME
            FROM EMPLOYEES
            WHERE CITY = 'London') EMP
ON ORD.EMPLOYEE_ID = EMP.EMPLOYEE_ID
INNER JOIN (SELECT
            SHIPPER_ID
            FROM SHIPPERS
            WHERE COMPANY_NAME = 'United Package') SHIP
ON ORD.SHIP_VIA = SHIP.SHIPPER_ID;

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT
PROD.PRODUCT_NAME,
PROD.UNITS_IN_STOCK,
SUP.CONTACT_NAME,
SUP.PHONE
FROM PRODUCTS PROD
INNER JOIN SUPPLIERS SUP
ON PROD.SUPPLIER_ID = SUP.SUPPLIER_ID
WHERE PROD.DISCONTINUED = 0
AND PROD.UNITS_IN_STOCK < 25
AND PROD.CATEGORY_ID IN (SELECT CATEGORY_ID
                         FROM CATEGORIES
                         WHERE CATEGORY_NAME IN ('Dairy Products', 'Condiments'))
ORDER BY PROD.UNITS_IN_STOCK;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT
CUST.COMPANY_NAME
FROM CUSTOMERS CUST
LEFT JOIN ORDERS ORD
ON CUST.CUSTOMER_ID = ORD.CUSTOMER_ID
WHERE ORD.ORDER_ID IS NULL;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT
DISTINCT
PROD.PRODUCT_NAME
FROM PRODUCTS PROD
WHERE PROD.PRODUCT_ID IN (SELECT PRODUCT_ID
						 FROM ORDER_DETAILS
						 WHERE QUANTITY = 10)
ORDER BY PROD.PRODUCT_NAME;