-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (68, NULL, '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (64, '65', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (68, '31', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (68, '30', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (63, 64, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (66, 68, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(63, '65', 1, 0, 0)
(66, None, 1, 0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CUSTOMER_ID FROM INVOICES AS A JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = A.USER_ID), CTE1 AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, USER_ID FROM CTE LEFT JOIN (SELECT USER_ID, COUNT(USER_ID) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) AS B ON CTE.CUSTOMER_ID = B.USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUST, 0) AS TRUSTED_CONTACTS_CNT FROM CTE1 AS D LEFT JOIN (SELECT USER_ID, COUNT(USER_ID) AS TRUST FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY USER_ID) AS B ON D.USER_ID = B.USER_ID ORDER BY INVOICE_ID ASC, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(63, '65', 1, 0, 0)
(66, None, 1, 2, 0)
*/