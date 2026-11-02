-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name, email) VALUES (10, 'Sam', 'sam10@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20, 'Sam', 'sam20@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (30, 'Diana', 'diana@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (10, 'diana@example.com', 'DifferentName');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (10, 'not_in_customers@example.com', 'Diana');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (20, 'unknown@example.com', 'Stranger');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (2, 10, 150);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 20, 250);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (3, 30, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Sam', 250, 1, 0)
(2, 'Sam', 150, 2, 1)
(3, 'Diana', 50, 0, 0)
*/

-- Prediction Query
WITH TEMP AS (SELECT USER_ID, COUNT(*) AS CNT FROM CONTACTS GROUP BY USER_ID), TEMP2 AS (SELECT INVOICE_ID, PRICE, I.USER_ID, COALESCE(CNT, 0) AS CNT FROM INVOICES AS I LEFT JOIN TEMP AS T ON I.USER_ID = T.USER_ID), F AS (SELECT TEMP2.INVOICE_ID, C.CUSTOMER_NAME, TEMP2.PRICE, TEMP2.CNT AS CONTACTS_CNT FROM TEMP2 JOIN CUSTOMERS AS C ON TEMP2.USER_ID = C.CUSTOMER_ID), TIR AS (SELECT CUSTOMER_NAME, CONTACT_NAME FROM CUSTOMERS AS C1 JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID), TIRR AS (SELECT TIR.CUSTOMER_NAME AS TIRCNAME, CUSTOMERS.CUSTOMER_NAME AS CCNAME, TIR.CONTACT_NAME FROM CUSTOMERS JOIN TIR ON CUSTOMERS.CUSTOMER_NAME = TIR.CONTACT_NAME), T AS (SELECT TIRR.TIRCNAME, COUNT(*) AS CNT2 FROM TIRR GROUP BY TIRR.TIRCNAME) SELECT F.INVOICE_ID, F.CUSTOMER_NAME, F.PRICE, F.CONTACTS_CNT, COALESCE(T.CNT2, 0) AS TRUSTED_CONTACTS_CNT FROM F LEFT JOIN T ON F.CUSTOMER_NAME = T.TIRCNAME ORDER BY F.INVOICE_ID, F.CUSTOMER_NAME NULLS LAST, F.PRICE NULLS LAST, F.CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Sam', 250, 1, 1)
(2, 'Sam', 150, 2, 1)
(3, 'Diana', 50, 0, 0)
*/