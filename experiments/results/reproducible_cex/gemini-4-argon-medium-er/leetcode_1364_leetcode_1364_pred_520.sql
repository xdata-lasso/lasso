-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'a1@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Alice', 'a2@example.com');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 0, 0)
*/

-- Prediction Query
WITH A AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID), B AS (SELECT CUSTOMER_NAME, SUM(IIF(USER_ID IS NULL, 0, 1)) AS CONTACTS_CNT FROM CUSTOMERS AS CUS LEFT JOIN CONTACTS AS CON ON CUSTOMER_ID = USER_ID GROUP BY CUSTOMER_ID), C AS (SELECT CUSTOMER_NAME, SUM(IIF(USER_ID IS NULL, 0, 1)) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CUS LEFT JOIN CONTACTS AS CON ON CUSTOMER_ID = USER_ID WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY CUSTOMER_ID) SELECT INVOICE_ID, A.CUSTOMER_NAME, PRICE, CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM A LEFT JOIN B ON A.CUSTOMER_NAME = B.CUSTOMER_NAME LEFT JOIN C ON A.CUSTOMER_NAME = C.CUSTOMER_NAME ORDER BY INVOICE_ID, A.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 0, 0)
(1, 'Alice', 100, 0, 0)
*/