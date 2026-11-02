-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_bbb314', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'b_s_bbb314', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'c_s_daf6c0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (17, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'c_s_daf6c0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (23, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'c_s_daf6c0');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_b7c48d', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'c_s_b7c48d', '1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'c_s_b7c48d', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'U');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', 's');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'J');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (8, 'con_de12a6', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_de12a6', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'c_s_daf6c0', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (14, 'con_de12a6', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'con_de12a6', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'c_s_daf6c0', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483634, 'con_de12a6', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (19, 'con_de12a6', 'c_s_c74344');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (22, 'c_s_daf6c0', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

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
(1, 'b_s_bbb314', 1, 4, 0)
(2, 'b_s_bbb314', 1, 4, 0)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(9, 'cus_8d1b6b', 1744686505, 0, 0)
(12, 'cus_8d1b6b', 1115440883, 1, 1)
(15, 'cus_8d1b6b', 700293388, 1, 0)
(18, 'cus_8d1b6b', 906324270, 1, 1)
(21, 'b_s_bbb314', 2122220075, 4, 0)
*/

-- Prediction Query
SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(D.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON B.CUSTOMER_ID = A.USER_ID LEFT JOIN CONTACTS AS C ON B.CUSTOMER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS D ON D.EMAIL = C.CONTACT_EMAIL GROUP BY A.INVOICE_ID ORDER BY A.INVOICE_ID, B.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'b_s_bbb314', 1, 4, 0)
(2, 'b_s_bbb314', 1, 4, 0)
(6, 'cus_8d1b6b', 247012447, 3, 3)
(9, 'cus_8d1b6b', 1744686505, 0, 0)
(12, 'cus_8d1b6b', 1115440883, 3, 3)
(15, 'cus_8d1b6b', 700293388, 1, 0)
(18, 'cus_8d1b6b', 906324270, 3, 3)
(21, 'b_s_bbb314', 2122220075, 4, 0)
*/