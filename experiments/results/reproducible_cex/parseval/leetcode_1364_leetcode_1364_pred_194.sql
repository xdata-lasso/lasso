-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_e8b9d8', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'C');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'C');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'Z');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'Z');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'cus_8d1b6b', '?');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', '?');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, NULL, 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'cus_8d1b6b', 'o_s_b77407');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'cus_8d1b6b', 'o_s_b77407');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'o_s_b77407', 'o_s_c97f85');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'A', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'e', '$');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '#', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'c', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', '"');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'C', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'G', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '@', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'E', 'a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '!', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'B', '[');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'Z', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '"', '@');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c_s_e8b9d8', 1, 6, 4)
*/

-- Prediction Query
SELECT INVOICE_ID, C.CUSTOMER_NAME, PRICE, COUNT(O.CONTACT_NAME) AS CONTACTS_CNT, COUNT(A.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS O ON C.CUSTOMER_ID = O.USER_ID LEFT JOIN CUSTOMERS AS A ON A.EMAIL = O.CONTACT_EMAIL GROUP BY I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c_s_e8b9d8', 1, 39, 37)
*/