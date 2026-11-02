-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_8d1b6b', 'b_s_702311');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'd_s_287f2a', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'b_s_a97c22');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'c_s_f576f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'b_s_a97c22');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'b_s_a97c22');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (12, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (15, 'cus_8d1b6b', 'b_s_a97c22');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_702311', 'b_s_91a5ab');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'b_s_702311', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'D');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', 'y');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_a97c22', 'b_s_91a5ab');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', 'b_s_91a5ab');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'b_s_a97c22', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'b_s_a97c22', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (12, 'b_s_a97c22', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 5, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, -2147483640, 1610062532);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (12, 13, 1871297066);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (15, 14, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 6, 1258409369);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 6, NULL);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 12, 1610062532);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'cus_8d1b6b', 247012447, 3, 1)
(2, 'cus_8d1b6b', 1258409369, 1, 1)
(3, 'cus_8d1b6b', None, 1, 1)
(4, 'cus_8d1b6b', 1610062532, 1, 1)
(6, 'cus_8d1b6b', 247012447, 2, 1)
(9, 'cus_8d1b6b', 1610062532, 0, 0)
(12, 'cus_8d1b6b', 1871297066, 1, 1)
(15, 'cus_8d1b6b', 1744686505, 0, 0)
*/

-- Prediction Query
SELECT A.INVOICE_ID, D.CUSTOMER_NAME, MAX(A.PRICE) AS PRICE, COALESCE(COUNT(B.CONTACT_NAME), 0) AS CONTACTS_CNT, COALESCE(COUNT(C.EMAIL), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CONTACTS AS B ON A.USER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS C ON B.CONTACT_EMAIL = C.EMAIL LEFT JOIN CUSTOMERS AS D ON A.USER_ID = D.CUSTOMER_ID GROUP BY A.INVOICE_ID ORDER BY A.INVOICE_ID, D.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'cus_8d1b6b', 247012447, 3, 1)
(2, 'cus_8d1b6b', 1258409369, 4, 4)
(3, 'cus_8d1b6b', None, 4, 4)
(4, 'cus_8d1b6b', 1610062532, 4, 4)
(6, 'cus_8d1b6b', 247012447, 5, 4)
(9, 'cus_8d1b6b', 1610062532, 0, 0)
(12, 'cus_8d1b6b', 1871297066, 4, 4)
(15, 'cus_8d1b6b', 1744686505, 0, 0)
*/