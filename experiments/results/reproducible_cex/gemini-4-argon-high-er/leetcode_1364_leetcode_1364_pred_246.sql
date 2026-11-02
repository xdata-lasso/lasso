-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'shared@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Bob', 'shared@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'shared@example.com', 'Bob');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 1, 1)
*/

-- Prediction Query
WITH CONTS AS (SELECT USER_ID, COUNT(1) AS CONTACTS_CNT, SUM(CASE WHEN CUSTOMER_NAME IS NULL THEN 0 ELSE 1 END) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CON LEFT JOIN CUSTOMERS AS CUS ON CON.CONTACT_EMAIL = CUS.EMAIL GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, I.PRICE, CASE WHEN CONTACTS_CNT IS NULL THEN 0 ELSE CONTACTS_CNT END AS CONTACTS_CNT, CASE WHEN TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE TRUSTED_CONTACTS_CNT END AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CONTS AS C ON I.USER_ID = C.USER_ID INNER JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID ORDER BY INVOICE_ID, CU.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 2, 2)
*/