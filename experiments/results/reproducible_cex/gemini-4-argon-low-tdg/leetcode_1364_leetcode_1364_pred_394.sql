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
WITH EMAIL_COUNT AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(CO.CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CO ON C.CUSTOMER_ID = CO.USER_ID WHERE CO.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY C.CUSTOMER_ID), COUNT_CONT AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(CO.CONTACT_EMAIL) AS CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CO ON C.CUSTOMER_ID = CO.USER_ID GROUP BY C.CUSTOMER_ID), CONTACT AS (SELECT N1.CUSTOMER_ID, N1.CUSTOMER_NAME, N1.CONTACTS_CNT, N2.TRUSTED_CONTACTS_CNT FROM COUNT_CONT AS N1 LEFT JOIN EMAIL_COUNT AS N2 ON N1.CUSTOMER_ID = N2.CUSTOMER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, C.CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CONTACT AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID;

/*
Prediction Result:
(1, 'Alice', 10, 2, 2)
(2, 'Bob', 20, 1, 0)
(3, 'Charlie', 30, 2, 0)
*/