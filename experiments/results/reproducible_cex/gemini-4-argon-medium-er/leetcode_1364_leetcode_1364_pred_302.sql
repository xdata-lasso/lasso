-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice1@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Alice', 'alice2@example.com');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (2, 2, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 0, 0)
(2, 'Alice', 200, 0, 0)
*/

-- Prediction Query
WITH TEM AS (SELECT USER_ID, CONTACT_NAME, CONTACT_EMAIL, CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL AS CONTACT_EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED_CONTACT FROM CONTACTS), TEM1 AS (SELECT A.*, B.* FROM CUSTOMERS AS A LEFT JOIN TEM AS B ON A.CUSTOMER_ID = B.USER_ID), TEM2 AS (SELECT USER_ID, CUSTOMER_ID, CUSTOMER_NAME, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT, SUM(TRUSTED_CONTACT) AS TRUSTED_CONTACTS_CNT FROM TEM1 GROUP BY CUSTOMER_NAME) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COALESCE(B.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(B.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN TEM2 AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(1, 'Alice', 100, 0, 0)
(2, None, 200, 0, 0)
*/