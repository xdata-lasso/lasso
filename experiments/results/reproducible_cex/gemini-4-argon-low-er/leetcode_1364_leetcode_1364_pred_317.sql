-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'alice@example.com', 'Bob');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 1, 1)
*/

-- Prediction Query
WITH TRUSTED_CONTACTS AS (SELECT T1.CUSTOMER_ID, COUNT(T2.USER_ID) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS T1 LEFT JOIN (SELECT USER_ID, CONTACT_NAME, CONTACT_EMAIL FROM CONTACTS WHERE (CONTACT_NAME, CONTACT_EMAIL) IN (SELECT CUSTOMER_NAME, EMAIL FROM CUSTOMERS)) AS T2 ON T1.CUSTOMER_ID = T2.USER_ID GROUP BY T1.CUSTOMER_ID), CUSTOMER_CONTACTS AS (SELECT T1.CUSTOMER_ID, T1.CUSTOMER_NAME, COUNT(T2.USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS T1 LEFT JOIN CONTACTS AS T2 ON T1.CUSTOMER_ID = T2.USER_ID GROUP BY T1.CUSTOMER_ID) SELECT T1.INVOICE_ID, T2.CUSTOMER_NAME, T1.PRICE, T2.CONTACTS_CNT, T3.TRUSTED_CONTACTS_CNT FROM INVOICES AS T1 LEFT JOIN CUSTOMER_CONTACTS AS T2 ON T1.USER_ID = T2.CUSTOMER_ID LEFT JOIN TRUSTED_CONTACTS AS T3 ON T1.USER_ID = T3.CUSTOMER_ID ORDER BY 1, T1.invoice_id NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/