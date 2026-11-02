-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c1__55e888', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c1__55e888', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, '!', '%');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, '!', 'C');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'I', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'I', 'D');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, '@', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, '@', 'a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'A', '$');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'A', 'E');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'A', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'A', 'a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, '@', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, '@', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, '$', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, '$', 'c');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'B', '%');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'B', 'b');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, '@', 'M');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, '@', 'N');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, '@', 'S');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, '@', 'r');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'P', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'P', '&');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, '@', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, '@', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'c_s_5574fb', 'c2__6dde60');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'c_s_5574fb', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'c_s_5574fb', NULL);

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'c_s_5574fb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'I');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c1__55e888', 1, 1, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(C2.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON C1.CUSTOMER_ID = I.USER_ID LEFT JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS C2 ON C.CONTACT_NAME = C2.CUSTOMER_NAME GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c1__55e888', 1, 29, 13)
*/