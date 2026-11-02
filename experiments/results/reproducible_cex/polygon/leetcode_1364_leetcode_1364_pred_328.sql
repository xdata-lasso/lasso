-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (70, '71', '72');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (31, '41', '42');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '30', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '72', '40');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (32, 31, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (64, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(32, '41', None, 1, 1)
(64, None, 1, None, None)
*/

-- Prediction Query
WITH U AS (SELECT T.CUSTOMER_ID, T.CUSTOMER_NAME, COUNT(T.CONTACT_NAME) AS CONTACTS_CNT, SUM(IIF(T.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS), 1, 0)) AS TRUSTED_CONTACTS_CNT FROM (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, C.EMAIL, C1.CONTACT_NAME, C1.CONTACT_EMAIL FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS C1 ON C.CUSTOMER_ID = C1.USER_ID) AS T GROUP BY T.CUSTOMER_ID, T.CUSTOMER_NAME) SELECT I.INVOICE_ID, U.CUSTOMER_NAME, I.PRICE, U.CONTACTS_CNT, U.TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN U ON I.USER_ID = U.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(32, '41', None, 1, 1)
*/