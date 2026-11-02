-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'alice@example.com', NULL);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 0, 1)
*/

-- Prediction Query
WITH T1 AS (SELECT I.INVOICE_ID, C.CUSTOMER_NAME, C.CUSTOMER_ID, I.PRICE FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID), T2 AS (SELECT C.CUSTOMER_ID, COUNT(T.CONTACT_NAME) AS CONTACTS_CNT FROM CUSTOMERS AS C INNER JOIN CONTACTS AS T ON C.CUSTOMER_ID = T.USER_ID GROUP BY C.CUSTOMER_ID), T3 AS (SELECT C.CUSTOMER_ID, COUNT(T.CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C INNER JOIN CONTACTS AS T ON C.CUSTOMER_ID = T.USER_ID WHERE T.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) GROUP BY C.CUSTOMER_ID) SELECT T1.INVOICE_ID, T1.CUSTOMER_NAME, T1.PRICE, COALESCE(T2.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(T3.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM T1 LEFT JOIN T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID LEFT JOIN T3 ON T1.CUSTOMER_ID = T3.CUSTOMER_ID ORDER BY T1.INVOICE_ID, T1.CUSTOMER_NAME NULLS LAST, T1.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 0, 0)
*/