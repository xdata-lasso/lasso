-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_7ff84f', 'cus_8fffc1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'con_32ca18');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'con_32ca18');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_b10115', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_32ca18', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-1, 'cus_7ff84f', 1, 5, 1)
(0, 'cus_7ff84f', 1, 5, 1)
(1, 'cus_7ff84f', 1, 5, 1)
(2, 'cus_7ff84f', 1, 5, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, EMAIL, COALESCE(CONTACT_COUNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED, 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS LEFT JOIN (SELECT USER_ID, SUM(CASE WHEN EMAIL IS NULL THEN 0 ELSE 1 END) AS TRUSTED, COUNT(USER_ID) AS CONTACT_COUNT FROM CONTACTS LEFT JOIN CUSTOMERS ON EMAIL = CONTACT_EMAIL GROUP BY USER_ID) AS A ON CUSTOMER_ID = USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM CTE INNER JOIN INVOICES ON CUSTOMER_ID = USER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-1, 'cus_7ff84f', 1, 16, 12)
(0, 'cus_7ff84f', 1, 16, 12)
(1, 'cus_7ff84f', 1, 16, 12)
(2, 'cus_7ff84f', 1, 16, 12)
*/