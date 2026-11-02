-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Bob', 'bob@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (3, 'Charlie', 'charlie@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'bob@example.com', NULL);
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'charlie@example.com', 'Charlie');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (2, 'untrusted@example.com', 'Bob');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (3, 'untrusted1@example.com', 'DupName');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (3, 'untrusted2@example.com', 'DupName');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 10);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (2, 2, 20);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (3, 3, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 10, 1, 2)
(2, 'Bob', 20, 1, 0)
(3, 'Charlie', 30, 2, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, C.CONTACTS_CNT, C.TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN (SELECT CUS.CUSTOMER_ID, CUS.CUSTOMER_NAME, COUNT(CONT.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN CONT.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CUS LEFT JOIN CONTACTS AS CONT ON CUS.CUSTOMER_ID = CONT.USER_ID GROUP BY CUS.CUSTOMER_ID) AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID;

/*
Prediction Result:
(1, 'Alice', 10, 2, 2)
(2, 'Bob', 20, 1, 0)
(3, 'Charlie', 30, 2, 0)
*/