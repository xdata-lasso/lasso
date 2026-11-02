-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_fe6f59', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_fe6f59', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cu__d41db8', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cu__d41db8', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (24, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'co__57c544');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'cus_fe6f59');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (8, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'con_de12a6', 'co__57c544');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (12, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'con_de12a6', 'co__57c544');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (20, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (18, 'con_de12a6', 'co__57c544');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (24, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (22, 'con_de12a6', 'co__57c544');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 8, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, 6, 1610062532);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, 12, 1871297066);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (13, 8, 89267185);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (15, 16, 1160656988);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (17, 1, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (19, 20, 1644814318);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (21, 3, 1019800248);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (23, 24, 429706943);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (25, 4, 1236688122);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'cus_fe6f59', 1, 1, 0)
(2, 'cu__d41db8', 1, 1, 0)
(7, 'cus_8d1b6b', 247012447, 1, 0)
(9, 'cus_8d1b6b', 1610062532, 1, 0)
(11, 'cus_8d1b6b', 1871297066, 1, 0)
(13, 'cus_8d1b6b', 89267185, 1, 0)
(15, 'cus_8d1b6b', 1160656988, 1, 0)
(17, 'cu__d41db8', 1115440883, 1, 0)
(19, 'cus_8d1b6b', 1644814318, 1, 0)
(21, 'cus_fe6f59', 1019800248, 1, 0)
(23, 'cus_8d1b6b', 429706943, 1, 0)
(25, 'cus_8d1b6b', 1236688122, 1, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE, COUNT(CO.CONTACT_NAME) AS CONTACTS_CNT, COALESCE(TCO.TRUSTED_COUNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID LEFT JOIN (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_COUNT FROM CONTACTS WHERE CONTACT_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY USER_ID) AS TCO ON TCO.USER_ID = CU.CUSTOMER_ID GROUP BY 1, 2, 3 ORDER BY I.INVOICE_ID, CU.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'cus_fe6f59', 1, 1, 0)
(2, 'cu__d41db8', 1, 1, 1)
(7, 'cus_8d1b6b', 247012447, 1, 0)
(9, 'cus_8d1b6b', 1610062532, 1, 0)
(11, 'cus_8d1b6b', 1871297066, 1, 0)
(13, 'cus_8d1b6b', 89267185, 1, 0)
(15, 'cus_8d1b6b', 1160656988, 1, 0)
(17, 'cu__d41db8', 1115440883, 1, 1)
(19, 'cus_8d1b6b', 1644814318, 1, 0)
(21, 'cus_fe6f59', 1019800248, 1, 0)
(23, 'cus_8d1b6b', 429706943, 1, 0)
(25, 'cus_8d1b6b', 1236688122, 1, 0)
*/