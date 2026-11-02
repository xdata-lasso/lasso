-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '39', '40');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (30, '41', '42');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '40', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '42', '39');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (32, 30, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (31, 29, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(31, '39', None, 0, 0)
(32, '41', 1, 1, 2)
*/

-- Prediction Query
WITH TMP AS (SELECT A.USER_ID AS USER_ID, A.INVOICE_ID AS INVOICE_ID, A.PRICE AS PRICE, C.CUSTOMER_NAME AS CUSTOMER_NAME, B.CONTACT_NAME AS CONTACT_NAME FROM INVOICES AS A LEFT JOIN CONTACTS AS B ON A.USER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS C ON A.USER_ID = C.CUSTOMER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM TMP GROUP BY INVOICE_ID, USER_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(31, '39', None, 0, 0)
(32, '41', 1, 1, 1)
*/