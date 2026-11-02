-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_0a0077', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, '@', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'con_3232d4', 'con_018704');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'con_3232d4', 'con_018704');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_2ecdd7', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_2ecdd7', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_2ecdd7', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_2ecdd7', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_2ecdd7', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '_', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'con_e33b62');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'con_018704', 'con_3232d4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (15, 'con_018704', 'con_3232d4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_de12a6', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, 9, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, 7, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (14, 15, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (17, -2147483636, 1465859724);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'cus_0a0077', 1, 1, 0)
(2, 'cus_0a0077', 1, 1, 0)
(8, 'cus_8d1b6b', 247012447, 1, 1)
(11, 'cus_8d1b6b', 1744686505, 1, 0)
(14, 'cus_8d1b6b', 1115440883, 1, 1)
(17, 'con_3232d4', 1465859724, 0, 0)
*/

-- Prediction Query
SELECT INV.INVOICE_ID AS INVOICE_ID, CUS.CUSTOMER_NAME AS CUSTOMER_NAME, INV.PRICE AS PRICE, COUNT(CON.USER_ID) AS CONTACTS_CNT, COUNT(CUS1.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INV LEFT JOIN CUSTOMERS AS CUS ON INV.USER_ID = CUS.CUSTOMER_ID LEFT JOIN CONTACTS AS CON ON CON.USER_ID = CUS.CUSTOMER_ID LEFT JOIN CUSTOMERS AS CUS1 ON CUS1.CUSTOMER_NAME = CON.CONTACT_NAME AND CUS1.EMAIL = CON.CONTACT_EMAIL GROUP BY 1 ORDER BY 1 ASC, INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'cus_0a0077', 1, 1, 0)
(2, 'cus_0a0077', 1, 1, 0)
(8, 'cus_8d1b6b', 247012447, 2, 2)
(11, 'cus_8d1b6b', 1744686505, 1, 0)
(14, 'cus_8d1b6b', 1115440883, 2, 2)
(17, 'con_3232d4', 1465859724, 0, 0)
*/