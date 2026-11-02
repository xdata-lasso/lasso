-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (62, NULL, '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '40', '41');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (62, '41', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '38', '40');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 62, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, None, None, 0, 1)
*/

-- Prediction Query
WITH A AS (SELECT USER_ID, COALESCE(COUNT(*), 0) AS CONTACTS_ FROM CONTACTS GROUP BY USER_ID), B AS (SELECT USER_ID, COALESCE(COUNT(USER_ID), 0) AS TRUSTED FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_, 0) AS CONTACTS_CNT, COALESCE(TRUSTED, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN A ON A.USER_ID = C.CUSTOMER_ID LEFT JOIN B ON B.USER_ID = C.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(30, None, None, 1, 0)
*/