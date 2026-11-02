-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'dup@test.com');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (2, 'Bob', 'dup@test.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'dup@test.com', 'Contact1');
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
WITH CTE AS (SELECT CUST1.CUSTOMER_ID, CUST1.CUSTOMER_NAME, CUST1.CONTACT_NAME, CUST1.CONTACT_EMAIL FROM (SELECT CUST.CUSTOMER_ID, CUST.CUSTOMER_NAME, C.CONTACT_NAME, C.CONTACT_EMAIL FROM CUSTOMERS AS CUST LEFT JOIN CONTACTS AS C ON CUST.CUSTOMER_ID = C.USER_ID) AS CUST1) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, TEMP.CONTACTS_CNT, TEMP.TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN (SELECT A.CUSTOMER_ID, COUNT(A.CONTACT_NAME) AS CONTACTS_CNT, COUNT(B.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM CTE AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY A.CUSTOMER_ID) AS TEMP ON I.USER_ID = TEMP.CUSTOMER_ID INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(10, 'Alice', 100, 2, 2)
*/