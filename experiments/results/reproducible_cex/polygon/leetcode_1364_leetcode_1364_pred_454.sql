-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '36', '37');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '37', '36');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (60, NULL, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (67, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(60, None, None, None, None)
(67, None, None, None, None)
*/

-- Prediction Query
WITH CTE1 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID), CTE2 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS WHERE (CONTACT_NAME, CONTACT_EMAIL) IN (SELECT CUSTOMER_NAME, EMAIL FROM CUSTOMERS) GROUP BY USER_ID) SELECT I.INVOICE_ID, CUS.CUSTOMER_NAME, I.PRICE, COALESCE(CTE1.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(CTE2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CUS ON I.USER_ID = CUS.CUSTOMER_ID LEFT JOIN CTE1 ON I.USER_ID = CTE1.USER_ID LEFT JOIN CTE2 ON I.USER_ID = CTE2.USER_ID ORDER BY I.INVOICE_ID, CUS.customer_id NULLS LAST;

/*
Prediction Result:
(60, None, None, 0, 0)
(67, None, None, 0, 0)
*/