-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1001, 'Allison Hill', 'donaldgarcia@example.net');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1005, 'Allison Hill', 'donaldgarcia@example.net');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1001, 'garzaanthony@example.org', 'Allison Hill');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1001, 'jesseguzman@example.net', 'Allison Hill');
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1002, 1001, 1003);
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1006, NULL, 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1002, 'Allison Hill', 1003, 2, 0)
(1006, None, 1003, None, None)
*/

-- Prediction Query
WITH CONT AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTS FROM CONTACTS GROUP BY 1), TRUST_CONT AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUST_CONTS FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY 1), APPEND_CONT AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, COALESCE(B.CONTS, 0) AS CONTACTS_CNT, COALESCE(C.TRUST_CONTS, 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONT AS B ON A.CUSTOMER_ID = B.USER_ID LEFT JOIN TRUST_CONT AS C ON A.CUSTOMER_ID = C.USER_ID) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, B.CONTACTS_CNT, B.TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN APPEND_CONT AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY 1, A.invoice_id NULLS LAST;

/*
Prediction Result:
(1002, 'Allison Hill', 1003, 2, 2)
(1006, None, 1003, None, None)
*/