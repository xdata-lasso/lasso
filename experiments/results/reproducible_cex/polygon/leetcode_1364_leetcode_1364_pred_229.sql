-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (37, NULL, '39');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (51, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (59, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(51, None, 1, None, None)
(59, None, 1, None, None)
*/

-- Prediction Query
WITH A AS (SELECT USER_ID, COUNT(CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CO.CONTACT_NAME = CU.CUSTOMER_NAME AND CO.CONTACT_EMAIL = CU.EMAIL GROUP BY USER_ID), B AS (SELECT USER_ID, COUNT(USER_ID) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = I.USER_ID LEFT JOIN A ON A.USER_ID = I.USER_ID LEFT JOIN B ON B.USER_ID = I.USER_ID ORDER BY INVOICE_ID, CU.customer_id NULLS LAST;

/*
Prediction Result:
(51, None, 1, 0, 0)
(59, None, 1, 0, 0)
*/