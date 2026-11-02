-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_347111', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_347111', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_347111', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_347111', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'co__f21db5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'co__f21db5', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'co__f21db5');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 2, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 2, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 2, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1644814318);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1465859724);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_347111', 247012447, 0, 0)
(-2147483643, 'cus_347111', 1744686505, 0, 0)
(-2147483642, 'cus_347111', 1115440883, 0, 0)
(-1, 'cus_347111', 1, 0, 0)
(0, 'cus_347111', 1, 1, 0)
(1, 'cus_347111', 1, 1, 0)
(2, 'cus_347111', 1644814318, 1, 0)
(3, 'cus_347111', 1465859724, 1, 0)
*/

-- Prediction Query
WITH CT1 AS (SELECT USER_ID, COUNT(USER_ID) AS NUM, COUNT(CU.CUSTOMER_NAME) AS NUM1 FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_NAME = CO.CONTACT_NAME GROUP BY 1), CT2 AS (SELECT INVOICE_ID, I.USER_ID, PRICE, COALESCE(NUM, 0) AS CONTACTS_CNT, COALESCE(NUM1, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CT1 ON CT1.USER_ID = I.USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM CT2 LEFT JOIN CUSTOMERS ON CT2.USER_ID = CUSTOMERS.CUSTOMER_ID ORDER BY 1, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_347111', 247012447, 0, 0)
(-2147483643, 'cus_347111', 1744686505, 0, 0)
(-2147483642, 'cus_347111', 1115440883, 0, 0)
(-1, 'cus_347111', 1, 0, 0)
(0, 'cus_347111', 1, 14, 14)
(1, 'cus_347111', 1, 14, 14)
(2, 'cus_347111', 1644814318, 14, 14)
(3, 'cus_347111', 1465859724, 14, 14)
*/