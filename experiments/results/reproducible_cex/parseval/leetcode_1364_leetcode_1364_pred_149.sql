-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_c79569', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'co__b7bd63', 'co__6772da');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'co__b7bd63', 'co__6772da');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'G', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'co__b7bd63', 'co__6772da');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'I', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'co__b7bd63', 'co__6772da');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'G', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'A', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__31d220', 'co__0f3a1d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'co__6772da', 'co__b7bd63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (8, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'co__6772da', 'co__b7bd63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'co__6772da', 'co__b7bd63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (10, 'co__6772da', 'co__b7bd63');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 6, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 5, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, -2147483639, 2);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (5, 2, 1258409369);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 1, 2);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (8, -2147483647, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, 7, 1610062532);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (10, 10, 2);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (11, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (12, 10, 1871297066);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c_s_c79569', 1, 1, 0)
(2, 'A', 2, 0, 0)
(3, 'cus_8d1b6b', 1, 1, 1)
(4, 'cus_8d1b6b', 247012447, 1, 1)
(5, 'cus_8d1b6b', 1258409369, 1, 1)
(6, 'c_s_c79569', 2, 1, 0)
(7, 'cus_8d1b6b', 1744686505, 1, 0)
(8, 'co__b7bd63', 1, 0, 0)
(9, 'cus_8d1b6b', 1610062532, 1, 1)
(10, 'cus_8d1b6b', 2, 1, 1)
(11, 'cus_8d1b6b', 1, 1, 1)
(12, 'cus_8d1b6b', 1871297066, 1, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(DISTINCT CO.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(DISTINCT C2.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN CONTACTS AS CO ON C.CUSTOMER_ID = CO.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CO.CONTACT_NAME = C2.CUSTOMER_NAME AND CO.CONTACT_EMAIL = C2.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c_s_c79569', 1, 1, 0)
(2, 'A', 2, 0, 0)
(3, 'cus_8d1b6b', 1, 1, 4)
(4, 'cus_8d1b6b', 247012447, 1, 4)
(5, 'cus_8d1b6b', 1258409369, 1, 4)
(6, 'c_s_c79569', 2, 1, 0)
(7, 'cus_8d1b6b', 1744686505, 1, 0)
(8, 'co__b7bd63', 1, 0, 0)
(9, 'cus_8d1b6b', 1610062532, 1, 4)
(10, 'cus_8d1b6b', 2, 1, 4)
(11, 'cus_8d1b6b', 1, 1, 4)
(12, 'cus_8d1b6b', 1871297066, 1, 4)
*/