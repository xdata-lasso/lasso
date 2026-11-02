-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'shared@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Alice', 'shared@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (3, 'Bob', NULL);
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'shared@example.com', 'Self and Dup');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'nullname@example.com', NULL);
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (2, 'shared@example.com', NULL);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (5, 1, 50);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (2, 2, 75);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (9, NULL, 90);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(2, 'Alice', 75, 0, 1)
(5, 'Alice', 50, 1, 1)
(9, None, 90, None, None)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), CTE2 AS (SELECT CUSTOMER_ID, COUNT(B.CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID AND B.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS X LEFT JOIN CUSTOMERS AS Y ON X.USER_ID = Y.CUSTOMER_ID LEFT JOIN CTE AS I ON X.USER_ID = I.USER_ID LEFT JOIN CTE2 AS K ON X.USER_ID = K.CUSTOMER_ID ORDER BY INVOICE_ID, Y.customer_id NULLS LAST;

/*
Prediction Result:
(2, 'Alice', 75, 1, 1)
(5, 'Alice', 50, 2, 1)
(9, None, 90, 0, 0)
*/