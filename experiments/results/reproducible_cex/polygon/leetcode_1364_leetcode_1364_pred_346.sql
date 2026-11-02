-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (30, '37', '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, NULL, NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '29', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (61, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (69, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(61, None, 1, None, None)
(69, None, 1, None, None)
*/

-- Prediction Query
WITH TB1 AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(CON.CONTACT_NAME) AS CONTACTS_CNT, COUNT(C2.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CON ON C.CUSTOMER_ID = CON.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CON.CONTACT_EMAIL = C2.EMAIL GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME) SELECT I.INVOICE_ID, TB1.CUSTOMER_NAME, I.PRICE, TB1.CONTACTS_CNT, TB1.TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN TB1 ON I.USER_ID = TB1.CUSTOMER_ID ORDER BY I.INVOICE_ID;

/*
Prediction Result:
*/