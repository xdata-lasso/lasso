-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_625716', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_625716', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_3b6516', 'b_s_3a8d02');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_3b6516', 'b_s_3a8d02');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_0d93bd', 'b_s_03a595');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483646, 'a_s_625716', 1, 0, 0)
(-2147483645, 'a_s_625716', 1, 0, 0)
(0, 'a_s_625716', 1, 0, 0)
(1, 'a_s_625716', 1, 4, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, CUSTOMER_NAME, COUNT(DISTINCT CONTACT_NAME) AS CONTACTS_CNT, SUM(TRUSTED_CONTACT) AS TRUSTED_CONTACTS_CNT FROM (SELECT USER_ID, C2.CUSTOMER_NAME, CONTACT_NAME, IIF(C3.EMAIL IS NULL, 0, 1) AS TRUSTED_CONTACT FROM CONTACTS AS C1 JOIN CUSTOMERS AS C2 ON C1.USER_ID = C2.CUSTOMER_ID LEFT JOIN CUSTOMERS AS C3 ON C1.CONTACT_EMAIL = C3.EMAIL) AS SUB GROUP BY USER_ID, CUSTOMER_NAME) SELECT INVOICE_ID, C.CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CTE ON I.USER_ID = CTE.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483646, 'a_s_625716', 1, 0, 0)
(-2147483645, 'a_s_625716', 1, 0, 0)
(0, 'a_s_625716', 1, 0, 0)
(1, 'a_s_625716', 1, 3, 0)
*/