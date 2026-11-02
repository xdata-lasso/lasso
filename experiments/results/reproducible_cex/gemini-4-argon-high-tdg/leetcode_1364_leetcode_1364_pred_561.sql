-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Grace', 'grace@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'Heidi', NULL);
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'grace@example.com', NULL);
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'external@example.com', 'External');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (20, NULL, 90);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (10, 1, 120);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (15, 2, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(10, 'Grace', 120, 1, 1)
(15, 'Heidi', 80, 0, 0)
(20, None, 90, None, None)
*/

-- Prediction Query
WITH COMBINED AS (SELECT C1.CUSTOMER_ID, C1.CUSTOMER_NAME, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN C2.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C1 LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY C1.CUSTOMER_ID, C1.CUSTOMER_NAME) SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN C2.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(10, 'Grace', 120, 1, 1)
(15, 'Heidi', 80, 0, 0)
*/