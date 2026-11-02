-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_4d6b40', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'b_s_4d6b40', '1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'c_s_2bcc72');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'c_s_2bcc72');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (21, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'c_s_2bcc72');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_9aaf45', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'c_s_9aaf45', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'c_s_9aaf45', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '?', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '?', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'c_s_2bcc72', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (15, 'c_s_2bcc72', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (21, 'c_s_2bcc72', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'con_de12a6', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, 9, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, 10, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (14, 15, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (17, 12, 1465859724);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (20, 21, 1019800248);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (23, -2147483638, 1526238907);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'b_s_4d6b40', 1, 1, 0)
(2, 'b_s_4d6b40', 1, 1, 0)
(8, 'cus_8d1b6b', 247012447, 1, 1)
(11, 'cus_8d1b6b', 1744686505, 0, 0)
(14, 'cus_8d1b6b', 1115440883, 1, 1)
(17, 'cus_8d1b6b', 1465859724, 0, 0)
(20, 'cus_8d1b6b', 1019800248, 1, 1)
(23, 'cus_8d1b6b', 1526238907, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, B.CUSTOMER_NAME, PRICE, COUNT(C.USER_ID) AS CONTACTS_CNT, COUNT(D.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON A.USER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS D ON D.EMAIL = C.CONTACT_EMAIL GROUP BY A.INVOICE_ID ORDER BY INVOICE_ID, B.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'b_s_4d6b40', 1, 1, 0)
(2, 'b_s_4d6b40', 1, 1, 0)
(8, 'cus_8d1b6b', 247012447, 3, 3)
(11, 'cus_8d1b6b', 1744686505, 0, 0)
(14, 'cus_8d1b6b', 1115440883, 3, 3)
(17, 'cus_8d1b6b', 1465859724, 0, 0)
(20, 'cus_8d1b6b', 1019800248, 3, 3)
(23, 'cus_8d1b6b', 1526238907, 0, 0)
*/