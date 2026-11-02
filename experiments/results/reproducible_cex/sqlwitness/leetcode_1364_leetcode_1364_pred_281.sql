-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, 'default1', 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, 0, 2), (0, NULL, NULL), (1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default1', 2, 0, 0)
(0, None, None, None, None)
(1, 'default1', None, 0, 0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT USER_ID, COUNT(CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C INNER JOIN CUSTOMERS AS O ON C.CONTACT_NAME = O.CUSTOMER_NAME AND C.CONTACT_EMAIL = O.EMAIL GROUP BY USER_ID), CTE2 AS (SELECT INVOICE_ID, COUNT(C.USER_ID) AS CONTACTS_CNT FROM INVOICES AS I INNER JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID GROUP BY INVOICE_ID) SELECT I.INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CTE2 ON I.INVOICE_ID = CTE2.INVOICE_ID LEFT JOIN CTE1 ON CTE1.USER_ID = I.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'default1', 2, 0, 0)
(0, None, None, 0, 0)
(1, 'default1', None, 0, 0)
*/