-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (41, '48', '49');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (52, '53', '54');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (41, '40', '50');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (41, '39', '51');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (104, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (109, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(104, None, 1, None, None)
(109, None, None, None, None)
*/

-- Prediction Query
WITH CONTACTS_COUNT AS (SELECT CUSTOMER_ID, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON (CU.CUSTOMER_ID = CO.USER_ID) GROUP BY 1), TRUSTED_COUNT AS (SELECT CUSTOMER_ID, SUM(CASE WHEN CO.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON (CU.CUSTOMER_ID = CO.USER_ID) GROUP BY 1) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(CC.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TC.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS_COUNT AS CC ON I.USER_ID = CC.CUSTOMER_ID LEFT JOIN TRUSTED_COUNT AS TC ON I.USER_ID = TC.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(104, None, 1, 0, 0)
(109, None, None, 0, 0)
*/