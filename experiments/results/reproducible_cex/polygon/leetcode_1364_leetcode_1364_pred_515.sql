-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, '37', '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (61, '40', '41');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (61, '38', '37');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (28, '38', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 61, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (29, 28, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(29, '37', 1, 0, 1)
(30, '40', 1, 1, 1)
*/

-- Prediction Query
WITH A AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), B AS (SELECT C1.USER_ID, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C1 JOIN CUSTOMERS AS C2 ON C1.CONTACT_NAME = C2.CUSTOMER_NAME AND C1.CONTACT_EMAIL = C2.EMAIL GROUP BY 1) SELECT INVOICES.INVOICE_ID, CUSTOMERS.CUSTOMER_NAME, INVOICES.PRICE, CASE WHEN CONTACTS_CNT IS NULL THEN 0 ELSE CONTACTS_CNT END AS CONTACTS_CNT, CASE WHEN TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE TRUSTED_CONTACTS_CNT END AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN A ON INVOICES.USER_ID = A.USER_ID LEFT JOIN B ON INVOICES.USER_ID = B.USER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(29, '37', 1, 1, 0)
(30, '40', 1, 1, 1)
*/