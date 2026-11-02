-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, NULL, 'default1'), (1, 'default1', 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, 1, 2), (0, 1, NULL), (1, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default1', 2, 0, 0)
(0, 'default1', None, 0, 0)
(1, None, 2, None, None)
*/

-- Prediction Query
WITH TEMP1 AS (SELECT *, (CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS FROM CONTACTS), TEMP2 AS (SELECT * FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID), TEMP3 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(TRUSTED_CONTACTS) AS TRUSTED_CONTACTS_CNT FROM TEMP1 GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM TEMP2 LEFT JOIN TEMP3 ON TEMP2.USER_ID = TEMP3.USER_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'default1', 2, 0, 0)
(0, 'default1', None, 0, 0)
(1, None, 2, 0, 0)
*/