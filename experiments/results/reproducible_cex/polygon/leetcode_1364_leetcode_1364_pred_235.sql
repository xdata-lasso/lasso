-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (34, '41', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (54, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(54, None, 1, None, None)
*/

-- Prediction Query
WITH CNT AS (SELECT C.CUSTOMER_NAME, C.CUSTOMER_ID, COUNT(CN.USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CN ON C.CUSTOMER_ID = CN.USER_ID GROUP BY C.CUSTOMER_ID), TRUST AS (SELECT C.CUSTOMER_NAME, C.CUSTOMER_ID, COUNT(CN.CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CN ON C.CUSTOMER_ID = CN.USER_ID WHERE CN.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY C.CUSTOMER_ID) SELECT I.INVOICE_ID, CNT.CUSTOMER_NAME, I.PRICE, COALESCE(CNT.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUST.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CNT ON I.USER_ID = CNT.CUSTOMER_ID LEFT JOIN TRUST ON I.USER_ID = TRUST.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(54, None, 1, 0, 0)
*/