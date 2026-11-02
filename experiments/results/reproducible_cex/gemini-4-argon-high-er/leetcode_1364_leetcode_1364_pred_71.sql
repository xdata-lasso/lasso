-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'alice@example.com', 'Bob');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 1, 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT CONTACTS.*, (CASE WHEN CONTACTS.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS CUST_COUNT FROM CONTACTS), CTE1A AS (SELECT USER_ID, SUM(CUST_COUNT) AS CC_COUNT FROM CTE1 GROUP BY USER_ID), CTE2 AS (SELECT USER_ID AS CUSTOMER_ID, COUNT(USER_ID) AS NUM_OF_CONTACTS FROM CONTACTS GROUP BY 1 ORDER BY 1, CUSTOMER_ID NULLS LAST, NUM_OF_CONTACTS NULLS LAST) SELECT DISTINCT I.INVOICE_ID AS INVOICE_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME, I.PRICE AS PRICE, COALESCE(CTE2.NUM_OF_CONTACTS, 0) AS CONTACTS_CNT, COALESCE(CTE1A.CC_COUNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS ON C.CUSTOMER_ID = CONTACTS.USER_ID LEFT JOIN CTE2 ON CONTACTS.USER_ID = CTE2.CUSTOMER_ID LEFT JOIN CTE1A ON CONTACTS.USER_ID = CTE1A.USER_ID ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/