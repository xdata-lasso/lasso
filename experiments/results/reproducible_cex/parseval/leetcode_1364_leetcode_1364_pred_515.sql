-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_e4dd74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_e4dd74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'A', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_e4dd74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'c1__77f755', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'A', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'c1__77f755', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_e4dd74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'A', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'c1__77f755', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'A', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'c1__77f755', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'A', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'c1__77f755', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'c1__77f755', 'c1__d4be71');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'c1__77f755', 'c1__d4be71');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c1__d4be71', 'c1__77f755');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'c1__d4be71', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'c1__77f755');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'c1__77f755');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'C', 'c1__77f755');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c1__d4be71', 'c1__77f755');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'c1__d4be71', 'c1__77f755');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'c1__d4be71', '@');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, -1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, -1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_e4dd74', 1, 2, 1)
(0, 'cus_e4dd74', 1, 2, 1)
(1, 'cus_e4dd74', 1, 2, 1)
(2, 'cus_e4dd74', 1, 2, 1)
*/

-- Prediction Query
WITH A AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), B AS (SELECT C1.USER_ID, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C1 JOIN CUSTOMERS AS C2 ON C1.CONTACT_NAME = C2.CUSTOMER_NAME AND C1.CONTACT_EMAIL = C2.EMAIL GROUP BY 1) SELECT INVOICES.INVOICE_ID, CUSTOMERS.CUSTOMER_NAME, INVOICES.PRICE, CASE WHEN CONTACTS_CNT IS NULL THEN 0 ELSE CONTACTS_CNT END AS CONTACTS_CNT, CASE WHEN TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE TRUSTED_CONTACTS_CNT END AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN A ON INVOICES.USER_ID = A.USER_ID LEFT JOIN B ON INVOICES.USER_ID = B.USER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'cus_e4dd74', 1, 2, 0)
(0, 'cus_e4dd74', 1, 2, 0)
(1, 'cus_e4dd74', 1, 2, 37)
(2, 'cus_e4dd74', 1, 2, 37)
*/