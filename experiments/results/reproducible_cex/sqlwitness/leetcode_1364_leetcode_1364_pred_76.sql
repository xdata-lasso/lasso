-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (3, 'default2', 'default1'), (0, 'default1', 'default2'), (-1, 'default2', 'default2');
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, NULL, 'default1'), (3, 'default2', 'default1'), (1, NULL, NULL), (-1, 'default2', 'default2'), (2, NULL, 'default2');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, NULL, 3), (2, 2, NULL), (1, 3, 3), (0, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 3, None, None)
(0, None, 2, 0, 0)
(1, 'default2', 3, 1, 1)
(2, None, None, 0, 0)
*/

-- Prediction Query
WITH CONTACT_INFO AS (SELECT I.INVOICE_ID, I.PRICE, I.USER_ID AS USER_ID1, CO.USER_ID AS USER_ID2, CO.CONTACT_NAME FROM INVOICES AS I LEFT JOIN CONTACTS AS CO ON I.USER_ID = CO.USER_ID), TRUST_CONTACT_INFO AS (SELECT C.INVOICE_ID, C.PRICE, C.USER_ID1, C.USER_ID2, C.CONTACT_NAME, CU.CUSTOMER_NAME FROM CONTACT_INFO AS C LEFT JOIN CUSTOMERS AS CU ON C.CONTACT_NAME = CU.CUSTOMER_NAME), GROUP_TABLE AS (SELECT INVOICE_ID, USER_ID1, PRICE, SUM(CASE WHEN NOT USER_ID2 IS NULL THEN 1 ELSE 0 END) AS CONTACTS_CNT, SUM(CASE WHEN NOT CUSTOMER_NAME IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM TRUST_CONTACT_INFO GROUP BY 1, 2) SELECT G.INVOICE_ID, C.CUSTOMER_NAME, G.PRICE, G.CONTACTS_CNT, G.TRUSTED_CONTACTS_CNT FROM GROUP_TABLE AS G INNER JOIN CUSTOMERS AS C ON G.USER_ID1 = C.CUSTOMER_ID ORDER BY G.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(0, None, 2, 0, 0)
(1, 'default2', 3, 1, 0)
(2, None, None, 0, 0)
*/