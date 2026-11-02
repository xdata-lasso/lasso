-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (24, '32', '33');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (59, '35', '36');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (59, '36', '34');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (58, 59, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (25, 59, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(25, '35', 1, 1, 1)
(58, '35', 1, 1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, 1 AS CONTACT_CNT, CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED_CONTACTS_CNT FROM CONTACTS) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, SUM(CONTACT_CNT) AS CONTACTS_CNT, SUM(TRUSTED_CONTACTS_CNT) AS TRUSTED_CONTACTS_CNT FROM CTE GROUP BY USER_ID) AS T ON INVOICES.USER_ID = T.USER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(25, '35', 1, 1, 0)
(58, '35', 1, 1, 0)
*/