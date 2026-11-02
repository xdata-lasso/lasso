-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (30, '37', '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '41', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '28', '39');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '38', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (64, NULL, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (63, 29, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(63, '41', 1, 0, 1)
(64, None, None, None, None)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(COUNT(CT.CONTACT_NAME), 0) AS CONTACTS_CNT, SUM(CASE WHEN CT.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS CT ON C.CUSTOMER_ID = CT.USER_ID GROUP BY C.CUSTOMER_NAME, I.INVOICE_ID, I.PRICE ORDER BY I.INVOICE_ID ASC, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(63, '41', 1, 0, 0)
(64, None, None, 0, 0)
*/