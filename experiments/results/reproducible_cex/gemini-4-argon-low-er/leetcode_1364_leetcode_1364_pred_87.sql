-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'bob@example.com', NULL);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (10, 1, 100);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (20, NULL, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(10, 'Alice', 100, 0, 0)
(20, None, 200, None, None)
*/

-- Prediction Query
WITH CTE_CONTACTS_CNT AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_EMAIL) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID), CTE_TRUSTED_CONTACTS_CNT AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C1 WHERE C1.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY USER_ID) SELECT I.INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS ON I.USER_ID = CUSTOMER_ID LEFT JOIN CTE_CONTACTS_CNT AS CTE1 ON I.USER_ID = CTE1.USER_ID LEFT JOIN CTE_TRUSTED_CONTACTS_CNT AS CTE2 ON I.USER_ID = CTE2.USER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(10, 'Alice', 100, 1, 0)
*/