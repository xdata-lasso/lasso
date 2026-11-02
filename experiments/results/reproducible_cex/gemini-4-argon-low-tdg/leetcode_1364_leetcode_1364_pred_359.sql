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
WITH CTE AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, CT.CONTACT_NAME, C2.CUSTOMER_ID AS ID FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CT ON C.CUSTOMER_ID = CT.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CT.CONTACT_NAME = C2.CUSTOMER_NAME), CTE2 AS (SELECT I.*, C.* FROM INVOICES AS I LEFT JOIN CTE AS C ON I.USER_ID = C.CUSTOMER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(CONTACT_NAME) AS CONTACTS_CNT, COUNT(ID) AS TRUSTED_CONTACTS_CNT FROM CTE2 GROUP BY INVOICE_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(101, 'SameName', 50, 3, 2)
(102, 'SameName', 75, 1, 0)
*/