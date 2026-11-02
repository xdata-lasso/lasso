-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_520a92', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_520a92', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_520a92', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'con_73a82b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'con_73a82b');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_5472ee', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_11295f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bb42d2', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_73a82b', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, ']', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'I', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_5472ee', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_11295f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_bb42d2', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_73a82b', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_73a82b', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_5472ee', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_11295f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_bb42d2', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_73a82b', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_5472ee', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_11295f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_bb42d2', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '!', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_73a82b', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483630, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483629, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483628, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483627, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483626, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483625, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_520a92', 1, 8, 1)
(-2147483646, 'cus_520a92', 1, 8, 1)
(-2147483645, 'cus_8d1b6b', 1, 1, 1)
(-2147483644, 'cus_8d1b6b', 1, 1, 1)
(-2147483643, 'cus_8d1b6b', 1, 4, 1)
(-2147483642, 'cus_520a92', 1, 8, 1)
(-2147483641, 'cus_8d1b6b', 1, 1, 1)
(-2147483640, 'cus_8d1b6b', 1, 1, 1)
(-2147483639, 'cus_520a92', 1, 8, 1)
(-2147483638, 'cus_520a92', 1, 8, 1)
(-2147483637, 'cus_8d1b6b', 1, 1, 1)
(-2147483636, 'cus_8d1b6b', 1, 1, 1)
(-2147483635, 'cus_8d1b6b', 1, 4, 1)
(-2147483634, 'cus_520a92', 1, 8, 1)
(-2147483633, 'cus_520a92', 1, 8, 1)
(-2147483632, 'cus_520a92', 1, 8, 1)
(-2147483631, 'cus_520a92', 1, 8, 1)
(-2147483630, 'cus_520a92', 1, 8, 1)
(-2147483629, 'cus_520a92', 1, 8, 1)
(-2147483628, 'cus_520a92', 1, 8, 1)
(-2147483627, 'cus_520a92', 1, 8, 1)
(-2147483626, 'cus_520a92', 1, 8, 1)
(-2147483625, 'cus_520a92', 1, 8, 1)
(1, 'cus_520a92', 1, 8, 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID), CTE2 AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CON JOIN CUSTOMERS AS CST ON CON.CONTACT_EMAIL = CST.EMAIL GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INV JOIN CUSTOMERS AS CUS ON INV.USER_ID = CUS.CUSTOMER_ID LEFT JOIN CTE1 USING (USER_ID) LEFT JOIN CTE2 USING (USER_ID) ORDER BY INVOICE_ID, CUS.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_520a92', 1, 8, 24)
(-2147483646, 'cus_520a92', 1, 8, 24)
(-2147483645, 'cus_8d1b6b', 1, 1, 24)
(-2147483644, 'cus_8d1b6b', 1, 1, 24)
(-2147483643, 'cus_8d1b6b', 1, 4, 24)
(-2147483642, 'cus_520a92', 1, 8, 24)
(-2147483641, 'cus_8d1b6b', 1, 1, 24)
(-2147483640, 'cus_8d1b6b', 1, 1, 24)
(-2147483639, 'cus_520a92', 1, 8, 24)
(-2147483638, 'cus_520a92', 1, 8, 24)
(-2147483637, 'cus_8d1b6b', 1, 1, 24)
(-2147483636, 'cus_8d1b6b', 1, 1, 24)
(-2147483635, 'cus_8d1b6b', 1, 4, 24)
(-2147483634, 'cus_520a92', 1, 8, 24)
(-2147483633, 'cus_520a92', 1, 8, 24)
(-2147483632, 'cus_520a92', 1, 8, 24)
(-2147483631, 'cus_520a92', 1, 8, 24)
(-2147483630, 'cus_520a92', 1, 8, 24)
(-2147483629, 'cus_520a92', 1, 8, 24)
(-2147483628, 'cus_520a92', 1, 8, 24)
(-2147483627, 'cus_520a92', 1, 8, 24)
(-2147483626, 'cus_520a92', 1, 8, 24)
(-2147483625, 'cus_520a92', 1, 8, 24)
(1, 'cus_520a92', 1, 8, 24)
*/