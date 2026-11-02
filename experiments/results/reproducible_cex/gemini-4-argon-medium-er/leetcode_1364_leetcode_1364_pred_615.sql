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
WITH A AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, I.USER_ID FROM INVOICES AS I JOIN CUSTOMERS AS CUS ON I.USER_ID = CUS.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST, CUS.customer_id NULLS LAST), B AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), C AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CON JOIN CUSTOMERS AS CUS ON CUS.EMAIL = CON.CONTACT_EMAIL WHERE CON.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT A.INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, COALESCE(B.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM A LEFT JOIN B ON A.USER_ID = B.USER_ID LEFT JOIN C ON B.USER_ID = C.USER_ID ORDER BY INVOICE_ID, A.INVOICE_ID NULLS LAST, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(10, 'Alice', 100, 1, 2)
*/