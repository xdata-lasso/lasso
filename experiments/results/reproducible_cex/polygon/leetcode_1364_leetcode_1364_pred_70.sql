-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (77, '35', '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (68, NULL, '38');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (68, '38', '36');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (77, '63', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (26, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (25, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(25, None, 1, None, None)
(26, None, 1, None, None)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, EMAIL, COALESCE(CONTACT_COUNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED, 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS LEFT JOIN (SELECT USER_ID, SUM(CASE WHEN EMAIL IS NULL THEN 0 ELSE 1 END) AS TRUSTED, COUNT(USER_ID) AS CONTACT_COUNT FROM CONTACTS LEFT JOIN CUSTOMERS ON EMAIL = CONTACT_EMAIL GROUP BY USER_ID) AS A ON CUSTOMER_ID = USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM CTE INNER JOIN INVOICES ON CUSTOMER_ID = USER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
*/