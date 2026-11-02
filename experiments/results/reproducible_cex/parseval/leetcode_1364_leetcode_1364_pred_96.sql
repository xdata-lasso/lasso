-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_3e4fdc', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_3e4fdc', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'A', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'co__7c74c5', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'A', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'co__7c74c5', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'A', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'co__7c74c5', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'A', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'co__7c74c5', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'A', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'co__7c74c5', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'co__7c74c5', 'co__b385cc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'co__7c74c5', 'co__b385cc');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_564515');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__b385cc', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_564515');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'co__b385cc', '1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_564515');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'a', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_564515');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'co__b385cc', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'co__b385cc', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'co__b385cc', 'co__7c74c5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483611, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483630, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483629, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 4, 1)
(-2147483646, 'c_s_3e4fdc', 1, 2, 1)
(-2147483645, 'cus_8d1b6b', 1, 4, 1)
(-2147483644, 'cus_8d1b6b', 1, 4, 1)
(-2147483643, 'cus_8d1b6b', 1, 1, 1)
(-2147483642, 'c_s_3e4fdc', 1, 2, 1)
(-2147483641, 'cus_8d1b6b', 1, 2, 1)
(-2147483640, 'cus_8d1b6b', 1, 4, 1)
(-2147483639, 'c_s_3e4fdc', 1, 2, 1)
(-2147483638, 'cus_8d1b6b', 1, 1, 1)
(-2147483637, 'cus_8d1b6b', 1, 4, 1)
(-2147483636, 'cus_8d1b6b', 1, 2, 1)
(-2147483635, 'cus_8d1b6b', 1, 4, 1)
(-2147483634, 'cus_8d1b6b', 1, 4, 1)
(-2147483633, 'cus_8d1b6b', 1, 1, 1)
(-2147483632, 'cus_8d1b6b', 1, 4, 1)
(-2147483631, 'cus_8d1b6b', 1, 2, 1)
(-2147483630, 'c_s_3e4fdc', 1, 2, 1)
(-2147483629, 'c_s_3e4fdc', 1, 2, 1)
(1, 'c_s_3e4fdc', 1, 2, 1)
(2, 'c_s_3e4fdc', 1, 2, 1)
(3, 'c_s_3e4fdc', 1, 2, 1)
*/

-- Prediction Query
WITH T AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID), T2 AS (SELECT CO.USER_ID, COUNT(C.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_NAME = CO.CONTACT_NAME AND C.EMAIL = CO.CONTACT_EMAIL GROUP BY CO.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(T.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(T2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN T ON T.USER_ID = I.USER_ID LEFT JOIN T2 ON T2.USER_ID = I.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 4, 34)
(-2147483646, 'c_s_3e4fdc', 1, 2, 34)
(-2147483645, 'cus_8d1b6b', 1, 4, 34)
(-2147483644, 'cus_8d1b6b', 1, 4, 34)
(-2147483643, 'cus_8d1b6b', 1, 1, 34)
(-2147483642, 'c_s_3e4fdc', 1, 2, 34)
(-2147483641, 'cus_8d1b6b', 1, 2, 34)
(-2147483640, 'cus_8d1b6b', 1, 4, 34)
(-2147483639, 'c_s_3e4fdc', 1, 2, 34)
(-2147483638, 'cus_8d1b6b', 1, 1, 34)
(-2147483637, 'cus_8d1b6b', 1, 4, 34)
(-2147483636, 'cus_8d1b6b', 1, 2, 34)
(-2147483635, 'cus_8d1b6b', 1, 4, 34)
(-2147483634, 'cus_8d1b6b', 1, 4, 34)
(-2147483633, 'cus_8d1b6b', 1, 1, 34)
(-2147483632, 'cus_8d1b6b', 1, 4, 34)
(-2147483631, 'cus_8d1b6b', 1, 2, 34)
(-2147483630, 'c_s_3e4fdc', 1, 2, 34)
(-2147483629, 'c_s_3e4fdc', 1, 2, 34)
(1, 'c_s_3e4fdc', 1, 2, 34)
(2, 'c_s_3e4fdc', 1, 2, 34)
(3, 'c_s_3e4fdc', 1, 2, 34)
*/