-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '53', '40');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '40', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (31, 29, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, None, 1, None, None)
(31, '53', 1, 0, 1)
*/

-- Prediction Query
WITH CONTACTS_CNT AS (SELECT T1.CUSTOMER_ID, T1.CUSTOMER_NAME, COALESCE(COUNT(T2.CONTACT_NAME), 0) AS CONTACTS_CNT, COALESCE(SUM(CASE WHEN T2.CONTACT_EMAIL IN (SELECT EMAIL AS CONTACT_EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS T1 LEFT JOIN CONTACTS AS T2 ON T1.CUSTOMER_ID = T2.USER_ID GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS T1 JOIN CONTACTS_CNT AS T2 ON T1.USER_ID = T2.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(31, '53', 1, 0, 1)
*/