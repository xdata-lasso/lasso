-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'c_s_b8e3f6', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'con_3091cf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'con_3091cf');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_3091cf', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_d0589f', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_eca831', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_3091cf', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Q', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'E', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 7, 1)
(-2147483646, 'cus_8d1b6b', 1, 7, 1)
(-2147483645, 'cus_8d1b6b', 1, 7, 1)
(-2147483644, 'cus_8d1b6b', 1, 7, 1)
(-2147483643, 'cus_8d1b6b', 1, 7, 1)
(-2147483642, 'cus_8d1b6b', 1, 7, 1)
(1, 'cus_8d1b6b', 1, 7, 1)
*/

-- Prediction Query
WITH CTE2 AS (SELECT USER_ID, COUNT(USER_ID) AS CONTACTS_CNT, COUNT(EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS LEFT JOIN CUSTOMERS ON CONTACTS.CONTACT_EMAIL = CUSTOMERS.EMAIL GROUP BY CONTACTS.USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CTE2.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(CTE2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, C.CUSTOMER_ID AS USER_ID FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID) AS CTE LEFT JOIN CTE2 ON CTE.USER_ID = CTE2.USER_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 24, 18)
(-2147483646, 'cus_8d1b6b', 1, 24, 18)
(-2147483645, 'cus_8d1b6b', 1, 24, 18)
(-2147483644, 'cus_8d1b6b', 1, 24, 18)
(-2147483643, 'cus_8d1b6b', 1, 24, 18)
(-2147483642, 'cus_8d1b6b', 1, 24, 18)
(1, 'cus_8d1b6b', 1, 24, 18)
*/