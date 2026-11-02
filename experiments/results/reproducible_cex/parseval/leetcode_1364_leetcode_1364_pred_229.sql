-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cu__055663', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cu__055663', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'C', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'co__5195ca', '?');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'O', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cu__055663', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'co__5195ca', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cu__055663', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'O', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'co__5195ca', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, '_', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'co__5195ca', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'Q', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'co__5195ca', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'co__5195ca', 'co__ff64a8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'co__5195ca', 'co__ff64a8');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__ff64a8', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'co__ff64a8', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'I', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'co__ff64a8', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'co__ff64a8', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'co__ff64a8', 'co__5195ca');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'co__ff64a8', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'C', 'co__5195ca');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483630, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483629, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cu__055663', 1, 2, 1)
(-2147483646, 'cu__055663', 1, 2, 1)
(-2147483645, 'cu__055663', 1, 2, 1)
(-2147483644, 'cu__055663', 1, 2, 1)
(-2147483643, 'cus_8d1b6b', 1, 1, 1)
(-2147483642, 'cus_8d1b6b', 1, 2, 1)
(-2147483641, 'cu__055663', 1, 2, 1)
(-2147483640, 'cu__055663', 1, 2, 1)
(-2147483639, 'cu__055663', 1, 2, 1)
(-2147483638, 'cus_8d1b6b', 1, 1, 1)
(-2147483637, 'cus_8d1b6b', 1, 2, 1)
(-2147483636, 'cu__055663', 1, 5, 2)
(-2147483635, 'cu__055663', 1, 2, 1)
(-2147483634, 'cu__055663', 1, 2, 1)
(-2147483633, 'cus_8d1b6b', 1, 1, 1)
(-2147483632, 'cus_8d1b6b', 1, 2, 1)
(-2147483631, 'cu__055663', 1, 5, 2)
(-2147483630, 'cu__055663', 1, 2, 1)
(-2147483629, 'cu__055663', 1, 2, 1)
(1, 'cu__055663', 1, 2, 1)
(3, 'cu__055663', 1, 2, 1)
*/

-- Prediction Query
WITH A AS (SELECT USER_ID, COUNT(CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CO.CONTACT_NAME = CU.CUSTOMER_NAME AND CO.CONTACT_EMAIL = CU.EMAIL GROUP BY USER_ID), B AS (SELECT USER_ID, COUNT(USER_ID) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = I.USER_ID LEFT JOIN A ON A.USER_ID = I.USER_ID LEFT JOIN B ON B.USER_ID = I.USER_ID ORDER BY INVOICE_ID, CU.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cu__055663', 1, 2, 29)
(-2147483646, 'cu__055663', 1, 2, 29)
(-2147483645, 'cu__055663', 1, 2, 29)
(-2147483644, 'cu__055663', 1, 2, 29)
(-2147483643, 'cus_8d1b6b', 1, 1, 29)
(-2147483642, 'cus_8d1b6b', 1, 2, 29)
(-2147483641, 'cu__055663', 1, 2, 29)
(-2147483640, 'cu__055663', 1, 2, 29)
(-2147483639, 'cu__055663', 1, 2, 29)
(-2147483638, 'cus_8d1b6b', 1, 1, 29)
(-2147483637, 'cus_8d1b6b', 1, 2, 29)
(-2147483636, 'cu__055663', 1, 5, 1)
(-2147483635, 'cu__055663', 1, 2, 29)
(-2147483634, 'cu__055663', 1, 2, 29)
(-2147483633, 'cus_8d1b6b', 1, 1, 29)
(-2147483632, 'cus_8d1b6b', 1, 2, 29)
(-2147483631, 'cu__055663', 1, 5, 1)
(-2147483630, 'cu__055663', 1, 2, 29)
(-2147483629, 'cu__055663', 1, 2, 29)
(1, 'cu__055663', 1, 2, 29)
(3, 'cu__055663', 1, 2, 29)
*/