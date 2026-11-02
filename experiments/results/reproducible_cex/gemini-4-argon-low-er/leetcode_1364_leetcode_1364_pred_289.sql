-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'dup@example.com');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (2, 'Bob', 'dup@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'dup@example.com', 'Contact1');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (10, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(10, 'Alice', 100, 1, 1)
*/

-- Prediction Query
WITH CUSTOMERGROUP AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, COUNT(B.USER_ID) AS CONTACTS_CNT, COALESCE(C.COUNTUSER_ID, 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID LEFT JOIN (SELECT USER_ID AS VERIFIEDUSER, COUNT(USER_ID) AS COUNTUSER_ID FROM CONTACTS AS A INNER JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY USER_ID) AS C ON A.CUSTOMER_ID = C.VERIFIEDUSER GROUP BY A.CUSTOMER_ID, A.CUSTOMER_NAME) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, B.CONTACTS_CNT, B.TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERGROUP AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY A.INVOICE_ID;

/*
Prediction Result:
(10, 'Alice', 100, 1, 2)
*/