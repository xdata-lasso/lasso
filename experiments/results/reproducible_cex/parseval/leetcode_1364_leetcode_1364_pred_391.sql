-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_6fc2f4', 'c_s_cbb23e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_6fc2f4', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'c_s_6fc2f4', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cu1_589758', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'c_s_325a8f', 'c_s_ee2f60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_cbb23e', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '"', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, ')', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '!', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '@', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '#', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'a', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'B', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'E', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Y', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '"', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a', '?');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '!', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'k', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '"', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '%', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b', 'C');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'D', 'c_s_6fc2f4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'A', 'c_s_dd0e7c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'd', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 't', '?');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (11, 'c_s_ee2f60', 'c_s_325a8f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'A', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 5, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 11, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, 7, 1744686505);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'c_s_6fc2f4', 1, 10, 2)
(0, 'cus_8d1b6b', 1, 7, 1)
(1, 'c_s_6fc2f4', 1, 10, 2)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(9, 'cus_8d1b6b', 1744686505, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CU1.CUSTOMER_NAME, PRICE, COUNT(C.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(CU.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS CU1 ON I.USER_ID = CU1.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS CU ON C.CONTACT_EMAIL = CU.EMAIL AND C.CONTACT_NAME = CU.CUSTOMER_NAME GROUP BY 1, 2, 3 ORDER BY 1, INVOICE_ID NULLS LAST, CU1.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'c_s_6fc2f4', 1, 10, 1)
(0, 'cus_8d1b6b', 1, 8, 2)
(1, 'c_s_6fc2f4', 1, 10, 1)
(6, 'cus_8d1b6b', 247012447, 1, 1)
(9, 'cus_8d1b6b', 1744686505, 0, 0)
*/