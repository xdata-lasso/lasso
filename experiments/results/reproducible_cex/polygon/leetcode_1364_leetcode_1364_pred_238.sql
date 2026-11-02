-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (60, NULL, '37');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '39', '40');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '40', '38');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (60, '40', '39');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (62, 29, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (63, 60, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(62, '39', None, 1, 1)
(63, None, None, 1, 1)
*/

-- Prediction Query
WITH CONT_COUNT AS (SELECT USER_ID, COUNT(*) AS CT_COUNT FROM CONTACTS GROUP BY USER_ID), TRUST_CONT_COUNT AS (SELECT CT.USER_ID, COUNT(*) AS TRUST_CT_COUNT FROM CONTACTS AS CT INNER JOIN CUSTOMERS AS CM ON CT.CONTACT_NAME = CM.CUSTOMER_NAME AND CT.CONTACT_EMAIL = CM.EMAIL GROUP BY CT.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(C_CT.CT_COUNT, 0) AS CONTACTS_CNT, COALESCE(T_CT.TRUST_CT_COUNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONT_COUNT AS C_CT ON I.USER_ID = C_CT.USER_ID LEFT JOIN TRUST_CONT_COUNT AS T_CT ON I.USER_ID = T_CT.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(62, '39', None, 1, 0)
(63, None, None, 1, 1)
*/