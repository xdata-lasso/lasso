-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'alice@example.com', 'Bob');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (101, 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(101, 'Alice', 50, 1, 1)
*/

-- Prediction Query
WITH TEMP AS (SELECT *, CASE WHEN (CONTACT_NAME, CONTACT_EMAIL) IN (SELECT CUSTOMER_NAME, EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED FROM CONTACTS) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(COUNT(T3.USER_ID), 0) AS CONTACTS_CNT, COALESCE(SUM(TRUSTED), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS T1 LEFT JOIN CUSTOMERS AS T2 ON T1.USER_ID = T2.CUSTOMER_ID LEFT JOIN TEMP AS T3 ON T1.USER_ID = T3.USER_ID GROUP BY INVOICE_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(101, 'Alice', 50, 1, 0)
*/