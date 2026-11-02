-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_32873b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, '!', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'c2__1d3b4c');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'c2__1d3b4c');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (21, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'c2__1d3b4c');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c2__f77f95', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'c2__f77f95', '&');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', 'c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'con_de12a6', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'c2__1d3b4c', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (12, 'con_de12a6', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'con_de12a6', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (15, 'c2__1d3b4c', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (18, 'con_de12a6', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'con_de12a6', 'c2__c22901');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (21, 'c2__1d3b4c', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, 9, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, -2147483639, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (14, 15, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (17, -2147483634, 700293388);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (20, 21, 906324270);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (23, 1, 2122220075);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'c_s_32873b', 1, 3, 0)
(2, 'c_s_32873b', 1, 3, 0)
(8, 'cus_8d1b6b', 247012447, 2, 1)
(11, 'cus_8d1b6b', 1744686505, 0, 0)
(14, 'cus_8d1b6b', 1115440883, 1, 1)
(17, 'cus_8d1b6b', 700293388, 0, 0)
(20, 'cus_8d1b6b', 906324270, 1, 1)
(23, 'c_s_32873b', 2122220075, 3, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, COUNT(C1.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS C2 ON C.CUSTOMER_ID = C2.USER_ID LEFT JOIN CUSTOMERS AS C1 ON C2.CONTACT_EMAIL = C1.EMAIL GROUP BY I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'c_s_32873b', 1, 3, 0)
(2, 'c_s_32873b', 1, 3, 0)
(8, 'cus_8d1b6b', 247012447, 4, 3)
(11, 'cus_8d1b6b', 1744686505, 0, 0)
(14, 'cus_8d1b6b', 1115440883, 3, 3)
(17, 'cus_8d1b6b', 700293388, 0, 0)
(20, 'cus_8d1b6b', 906324270, 3, 3)
(23, 'c_s_32873b', 2122220075, 3, 0)
*/