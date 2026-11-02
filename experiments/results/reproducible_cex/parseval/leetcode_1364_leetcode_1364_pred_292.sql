-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cu__dae4e5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cu__dae4e5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'con_6c323e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'con_6c323e');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_6c323e', 'con_a189dd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_b2d784', 'con_f8ae23');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_6c323e', 'con_a189dd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_6c323e', 'con_a189dd');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cu__dae4e5', 1, 2, 1)
(1, 'cu__dae4e5', 1, 2, 1)
(2, 'cu__dae4e5', 1, 2, 1)
*/

-- Prediction Query
WITH CTE_JOIN_CONTACTS AS (SELECT INVOICE_ID, CU.CUSTOMER_NAME, PRICE, CONTACT_NAME, CONTACT_EMAIL FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS AS CONT ON I.USER_ID = CONT.USER_ID), CTE_CONTACTS_AGG AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT FROM CTE_JOIN_CONTACTS GROUP BY 1, 2, 3), CTE_TRUSTED_CONTACTS_AGG AS (SELECT INVOICE_ID, C1.CUSTOMER_NAME, PRICE, COUNT(CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CTE_JOIN_CONTACTS AS C1 JOIN CUSTOMERS AS C2 ON C1.CONTACT_EMAIL = C2.EMAIL GROUP BY 1, 2, 3), CTE_ASSEMBLE AS (SELECT C.INVOICE_ID, C.CUSTOMER_NAME, C.PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM CTE_CONTACTS_AGG AS C LEFT JOIN CTE_TRUSTED_CONTACTS_AGG AS TC ON C.INVOICE_ID = TC.INVOICE_ID AND C.CUSTOMER_NAME = TC.CUSTOMER_NAME ORDER BY 1, C.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, C.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST) SELECT * FROM CTE_ASSEMBLE;

/*
Prediction Result:
(-2147483647, 'cu__dae4e5', 1, 2, 25)
(1, 'cu__dae4e5', 1, 2, 25)
(2, 'cu__dae4e5', 1, 2, 25)
*/