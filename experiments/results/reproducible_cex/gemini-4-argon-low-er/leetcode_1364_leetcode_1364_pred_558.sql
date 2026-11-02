-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'alice@example.com', 'NotAlice');
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
WITH CTE AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, COUNT(B.USER_ID) AS CONTACTS_CNT, SUM(CASE WHEN B.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID GROUP BY 1, 2) SELECT C.INVOICE_ID, D.CUSTOMER_NAME, C.PRICE, D.CONTACTS_CNT, D.TRUSTED_CONTACTS_CNT FROM INVOICES AS C JOIN CTE AS D ON C.USER_ID = D.CUSTOMER_ID ORDER BY C.INVOICE_ID;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/