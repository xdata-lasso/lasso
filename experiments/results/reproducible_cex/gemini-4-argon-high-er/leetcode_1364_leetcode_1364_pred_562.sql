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
WITH CTE1 AS (SELECT CUST.CUSTOMER_ID, CUST.CUSTOMER_NAME, COUNT(DISTINCT CON.CONTACT_NAME) AS CONTACTS_CNT FROM CUSTOMERS AS CUST LEFT JOIN CONTACTS AS CON ON CUST.CUSTOMER_ID = CON.USER_ID GROUP BY CUST.CUSTOMER_NAME), CTE2 AS (SELECT CUST.CUSTOMER_ID, CUST.CUSTOMER_NAME, COUNT(DISTINCT CON.CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CUST LEFT JOIN CONTACTS AS CON ON CUST.CUSTOMER_ID = CON.USER_ID WHERE CON.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY CUST.CUSTOMER_NAME) SELECT I.INVOICE_ID, CTE1.CUSTOMER_NAME, I.PRICE, CTE1.CONTACTS_CNT, COALESCE(CTE2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CTE1 ON I.USER_ID = CTE1.CUSTOMER_ID LEFT JOIN CTE2 ON I.USER_ID = CTE2.CUSTOMER_ID GROUP BY 1 ORDER BY 1, I.INVOICE_ID NULLS LAST, CTE1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CTE1.CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/