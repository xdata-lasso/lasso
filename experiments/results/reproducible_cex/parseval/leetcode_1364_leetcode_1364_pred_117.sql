-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_f59939', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_40b121', 'c_s_b089db');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'c_s_40b121', 'c_s_b089db');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'c_s_40b121', 'c_s_b089db');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (17, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'c_s_40b121', 'c_s_b089db');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (23, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (21, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (24, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_b63b4b', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'c_s_b089db', 'c_s_40b121');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483647, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (11, 'c_s_b089db', 'c_s_40b121');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (15, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (17, 'c_s_b089db', 'c_s_40b121');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (24, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (23, 'con_de12a6', 'c_s_ded271');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (23, 'c_s_b089db', 'c_s_40b121');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 5, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 3, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (10, 11, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (13, -2147483642, 1465859724);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (16, 17, 1019800248);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (19, 12, 1526238907);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (22, 23, 1236688122);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (25, -2147483642, 907682809);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'b_s_f59939', 1, 1, 0)
(4, 'cus_8d1b6b', 247012447, 2, 1)
(7, 'cus_8d1b6b', 1744686505, 1, 0)
(10, 'cus_8d1b6b', 1115440883, 1, 1)
(13, 'c_s_40b121', 1465859724, 0, 0)
(16, 'cus_8d1b6b', 1019800248, 1, 1)
(19, 'cus_8d1b6b', 1526238907, 0, 0)
(22, 'cus_8d1b6b', 1236688122, 2, 1)
(25, 'c_s_40b121', 907682809, 0, 0)
*/

-- Prediction Query
SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(D.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON B.CUSTOMER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS D ON C.CONTACT_NAME = D.CUSTOMER_NAME AND C.CONTACT_EMAIL = D.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, A.INVOICE_ID NULLS LAST, B.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'b_s_f59939', 1, 1, 0)
(4, 'cus_8d1b6b', 247012447, 5, 4)
(7, 'cus_8d1b6b', 1744686505, 1, 0)
(10, 'cus_8d1b6b', 1115440883, 4, 4)
(13, 'c_s_40b121', 1465859724, 0, 0)
(16, 'cus_8d1b6b', 1019800248, 4, 4)
(19, 'cus_8d1b6b', 1526238907, 0, 0)
(22, 'cus_8d1b6b', 1236688122, 5, 4)
(25, 'c_s_40b121', 907682809, 0, 0)
*/