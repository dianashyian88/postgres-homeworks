"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv


# connect to db
conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='PoloA856TN92')
try:
    with conn.cursor() as cur:
        with open('north_data/customers_data.csv', 'r', encoding='UTF-8') as file:
            reader = csv.reader(file)
            next(reader)
            for line in reader:
                cur.execute('INSERT INTO customers VALUES (%s, %s, %s)', (line[0], line[1], line[2]))
        with open('north_data/employees_data.csv', 'r', encoding='UTF-8') as file:
            reader = csv.reader(file)
            next(reader)
            for line in reader:
                if line[0] != '':
                    cur.execute('INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)',
                                (line[0], line[1], line[2], line[3], line[4], line[5]))
        with open('north_data/orders_data.csv', 'r', encoding='UTF-8') as file:
            reader = csv.reader(file)
            next(reader)
            for line in reader:
                if line[0] != '':
                    cur.execute('INSERT INTO orders VALUES (%s, %s, %s, %s, %s)',
                                (line[0], line[1], line[2], line[3], line[4]))
        conn.commit()
finally:
    conn.close()
