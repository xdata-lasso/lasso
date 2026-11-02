-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c1__8e1101', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'L', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'c2__872770', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'c2__872770', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c2__e66069', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'A', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'a', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '!', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '1', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '!', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '"', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'c', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'j', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '#', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'q', '?');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'G', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'S', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '%', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'Q', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'T', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c2__621aa9', 'c2__f88f2a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (8, 'con_de12a6', 'c2__872770');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (14, 'con_de12a6', 'c2__872770');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483640, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (11, 'A', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 8, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (10, -2147483640, 1610062532);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (13, 14, 1871297066);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (16, 12, 1744686505);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c1__8e1101', 1, 7, 0)
(7, 'cus_8d1b6b', 247012447, 1, 0)
(10, 'c2__872770', 1610062532, 1, 0)
(13, 'cus_8d1b6b', 1871297066, 1, 0)
(16, 'cus_8d1b6b', 1744686505, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(C2.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(C3.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS C2 ON C2.USER_ID = C1.CUSTOMER_ID LEFT JOIN CUSTOMERS AS C3 ON C3.CUSTOMER_NAME = C2.CONTACT_NAME GROUP BY I.INVOICE_ID ORDER BY I.INVOICE_ID, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c1__8e1101', 1, 7, 0)
(7, 'cus_8d1b6b', 247012447, 2, 2)
(10, 'c2__872770', 1610062532, 1, 0)
(13, 'cus_8d1b6b', 1871297066, 2, 2)
(16, 'cus_8d1b6b', 1744686505, 0, 0)
*/