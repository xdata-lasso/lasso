-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_8f3dc3', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'b_s_33a444', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'b_s_33a444', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'b_s_33a444', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'b_s_33a444', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'b_s_33a444', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'b_s_33a444', 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, NULL, 'a_s_672717');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, NULL, 'a_s_672717');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_672717', 'a_s_c911a0');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Y', 'a_s_c911a0');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'a_s_c792c6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'i', 'a_s_c911a0');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'a_s_c911a0');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_772ff5', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'a_s_8f3dc3', 1, 5, 1)
(-2147483646, 'a_s_8f3dc3', 1, 5, 1)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'a_s_8f3dc3', 1, 5, 1)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-2147483642, 'a_s_8f3dc3', 1, 5, 1)
(-2147483641, 'cus_8d1b6b', 1, 0, 0)
(-2147483640, 'a_s_8f3dc3', 1, 5, 1)
(1, 'a_s_8f3dc3', 1, 5, 1)
(3, 'a_s_8f3dc3', 1, 5, 1)
*/

-- Prediction Query
WITH TMP AS (SELECT USER_ID, COUNT(B.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY USER_ID), TMP1 AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN TMP AS B ON CUSTOMER_ID = USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN TMP1 AS B ON USER_ID = CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(-2147483647, 'a_s_8f3dc3', 1, 28, 12)
(-2147483646, 'a_s_8f3dc3', 1, 28, 12)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'a_s_8f3dc3', 1, 28, 12)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-2147483642, 'a_s_8f3dc3', 1, 28, 12)
(-2147483641, 'cus_8d1b6b', 1, 0, 0)
(-2147483640, 'a_s_8f3dc3', 1, 28, 12)
(1, 'a_s_8f3dc3', 1, 28, 12)
(3, 'a_s_8f3dc3', 1, 28, 12)
*/