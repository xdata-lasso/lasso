-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_85ebb3', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_85ebb3', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, NULL, 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cus_8d1b6b', 'co__013d95');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_8d1b6b', 'co__013d95');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__013d95', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '!', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'co__013d95', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'co__013d95', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'co__013d95', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '!', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'Y', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'co__013d95', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '1', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, -1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 2, 1)
(0, 'c_s_85ebb3', 1, 5, 1)
(1, 'c_s_85ebb3', 1, 2, 1)
(2, 'c_s_85ebb3', 1, 2, 1)
*/

-- Prediction Query
WITH TRUSTED_CON AS (SELECT CO.USER_ID, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CO JOIN CUSTOMERS AS CU ON CO.CONTACT_EMAIL = CU.EMAIL GROUP BY 1), CON AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1) SELECT INVOICE_ID, C.CUSTOMER_NAME, PRICE, COALESCE(CON.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CON.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CON ON I.USER_ID = CON.USER_ID LEFT JOIN TRUSTED_CON ON I.USER_ID = TRUSTED_CON.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 2, 28)
(0, 'c_s_85ebb3', 1, 5, 28)
(1, 'c_s_85ebb3', 1, 2, 28)
(2, 'c_s_85ebb3', 1, 2, 28)
*/