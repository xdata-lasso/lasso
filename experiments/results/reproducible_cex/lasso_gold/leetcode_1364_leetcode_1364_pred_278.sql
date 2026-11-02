-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1001, 'Allison Hill', 'donaldgarcia@example.net');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1002, 'Angie Henderson', 'davisjesse@example.net');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1005, 'Angie Henderson', 'davisjesse@example.net');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1001, 'hoffmanjennifer@example.net', '+1-763-679-4026');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1001, 'jasongallagher@example.org', '+1-763-679-4026');
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1003, 1001, 1004);
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1006, NULL, 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1003, 'Allison Hill', 1004, 2, 0)
(1006, None, 1004, None, None)
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID, COUNT(USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS A JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID GROUP BY CUSTOMER_ID), CTE2 AS (SELECT USER_ID, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS A JOIN CUSTOMERS AS B ON A.CONTACT_NAME = B.CUSTOMER_NAME GROUP BY USER_ID) SELECT INV.INVOICE_ID, CUST.CUSTOMER_NAME, INV.PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INV JOIN CUSTOMERS AS CUST ON INV.USER_ID = CUST.CUSTOMER_ID LEFT JOIN CTE1 ON CUST.CUSTOMER_ID = CTE1.CUSTOMER_ID LEFT JOIN CTE2 ON CTE1.CUSTOMER_ID = CTE2.USER_ID ORDER BY INV.INVOICE_ID, CUST.customer_id NULLS LAST;

/*
Prediction Result:
(1003, 'Allison Hill', 1004, 2, 0)
*/