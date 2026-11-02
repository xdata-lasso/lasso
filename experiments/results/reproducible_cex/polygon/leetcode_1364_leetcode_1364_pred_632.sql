-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (39, '40', '35');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (41, '42', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (41, '25', '33');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (26, 41, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (61, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(26, '42', None, 1, 0)
(61, None, None, None, None)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(CO.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(CO.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT, SUM(CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) AS CO ON I.USER_ID = CO.USER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(26, '42', None, 1, 0)
*/