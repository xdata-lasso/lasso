-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_b5ea66', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'c_s_b5ea66', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, '_', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_b5ea66', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'ct__df4097', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, '?', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'ct__df4097', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c_s_b5ea66', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'G', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'ct__df4097', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'O', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'ct__df4097', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'Q', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'ct__df4097', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'ct__df4097', 'ct__30b403');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'ct__df4097', 'ct__30b403');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__30b403', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'ct__30b403', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'I', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'ct__30b403', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'C', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'ct__30b403', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'ct__30b403', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'U', 'ct__df4097');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'Y', 'ct__df4097');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, -1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'c_s_b5ea66', 1, 4, 1)
(0, 'c_s_b5ea66', 1, 6, 1)
(1, 'c_s_b5ea66', 1, 2, 1)
(2, 'c_s_b5ea66', 1, 2, 1)
(3, 'c_s_b5ea66', 1, 2, 1)
*/

-- Prediction Query
WITH CONT_COUNT AS (SELECT USER_ID, COUNT(*) AS CT_COUNT FROM CONTACTS GROUP BY USER_ID), TRUST_CONT_COUNT AS (SELECT CT.USER_ID, COUNT(*) AS TRUST_CT_COUNT FROM CONTACTS AS CT INNER JOIN CUSTOMERS AS CM ON CT.CONTACT_NAME = CM.CUSTOMER_NAME AND CT.CONTACT_EMAIL = CM.EMAIL GROUP BY CT.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(C_CT.CT_COUNT, 0) AS CONTACTS_CNT, COALESCE(T_CT.TRUST_CT_COUNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONT_COUNT AS C_CT ON I.USER_ID = C_CT.USER_ID LEFT JOIN TRUST_CONT_COUNT AS T_CT ON I.USER_ID = T_CT.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'c_s_b5ea66', 1, 4, 0)
(0, 'c_s_b5ea66', 1, 6, 0)
(1, 'c_s_b5ea66', 1, 2, 35)
(2, 'c_s_b5ea66', 1, 2, 35)
(3, 'c_s_b5ea66', 1, 2, 35)
*/