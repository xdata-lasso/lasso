-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_cf3517', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, NULL, 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'ct__2b9195');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'ct__f9ea5f');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__2b9195', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'ct__f9ea5f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (8, 'ct__f9ea5f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483632, 'A', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 3, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 8, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, 3, 1744686505);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c_s_cf3517', 1, 1, 1)
(2, 'c_s_cf3517', 1, 1, 1)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(9, 'cus_8d1b6b', 1744686505, 1, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN NOT C2.EMAIL IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS CT ON I.USER_ID = CT.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CT.CONTACT_EMAIL = C2.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c_s_cf3517', 1, 18, 18)
(2, 'c_s_cf3517', 1, 18, 18)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(9, 'cus_8d1b6b', 1744686505, 1, 1)
*/