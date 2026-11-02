-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (37, '49', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (77, '50', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (37, '39', '50');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (77, '38', '49');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (40, NULL, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (76, 77, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(40, None, None, None, None)
(76, '50', 1, 1, 0)
*/

-- Prediction Query
WITH TEMP AS (SELECT C.CUSTOMER_NAME, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS ON C.CUSTOMER_ID = CONTACTS.USER_ID WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY C.CUSTOMER_ID), TEMP2 AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT FROM CUSTOMERS AS C JOIN CONTACTS ON C.CUSTOMER_ID = CONTACTS.USER_ID GROUP BY USER_ID) SELECT DISTINCT INVOICE_ID, C.CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS ON CONTACTS.USER_ID = C.CUSTOMER_ID LEFT JOIN TEMP ON C.CUSTOMER_NAME = TEMP.CUSTOMER_NAME LEFT JOIN TEMP2 ON C.CUSTOMER_ID = TEMP2.USER_ID ORDER BY INVOICE_ID, C.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(40, None, None, 0, 0)
(76, '50', 1, 1, 1)
*/