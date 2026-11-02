-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_a05d70', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_a05d70', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'con_65c0ec', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'con_65c0ec', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483647, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_65c0ec');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483645, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483639, 'con_de12a6', 'con_177999');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483645, 'cus_a05d70', 1, 1, 0)
(-2147483644, 'cus_a05d70', 1, 1, 0)
(-2147483643, 'cus_a05d70', 1, 1, 0)
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'cus_a05d70', 1, 1, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, 1 AS CONTACT_CNT, CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED_CONTACTS_CNT FROM CONTACTS) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, SUM(CONTACT_CNT) AS CONTACTS_CNT, SUM(TRUSTED_CONTACTS_CNT) AS TRUSTED_CONTACTS_CNT FROM CTE GROUP BY USER_ID) AS T ON INVOICES.USER_ID = T.USER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483645, 'cus_a05d70', 1, 1, 1)
(-2147483644, 'cus_a05d70', 1, 1, 1)
(-2147483643, 'cus_a05d70', 1, 1, 1)
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'cus_a05d70', 1, 1, 1)
*/