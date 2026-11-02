-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_2d2766', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'c_s_2d2766', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_2d2766', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'con_98c6ca', 'con_11cded');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'con_98c6ca', 'con_11cded');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'con_98c6ca', 'con_11cded');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (17, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_db73fc', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_db73fc', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_db73fc', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '?', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '?', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'con_e8dae1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_11cded', 'con_98c6ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (14, 'con_11cded', 'con_98c6ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (20, 'con_11cded', 'con_98c6ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'con_de12a6', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 7, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, 9, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (12, 14, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (15, 10, 700293388);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (18, 20, 906324270);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (21, 1, 2122220075);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'c_s_2d2766', 1, 1, 0)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(8, 'cus_8d1b6b', 1744686505, 0, 0)
(12, 'cus_8d1b6b', 1115440883, 1, 1)
(15, 'cus_8d1b6b', 700293388, 1, 0)
(18, 'cus_8d1b6b', 906324270, 1, 1)
(21, 'c_s_2d2766', 2122220075, 1, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(CON.USER_ID) AS CONTACTS_CNT, COUNT(C2.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN CONTACTS AS CON ON CON.USER_ID = C.CUSTOMER_ID LEFT JOIN CUSTOMERS AS C2 ON C2.EMAIL = CON.CONTACT_EMAIL AND C2.CUSTOMER_NAME = CON.CONTACT_NAME GROUP BY I.INVOICE_ID ORDER BY I.INVOICE_ID, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'c_s_2d2766', 1, 1, 0)
(6, 'cus_8d1b6b', 247012447, 3, 3)
(8, 'cus_8d1b6b', 1744686505, 0, 0)
(12, 'cus_8d1b6b', 1115440883, 3, 3)
(15, 'cus_8d1b6b', 700293388, 1, 0)
(18, 'cus_8d1b6b', 906324270, 3, 3)
(21, 'c_s_2d2766', 2122220075, 1, 0)
*/