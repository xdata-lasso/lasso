-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_8888fd', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a_s_8888fd', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_02f43e', 'b_s_740fad');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_02f43e', 'b_s_740fad');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_e19014', 'b_s_040bfd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'a_s_8888fd', 1, 0, 0)
(0, 'a_s_8888fd', 1, 0, 0)
(1, 'a_s_8888fd', 1, 3, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CASE WHEN CONTACTS_CNT IS NULL THEN 0 ELSE CONTACTS_CNT END AS CONTACTS_CNT, CASE WHEN TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE TRUSTED_CONTACTS_CNT END AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT, SUM(IS_TRUSTED) AS TRUSTED_CONTACTS_CNT FROM (SELECT *, CASE WHEN EMAIL IS NULL THEN 0 ELSE 1 END AS IS_TRUSTED FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CO.CONTACT_EMAIL = CU.EMAIL) AS CO GROUP BY USER_ID) AS TAMPA ON TAMPA.USER_ID = INVOICES.USER_ID INNER JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMER_ID ORDER BY INVOICES.INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_8888fd', 1, 0, 0)
(0, 'a_s_8888fd', 1, 0, 0)
(1, 'a_s_8888fd', 1, 4, 0)
*/