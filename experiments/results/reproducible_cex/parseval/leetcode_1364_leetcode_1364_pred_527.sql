-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'd_s_198be6', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, NULL, 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'b_s_c62c6a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'b_s_1d1e42');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_c62c6a', 'b_s_9f47b8');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'b_s_1d1e42', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'b_s_1d1e42', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483641, 'con_de12a6', 'b_s_9f47b8');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483632, 'con_de12a6', 'b_s_9f47b8');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 3, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 9, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, -2147483621, 1610062532);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'd_s_198be6', 1, 1, 1)
(2, 'd_s_198be6', 1, 1, 1)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(4, 'cus_8d1b6b', 247012447, 1, 1)
(7, 'cus_8d1b6b', 1610062532, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, D.CUSTOMER_NAME, PRICE, COUNT(B.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN NOT C.EMAIL IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERS AS D ON A.USER_ID = D.CUSTOMER_ID LEFT JOIN CONTACTS AS B ON D.CUSTOMER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS C ON B.CONTACT_EMAIL = C.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, INVOICE_ID NULLS LAST, D.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'd_s_198be6', 1, 20, 20)
(2, 'd_s_198be6', 1, 20, 20)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(4, 'cus_8d1b6b', 247012447, 1, 1)
(7, 'cus_8d1b6b', 1610062532, 0, 0)
*/