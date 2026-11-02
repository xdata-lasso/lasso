-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cs1_66a6e5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cs1_66a6e5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'ct__37383f');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cs1_66a6e5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'ct__bfa37f');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'ct__bfa37f');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'ct__bfa37f');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, NULL, 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__37383f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'ct__37383f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'ct__0b1971', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'ct__37383f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'ct__0b1971', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '?', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'ct__37383f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'ct__0b1971', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'ct__bfa37f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'ct__bfa37f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'ct__bfa37f', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 5, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 7, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 9, 1115440883);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 2, 1)
(0, 'cus_8d1b6b', 1, 2, 1)
(1, 'cs1_66a6e5', 1, 1, 1)
(2, 'cus_8d1b6b', 247012447, 1, 1)
(3, 'cus_8d1b6b', 1744686505, 1, 1)
(4, 'cus_8d1b6b', 1115440883, 1, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CS1.CUSTOMER_NAME, I.PRICE, COUNT(CT.USER_ID) AS CONTACTS_CNT, COUNT(CS2.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS CS1 ON I.USER_ID = CS1.CUSTOMER_ID LEFT JOIN CONTACTS AS CT ON CS1.CUSTOMER_ID = CT.USER_ID LEFT JOIN CUSTOMERS AS CS2 ON CS2.EMAIL = CT.CONTACT_EMAIL GROUP BY I.INVOICE_ID ORDER BY I.INVOICE_ID, CS1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 2, 1)
(0, 'cus_8d1b6b', 1, 2, 1)
(1, 'cs1_66a6e5', 1, 1, 1)
(2, 'cus_8d1b6b', 247012447, 3, 3)
(3, 'cus_8d1b6b', 1744686505, 3, 3)
(4, 'cus_8d1b6b', 1115440883, 3, 3)
*/