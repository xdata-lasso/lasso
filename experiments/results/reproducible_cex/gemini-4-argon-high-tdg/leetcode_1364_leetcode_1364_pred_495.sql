-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'UserOne', 'shared@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'UserTwo', 'shared@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (3, 'UserThree', 'unique@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (3, 'shared@example.com', 'DupContactName');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (3, 'outsider@example.com', 'DupContactName');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (10, 3, 500);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (5, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(5, 'UserOne', 100, 0, 0)
(10, 'UserThree', 500, 2, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, A.CUSTOMER_NAME, I.PRICE, A.CONTACTS_CNT, A.TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT CUST.CUSTOMER_ID, CUST.CUSTOMER_NAME, COALESCE(COUNT(CONT.USER_ID), 0) AS CONTACTS_CNT, COALESCE(COUNT(DISTINCT CUST2.EMAIL), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CUST LEFT JOIN CONTACTS AS CONT ON CUST.CUSTOMER_ID = CONT.USER_ID LEFT JOIN CUSTOMERS AS CUST2 ON CONT.CONTACT_EMAIL = CUST2.EMAIL GROUP BY 1, 2) AS A ON I.USER_ID = A.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(5, 'UserOne', 100, 0, 0)
(10, 'UserThree', 500, 3, 1)
*/