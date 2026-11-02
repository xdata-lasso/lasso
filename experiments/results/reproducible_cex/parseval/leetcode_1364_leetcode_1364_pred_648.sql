-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cu__2b09d6', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'Q');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, '"', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'Q');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, NULL, 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'cus_8d1b6b', 'con_cd6dd0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_8d1b6b', 'con_cd6dd0');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_cd6dd0', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__8b926f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_cd6dd0', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'co__8b926f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'B', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__461da8', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cu__2b09d6', 1, 8, 1)
(0, 'cus_8d1b6b', 1, 1, 1)
(1, 'cu__2b09d6', 1, 8, 1)
(2, 'cu__2b09d6', 1, 8, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE, COUNT(CO.USER_ID) AS CONTACTS_CNT, IIF(AA.TRUSTED_CONTACTS_CNT IS NULL, 0, AA.TRUSTED_CONTACTS_CNT) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID LEFT JOIN (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS JOIN CUSTOMERS ON CONTACT_EMAIL = EMAIL GROUP BY USER_ID) AS AA ON I.USER_ID = AA.USER_ID GROUP BY I.INVOICE_ID, I.PRICE, CU.CUSTOMER_NAME ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, CU.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cu__2b09d6', 1, 8, 28)
(0, 'cus_8d1b6b', 1, 1, 28)
(1, 'cu__2b09d6', 1, 8, 28)
(2, 'cu__2b09d6', 1, 8, 28)
*/