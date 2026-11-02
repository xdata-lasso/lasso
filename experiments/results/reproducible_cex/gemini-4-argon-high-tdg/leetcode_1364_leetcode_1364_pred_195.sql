-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_name, email) VALUES (10, 'Sam', 'sam10@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (20, 'Sam', 'sam20@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (30, 'Diana', 'diana@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (10, 'diana@example.com', 'DifferentName');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (10, 'not_in_customers@example.com', 'Diana');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (20, 'unknown@example.com', 'Stranger');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (2, 10, 150);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 20, 250);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (3, 30, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Sam', 250, 1, 0)
(2, 'Sam', 150, 2, 1)
(3, 'Diana', 50, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, A.CONTACTS_CNT, COALESCE(B.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_NAME, COUNT(USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID GROUP BY CUSTOMER_NAME) AS A ON C.CUSTOMER_NAME = A.CUSTOMER_NAME LEFT JOIN (SELECT CUSTOMER_NAME, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY CUSTOMER_NAME) AS B ON A.CUSTOMER_NAME = B.CUSTOMER_NAME ORDER BY INVOICE_ID ASC, C.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'Sam', 250, 3, 1)
(2, 'Sam', 150, 3, 1)
(3, 'Diana', 50, 0, 0)
*/