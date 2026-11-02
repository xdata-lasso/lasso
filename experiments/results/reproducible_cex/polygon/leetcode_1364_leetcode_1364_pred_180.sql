-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, NULL, '44');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, NULL, '44');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '30', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (28, '44', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (32, 29, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (31, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(31, None, 1, None, None)
(32, None, 1, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, T.CUSTOMER_NAME, I.PRICE, T.CONTACTS_CNT, T.TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN (SELECT C1.CUSTOMER_ID, C1.CUSTOMER_NAME, COUNT(DISTINCT C.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(DISTINCT C2.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C1 LEFT JOIN CONTACTS AS C ON C1.CUSTOMER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS C2 ON C.CONTACT_EMAIL = C2.EMAIL GROUP BY C1.CUSTOMER_ID) AS T ON I.USER_ID = T.CUSTOMER_ID ORDER BY I.INVOICE_ID;

/*
Prediction Result:
(32, None, 1, 1, 0)
*/