-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c1__5808bc', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, '!', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 't_s_593a6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 't_s_593a6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 't_s_593a6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (17, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (21, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 't_s_e06d1d', 't_s_68abd9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 't_s_e06d1d', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '_', 'B');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', ';');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'con_de12a6', 't_s_68abd9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 't_s_68abd9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (8, 't_s_593a6a', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (14, 'con_de12a6', 't_s_68abd9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (14, 't_s_593a6a', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (21, 'con_de12a6', 't_s_68abd9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (17, 'con_de12a6', 't_s_68abd9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (20, 't_s_593a6a', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 8, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 1, 1871297066);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (10, 14, 809183447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (13, -2147483640, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (16, 20, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (19, 15, 1465859724);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c1__5808bc', 1, 4, 0)
(2, 'c1__5808bc', 1, 4, 0)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(7, 'c1__5808bc', 1871297066, 4, 0)
(10, 'cus_8d1b6b', 809183447, 2, 1)
(13, 'cus_8d1b6b', 1744686505, 0, 0)
(16, 'cus_8d1b6b', 1115440883, 1, 1)
(19, 'cus_8d1b6b', 1465859724, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(T.CONTACT_NAME) AS CONTACTS_CNT, COUNT(C2.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON C1.CUSTOMER_ID = I.USER_ID LEFT JOIN CONTACTS AS T ON I.USER_ID = T.USER_ID LEFT JOIN CUSTOMERS AS C2 ON C2.EMAIL = T.CONTACT_EMAIL GROUP BY I.INVOICE_ID, I.USER_ID ORDER BY 1, I.INVOICE_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c1__5808bc', 1, 4, 0)
(2, 'c1__5808bc', 1, 4, 0)
(3, 'cus_8d1b6b', 247012447, 3, 3)
(7, 'c1__5808bc', 1871297066, 4, 0)
(10, 'cus_8d1b6b', 809183447, 4, 3)
(13, 'cus_8d1b6b', 1744686505, 0, 0)
(16, 'cus_8d1b6b', 1115440883, 3, 3)
(19, 'cus_8d1b6b', 1465859724, 0, 0)
*/