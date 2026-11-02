-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_79274a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'a_s_79274a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'O', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'G', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'G', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'b_s_d2ad74', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'd_s_2d2628', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'd_s_2d2628', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'b_s_b6e8c3', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'b_s_d2ad74');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', 'b_s_d2ad74');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'b_s_d2ad74');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (11, 'con_de12a6', 'b_s_b6e8c3');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (6, 'con_de12a6', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 11, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (10, 5, 1871297066);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'a_s_79274a', 1, 1, 0)
(2, 'a_s_79274a', 1, 1, 0)
(7, 'cus_8d1b6b', 247012447, 1, 0)
(10, 'a_s_79274a', 1871297066, 1, 0)
*/

-- Prediction Query
SELECT C.INVOICE_ID, A.CUSTOMER_NAME, C.PRICE, COUNT(B.CONTACT_NAME) AS CONTACTS_CNT, COUNT(DISTINCT D.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS C LEFT JOIN CUSTOMERS AS A ON A.CUSTOMER_ID = C.USER_ID LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS D ON B.CONTACT_NAME = D.CUSTOMER_NAME GROUP BY C.INVOICE_ID;

/*
Prediction Result:
(1, 'a_s_79274a', 1, 20, 1)
(2, 'a_s_79274a', 1, 20, 1)
(7, 'cus_8d1b6b', 247012447, 1, 1)
(10, 'a_s_79274a', 1871297066, 20, 1)
*/