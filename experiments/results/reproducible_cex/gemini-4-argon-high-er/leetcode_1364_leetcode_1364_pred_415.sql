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
WITH T1 AS (SELECT A.INVOICE_ID, A.USER_ID, B.CUSTOMER_NAME, A.PRICE, COUNT(C.USER_ID) AS CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON A.USER_ID = C.USER_ID GROUP BY A.INVOICE_ID, B.CUSTOMER_NAME), T2 AS (SELECT A.USER_ID, COUNT(B.CUSTOMER_NAME) AS CNT FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_NAME = B.CUSTOMER_NAME GROUP BY A.USER_ID) SELECT T1.INVOICE_ID, T1.CUSTOMER_NAME, T1.PRICE, T1.CONTACTS_CNT, COALESCE(T2.CNT, 0) AS TRUSTED_CONTACTS_CNT FROM T1 LEFT JOIN T2 ON T1.USER_ID = T2.USER_ID ORDER BY 1, T1.INVOICE_ID NULLS LAST, T1.CUSTOMER_NAME NULLS LAST, T1.PRICE NULLS LAST, T1.CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/