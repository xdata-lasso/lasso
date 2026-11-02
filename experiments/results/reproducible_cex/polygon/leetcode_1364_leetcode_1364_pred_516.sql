-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (31, '40', '41');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (74, '75', '72');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '72', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (32, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(32, None, None, None, None)
*/

-- Prediction Query
SELECT DISTINCT INVOICE_ID, CUSTOMER_NAME AS CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COUNT(CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT USER_ID, COUNT(DISTINCT CONTACT_EMAIL) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) AS C ON I.USER_ID = C.USER_ID LEFT JOIN (SELECT CU.CUSTOMER_ID, CUSTOMER_NAME, CONTACT_EMAIL FROM CUSTOMERS AS CU LEFT JOIN (SELECT USER_ID, CONTACT_EMAIL FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS)) AS CC ON CU.CUSTOMER_ID = CC.USER_ID) AS B ON B.CUSTOMER_ID = I.USER_ID GROUP BY INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(32, None, None, 0, 0)
*/