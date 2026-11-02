-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_8d1b6b', 'c_s_f4ced0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'c_s_692046');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'c_s_692046');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (21, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'c_s_692046');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_f4ced0', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'c_s_692046', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'c_s_692046', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'c_s_692046', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (12, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (19, 'c_s_692046', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (21, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'A', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 2, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (5, 7, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, 1, 1871297066);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, 13, 809183447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (14, 13, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (17, 19, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (20, -2147483636, 1465859724);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'cus_8d1b6b', 1, 1, 1)
(2, 'cus_8d1b6b', 247012447, 1, 1)
(5, 'cus_8d1b6b', 247012447, 1, 1)
(8, 'cus_8d1b6b', 1871297066, 1, 1)
(11, 'cus_8d1b6b', 809183447, 1, 1)
(14, 'cus_8d1b6b', 1744686505, 1, 1)
(17, 'cus_8d1b6b', 1115440883, 1, 1)
(20, 'cus_8d1b6b', 1465859724, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CT.CUSTOMER_NAME, I.PRICE, COUNT(C.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN NOT CST.EMAIL IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CT ON I.USER_ID = CT.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS CST ON C.CONTACT_EMAIL = CST.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, CT.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'cus_8d1b6b', 1, 1, 1)
(2, 'cus_8d1b6b', 247012447, 3, 3)
(5, 'cus_8d1b6b', 247012447, 3, 3)
(8, 'cus_8d1b6b', 1871297066, 1, 1)
(11, 'cus_8d1b6b', 809183447, 3, 3)
(14, 'cus_8d1b6b', 1744686505, 3, 3)
(17, 'cus_8d1b6b', 1115440883, 3, 3)
(20, 'cus_8d1b6b', 1465859724, 0, 0)
*/