-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'SameName', 'c1@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'SameName', 'c2@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'c2@example.com', 'SameName');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'other1@example.com', 'Other1');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (2, 'other2@example.com', 'Other2');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (101, 1, 50);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (102, 2, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(101, 'SameName', 50, 2, 1)
(102, 'SameName', 75, 1, 0)
*/

-- Prediction Query
WITH CONTACTS_NEW AS (SELECT *, CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED FROM CONTACTS), CONTACT_AGG AS (SELECT U.CUSTOMER_NAME, COUNT(C.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(C.TRUSTED) AS TRUSTED_CONTACTS_CNT FROM CONTACTS_NEW AS C LEFT JOIN CUSTOMERS AS U ON C.USER_ID = U.CUSTOMER_ID GROUP BY U.CUSTOMER_NAME) SELECT I.INVOICE_ID, U.CUSTOMER_NAME, I.PRICE, COALESCE(C.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS U ON I.USER_ID = U.CUSTOMER_ID LEFT JOIN CONTACT_AGG AS C ON C.CUSTOMER_NAME = U.CUSTOMER_NAME ORDER BY 1, I.invoice_id NULLS LAST, U.customer_id NULLS LAST;

/*
Prediction Result:
(101, 'SameName', 50, 3, 1)
(102, 'SameName', 75, 3, 1)
*/