-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (62, '37', '29');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, '40', '29');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (28, '29', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (62, '29', '39');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (63, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 62, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, '37', 1, 1, 1)
(63, None, 1, None, None)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE, COUNT(LIST.C_EMAIL) AS CONTACTS_CNT, COUNT(LIST.TRUSTED_EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT CO.USER_ID AS CONTACT_ID, CO.CONTACT_EMAIL AS C_EMAIL, CU.EMAIL AS TRUSTED_EMAIL FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CU.EMAIL = CO.CONTACT_EMAIL) AS LIST ON I.USER_ID = LIST.CONTACT_ID LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID GROUP BY I.INVOICE_ID ORDER BY I.INVOICE_ID ASC, CU.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(30, '37', 1, 2, 2)
(63, None, 1, 0, 0)
*/