-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'bob1@example.com', 'Bob');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'bob2@example.com', 'Bob');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 2, 0)
*/

-- Prediction Query
SELECT T1.INVOICE_ID, T1.CUSTOMER_NAME, T1.PRICE, COALESCE(T2.CNT, 0) AS CONTACTS_CNT, COALESCE(T3.CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT I.INVOICE_ID, C.CUSTOMER_ID, C.CUSTOMER_NAME, I.PRICE FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID) AS T1 LEFT JOIN (SELECT CUS.CUSTOMER_NAME, COUNT(DISTINCT CON.CONTACT_NAME) AS CNT FROM CUSTOMERS AS CUS LEFT JOIN CONTACTS AS CON ON CON.USER_ID = CUS.CUSTOMER_ID GROUP BY CUS.CUSTOMER_ID) AS T2 ON T1.CUSTOMER_NAME = T2.CUSTOMER_NAME LEFT JOIN (SELECT CON.USER_ID, COUNT(CUS.CUSTOMER_ID) AS CNT FROM CONTACTS AS CON LEFT JOIN CUSTOMERS AS CUS ON CON.CONTACT_EMAIL = CUS.EMAIL GROUP BY CON.USER_ID) AS T3 ON T1.CUSTOMER_ID = T3.USER_ID ORDER BY T1.INVOICE_ID ASC, T1.CUSTOMER_NAME NULLS LAST, T1.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/