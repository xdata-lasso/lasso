-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (27, '36', '37');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '37', '35');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (60, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (28, 27, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(28, '36', None, 1, 1)
(60, None, 1, None, None)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMERS.CUSTOMER_ID AS ID, CUSTOMERS.CUSTOMER_NAME AS NAME, CONTACTS.CONTACT_NAME AS CONTACT_NAME FROM CUSTOMERS LEFT JOIN CONTACTS ON CUSTOMERS.CUSTOMER_ID = CONTACTS.USER_ID), CTE2 AS (SELECT ID, NAME, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CTE GROUP BY ID, NAME) SELECT INVOICES.INVOICE_ID, CTE2.NAME AS CUSTOMER_NAME, INVOICES.PRICE, CTE2.CONTACTS_CNT, CTE2.TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CTE2 ON INVOICES.USER_ID = CTE2.ID ORDER BY INVOICES.INVOICE_ID;

/*
Prediction Result:
(28, '36', None, 1, 0)
(60, None, 1, None, None)
*/