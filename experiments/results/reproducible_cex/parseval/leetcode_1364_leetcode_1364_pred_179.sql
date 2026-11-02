-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_49ac54', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'c_s_49ac54', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'c_s_49ac54', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (18, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'c_s_49ac54', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (24, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (21, 'cu__52f1f1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (25, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'c_s_52dfa2');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'con_de12a6', 'c_s_49ac54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (12, 'con_de12a6', 'c_s_49ac54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (18, 'con_de12a6', 'c_s_49ac54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (16, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (24, 'con_de12a6', 'c_s_49ac54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483637, 'con_de12a6', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 809183447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (5, 6, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, 4, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, 12, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (14, -2147483642, 1465859724);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (17, 18, 1019800248);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (20, 13, 1526238907);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (23, 24, 1236688122);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (26, -2147483642, 907682809);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'cus_8d1b6b', 247012447, 1, 0)
(2, 'cus_8d1b6b', 809183447, 1, 0)
(5, 'cu__52f1f1', 247012447, 1, 0)
(8, 'cus_8d1b6b', 1744686505, 1, 0)
(11, 'cu__52f1f1', 1115440883, 1, 0)
(14, 'c_s_49ac54', 1465859724, 0, 0)
(17, 'cu__52f1f1', 1019800248, 1, 0)
(20, 'cus_8d1b6b', 1526238907, 1, 0)
(23, 'cu__52f1f1', 1236688122, 1, 0)
(26, 'c_s_49ac54', 907682809, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, MIN(CU.CUSTOMER_NAME) AS CUSTOMER_NAME, MIN(I.PRICE) AS PRICE, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(CU2.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS CU2 ON C.CONTACT_NAME = CU2.CUSTOMER_NAME GROUP BY I.INVOICE_ID ORDER BY I.INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'cus_8d1b6b', 247012447, 1, 0)
(2, 'cus_8d1b6b', 809183447, 1, 0)
(5, 'cu__52f1f1', 247012447, 4, 4)
(8, 'cus_8d1b6b', 1744686505, 1, 0)
(11, 'cu__52f1f1', 1115440883, 4, 4)
(14, 'c_s_49ac54', 1465859724, 0, 0)
(17, 'cu__52f1f1', 1019800248, 4, 4)
(20, 'cus_8d1b6b', 1526238907, 1, 0)
(23, 'cu__52f1f1', 1236688122, 4, 4)
(26, 'c_s_49ac54', 907682809, 0, 0)
*/