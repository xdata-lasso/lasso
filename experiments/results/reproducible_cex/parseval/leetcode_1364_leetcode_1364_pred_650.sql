-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_117a13', 'c_s_5d1e7a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'c_s_456e80');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (17, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'c_s_456e80');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (23, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'c_s_456e80');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_5d1e7a', 'c_s_0189aa');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'c_s_5d1e7a', 'D');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c_s_5d1e7a', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_1d4da6', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'c_s_456e80', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_de12a6', 'c_s_0189aa');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'c_s_0189aa');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'c_s_456e80', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'con_de12a6', 'c_s_0189aa');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'con_de12a6', 'c_s_0189aa');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (22, 'c_s_456e80', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'c_s_0189aa');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (23, 'con_de12a6', 'c_s_0189aa');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 5, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 10, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, -2147483639, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (12, 16, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (15, -2147483634, 700293388);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (18, 22, 906324270);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (21, 1, 2122220075);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 1, 1)
(0, '!', 1, 1, 0)
(1, 'cus_117a13', 1, 2, 1)
(2, 'cus_117a13', 1, 2, 1)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(9, 'cus_8d1b6b', 1744686505, 0, 0)
(12, 'cus_8d1b6b', 1115440883, 2, 1)
(15, 'cus_8d1b6b', 700293388, 0, 0)
(18, 'cus_8d1b6b', 906324270, 1, 1)
(21, 'cus_117a13', 2122220075, 2, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CUS0.CUSTOMER_NAME, I.PRICE, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(CUS.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CUS0 ON I.USER_ID = CUS0.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS CUS ON C.CONTACT_EMAIL = CUS.EMAIL GROUP BY I.INVOICE_ID, CUS0.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, CUS0.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 1, 1)
(0, '!', 1, 1, 0)
(1, 'cus_117a13', 1, 2, 1)
(2, 'cus_117a13', 1, 2, 1)
(6, 'cus_8d1b6b', 247012447, 3, 3)
(9, 'cus_8d1b6b', 1744686505, 0, 0)
(12, 'cus_8d1b6b', 1115440883, 4, 3)
(15, 'cus_8d1b6b', 700293388, 0, 0)
(18, 'cus_8d1b6b', 906324270, 3, 3)
(21, 'cus_117a13', 2122220075, 2, 1)
*/