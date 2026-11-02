-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (66, '36', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (75, '39', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (66, '28', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (62, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (29, 75, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(29, '39', 1, 0, 0)
(62, None, 1, None, None)
*/

-- Prediction Query
WITH CTE1 AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS CT FROM CONTACTS GROUP BY USER_ID), CTE2 AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS TRUSTED_CT FROM CONTACTS JOIN CUSTOMERS ON EMAIL = CONTACT_EMAIL GROUP BY USER_ID), CTE3 AS (SELECT M.CUSTOMER_ID, CUSTOMER_NAME, COALESCE(C1.CT, 0) AS CT, COALESCE(C2.TRUSTED_CT, 0) AS TRUSTED_CT FROM CUSTOMERS AS M LEFT JOIN CTE1 AS C1 ON M.CUSTOMER_ID = C1.USER_ID LEFT JOIN CTE2 AS C2 ON M.CUSTOMER_ID = C2.USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CT AS CONTACTS_CNT, TRUSTED_CT AS TRUSTED_CONTACTS_CNT FROM INVOICES JOIN CTE3 ON USER_ID = CUSTOMER_ID ORDER BY 1, INVOICES.invoice_id NULLS LAST;

/*
Prediction Result:
(29, '39', 1, 0, 0)
*/