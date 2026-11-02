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
SELECT I1.INVOICE_ID, C1.CUSTOMER_NAME AS CUSTOMER_NAME, I1.PRICE, CASE WHEN B.CONTACTS_CNT IS NULL THEN 0 ELSE B.CONTACTS_CNT END AS CONTACTS_CNT, CASE WHEN B.TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE B.TRUSTED_CONTACTS_CNT END AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I1 LEFT JOIN CUSTOMERS AS C1 ON I1.USER_ID = C1.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, COUNT(1) AS CONTACTS_CNT, SUM(CASE WHEN NOT CUSTOMER_ID IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM (SELECT C2.USER_ID, C3.CUSTOMER_ID FROM CONTACTS AS C2 LEFT JOIN CUSTOMERS AS C3 ON C2.CONTACT_NAME = C3.CUSTOMER_NAME AND C2.CONTACT_EMAIL = C3.EMAIL) AS A GROUP BY USER_ID) AS B ON I1.USER_ID = B.USER_ID ORDER BY I1.INVOICE_ID ASC, C1.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'Sam', 250, 1, 0)
(2, 'Sam', 150, 2, 0)
(3, 'Diana', 50, 0, 0)
*/