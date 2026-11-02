-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'dup@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Bob', 'dup@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'dup@example.com', 'Friend');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (100, 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(100, 'Alice', 50, 1, 1)
*/

-- Prediction Query
WITH TEMP2 AS (SELECT CONTACTS.USER_ID, COUNT(CUSTOMERS.EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS JOIN CUSTOMERS ON CONTACTS.CONTACT_EMAIL = CUSTOMERS.EMAIL GROUP BY 1) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(TEMP1.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TEMP2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1) AS TEMP1 ON I.USER_ID = TEMP1.USER_ID LEFT JOIN TEMP2 ON I.USER_ID = TEMP2.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(100, 'Alice', 50, 1, 2)
*/