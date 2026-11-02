-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (26, '70', '34');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (27, NULL, '38');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '34', '35');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (26, '34', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (69, 26, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (57, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(57, None, None, None, None)
(69, '70', 1, 0, 1)
*/

-- Prediction Query
WITH C1 AS (SELECT USER_ID, CONTACT_NAME, CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL AS CONTACT_EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END AS STATUS FROM CONTACTS), C2 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CNT, SUM(STATUS) AS TRUST_CNT FROM C1 GROUP BY USER_ID) SELECT INVOICE_ID, C.CUSTOMER_NAME, PRICE, COALESCE(CNT, 0) AS CONTACTS_CNT, COALESCE(TRUST_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN C2 ON C2.USER_ID = C.CUSTOMER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(57, None, None, 0, 0)
(69, '70', 1, 0, 1)
*/