-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_15f6fb', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_15f6fb', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_f9e658', 'b_s_5167ef');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_f9e658', 'b_s_5167ef');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_5d93da', 'b_s_c2a2a5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'a_s_15f6fb', 1, 3, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, A.CUSTOMER_NAME, I.PRICE, A.CONTACTS_CNT, A.TRUSTED_CONTACTS_CNT FROM (SELECT C1.CUSTOMER_ID, C1.CUSTOMER_NAME, SUM(CASE WHEN C2.CONTACT_EMAIL IS NULL THEN 0 ELSE 1 END) AS CONTACTS_CNT, COALESCE(SUM(TRUSTED_CONTACTS), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C1 LEFT JOIN (SELECT *, CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED_CONTACTS FROM CONTACTS) AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY 1, 2) AS A JOIN INVOICES AS I ON I.USER_ID = A.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST;

/*
Prediction Result:
(1, 'a_s_15f6fb', 1, 4, 0)
*/