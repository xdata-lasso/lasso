-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_76fc31', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a_s_76fc31', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_67c215', 'b_s_5cbd6c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_67c215', 'b_s_5cbd6c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_acaa0b', 'b_s_c92b52');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 0, 0)
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(1, 'a_s_76fc31', 1, 4, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CU1.CUSTOMER_NAME, PRICE, COUNT(DISTINCT CO1.CONTACT_NAME) AS CONTACTS_CNT, COUNT(DISTINCT CU2.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS CU1 ON I.USER_ID = CU1.CUSTOMER_ID LEFT JOIN CONTACTS AS CO1 ON CU1.CUSTOMER_ID = CO1.USER_ID LEFT JOIN CUSTOMERS AS CU2 ON CO1.CONTACT_NAME = CU2.CUSTOMER_NAME GROUP BY 1, 2, 3 ORDER BY 1, INVOICE_ID NULLS LAST, CU1.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 0, 0)
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(1, 'a_s_76fc31', 1, 3, 0)
*/