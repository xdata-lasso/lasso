-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '39', '37');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, '39', '40');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '37', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '40', '39');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (73, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 29, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, '39', 1, 1, 2)
(73, None, 1, None, None)
*/

-- Prediction Query
WITH TMP AS (SELECT CUS.CUSTOMER_ID AS CUSTOMER_ID, CUS.CUSTOMER_NAME AS CUS_NAME, CON.CONTACT_NAME AS CONT_NAME, COST.EMAIL AS CONT_EMAIL FROM CUSTOMERS AS CUS LEFT JOIN CONTACTS AS CON ON CUS.CUSTOMER_ID = CON.USER_ID LEFT JOIN CUSTOMERS AS COST ON CON.CONTACT_NAME = COST.CUSTOMER_NAME) SELECT INVOICE_ID, TMP.CUS_NAME AS CUSTOMER_NAME, I.PRICE, COUNT(CONT_NAME) AS CONTACTS_CNT, COUNT(CONT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN TMP ON I.USER_ID = TMP.CUSTOMER_ID GROUP BY INVOICE_ID, CUS_NAME ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(30, '39', 1, 2, 2)
(73, None, 1, 0, 0)
*/