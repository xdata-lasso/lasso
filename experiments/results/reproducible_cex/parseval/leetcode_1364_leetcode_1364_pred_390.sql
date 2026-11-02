-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'con_dfc2c8', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_d288d2', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, '@', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'con_043c00', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'con_043c00', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_043c00');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_043c00');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483641, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483648, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 5, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 5, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 5, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 5, 1644814318);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 5, 1465859724);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 5, 1019800248);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 429706943);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483648, 'b_s_d288d2', 1, 1, 0)
(-2147483644, 'cus_8d1b6b', 247012447, 0, 0)
(-2147483643, 'cus_8d1b6b', 1744686505, 0, 0)
(-2147483642, 'cus_8d1b6b', 1115440883, 0, 0)
(-2147483641, 'cus_8d1b6b', 1644814318, 0, 0)
(-2147483640, 'cus_8d1b6b', 1465859724, 0, 0)
(-2147483639, 'cus_8d1b6b', 1019800248, 0, 0)
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'b_s_d288d2', 1, 1, 0)
(2, 'b_s_d288d2', 429706943, 1, 0)
(3, 'b_s_d288d2', 1, 1, 0)
*/

-- Prediction Query
WITH T1 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), T2 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY 1), T3 AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, USER_ID FROM INVOICES AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM T3 LEFT JOIN T2 ON T3.USER_ID = T2.USER_ID LEFT JOIN T1 ON T3.USER_ID = T1.USER_ID ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483648, 'b_s_d288d2', 1, 1, 1)
(-2147483644, 'cus_8d1b6b', 247012447, 0, 0)
(-2147483643, 'cus_8d1b6b', 1744686505, 0, 0)
(-2147483642, 'cus_8d1b6b', 1115440883, 0, 0)
(-2147483641, 'cus_8d1b6b', 1644814318, 0, 0)
(-2147483640, 'cus_8d1b6b', 1465859724, 0, 0)
(-2147483639, 'cus_8d1b6b', 1019800248, 0, 0)
(-1, 'cus_8d1b6b', 1, 1, 1)
(0, 'cus_8d1b6b', 1, 1, 1)
(1, 'b_s_d288d2', 1, 1, 1)
(2, 'b_s_d288d2', 429706943, 1, 1)
(3, 'b_s_d288d2', 1, 1, 1)
*/