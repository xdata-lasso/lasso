-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_db8f55', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'c_s_346478', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'A', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'A', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, '@', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, '@', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c_s_db8f55', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, '$', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, '$', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, '"', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, '"', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'C', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'C', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, '!', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, '!', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, '2', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, '2', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, '!', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, '!', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'A', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'A', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'A', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, '!', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, '!', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, 'c_s_5c70bb', 'c_s_c87f32');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483588, 'c_s_5c70bb', 'c_s_c87f32');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_c87f32', 'c_s_5c70bb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_1c3bea', 'c_s_6c2d6c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'C');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Q', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'I', '`');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 2);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_db8f55', 1, 7, 2)
(-2147483644, 'c_s_db8f55', 1, 7, 2)
(-2147483643, 'c_s_db8f55', 1, 7, 2)
(-2147483642, 'c_s_db8f55', 1, 7, 2)
(-2147483641, 'c_s_db8f55', 1, 7, 2)
(-2147483640, 'c_s_db8f55', 1, 7, 2)
(-1, 'c_s_db8f55', 1, 7, 2)
(0, 'c_s_db8f55', 2, 7, 2)
(1, 'c_s_db8f55', 1, 7, 2)
*/

-- Prediction Query
WITH CTE_CUSTOMER_INVOICE AS (SELECT I.INVOICE_ID, C.CUSTOMER_ID, C.CUSTOMER_NAME, I.PRICE FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID), CTE_TOTAL_CONTACTS AS (SELECT USER_ID AS CUSTOMER_ID, COUNT(*) AS TOT_CONTACTS FROM CONTACTS GROUP BY USER_ID), CTE_TRUSTED_CONTACTS AS (SELECT USER_ID AS CUSTOMER_ID, COUNT(*) AS TRUSTED_CONTACTS FROM CONTACTS AS C JOIN CUSTOMERS AS CC ON C.CONTACT_NAME = CC.CUSTOMER_NAME AND C.CONTACT_EMAIL = CC.EMAIL GROUP BY USER_ID), CTE_CONTACTS_MERGED AS (SELECT C.CUSTOMER_ID, TOT_CONTACTS AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS, 0) AS TRUSTED_CONTACTS_CNT FROM CTE_TOTAL_CONTACTS AS C LEFT JOIN CTE_TRUSTED_CONTACTS AS CC ON C.CUSTOMER_ID = CC.CUSTOMER_ID) SELECT I.INVOICE_ID, I.CUSTOMER_NAME, I.PRICE, COALESCE(C.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM CTE_CUSTOMER_INVOICE AS I LEFT JOIN CTE_CONTACTS_MERGED AS C ON I.CUSTOMER_ID = C.CUSTOMER_ID ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, I.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_db8f55', 1, 7, 29)
(-2147483644, 'c_s_db8f55', 1, 7, 29)
(-2147483643, 'c_s_db8f55', 1, 7, 29)
(-2147483642, 'c_s_db8f55', 1, 7, 29)
(-2147483641, 'c_s_db8f55', 1, 7, 29)
(-2147483640, 'c_s_db8f55', 1, 7, 29)
(-1, 'c_s_db8f55', 1, 7, 29)
(0, 'c_s_db8f55', 2, 7, 29)
(1, 'c_s_db8f55', 1, 7, 29)
*/