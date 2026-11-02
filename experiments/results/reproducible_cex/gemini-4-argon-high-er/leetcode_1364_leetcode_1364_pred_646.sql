-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'a@b.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Bob', 'a@b.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'a@b.com', 'Bob');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 10, 1, 1)
*/

-- Prediction Query
WITH TRUSTED_CONTACTS AS (SELECT C.USER_ID, (S.EMAIL IS NULL) AS TRUSTED FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS S ON C.CONTACT_EMAIL = S.EMAIL) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, SUM(IIF(T.USER_ID IS NULL, 0, 1)) AS CONTACTS_CNT, SUM(IIF(NOT T.TRUSTED IS NULL AND T.TRUSTED = 0, 1, 0)) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN TRUSTED_CONTACTS AS T ON C.CUSTOMER_ID = T.USER_ID GROUP BY I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 10, 2, 2)
*/