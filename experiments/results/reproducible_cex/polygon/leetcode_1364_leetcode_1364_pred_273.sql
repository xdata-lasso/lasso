-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (26, NULL, '34');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (36, NULL, '38');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (26, '38', '35');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (61, 26, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(61, None, 1, 1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, COUNT(*) AS CT, SUM(CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED FROM CONTACTS GROUP BY USER_ID) SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE, COALESCE(CTE.CT, 0) AS CONTACTS_CNT, COALESCE(CTE.TRUSTED, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CTE ON I.USER_ID = CTE.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, CU.customer_id NULLS LAST;

/*
Prediction Result:
(61, None, 1, 1, 0)
*/