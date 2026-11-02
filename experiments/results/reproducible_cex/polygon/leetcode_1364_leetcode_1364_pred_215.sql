-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (71, '72', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (32, '45', '46');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (32, '33', '43');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (32, '46', '44');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (35, 32, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (34, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(34, None, 1, None, None)
(35, '45', 1, 2, 1)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT, SUM(IIF(CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS), 1, 0)) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C2 LEFT JOIN CONTACTS AS C1 ON C1.USER_ID = C2.CUSTOMER_ID JOIN INVOICES AS I ON I.USER_ID = C2.CUSTOMER_ID GROUP BY INVOICE_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(35, '45', 1, 2, 1)
*/