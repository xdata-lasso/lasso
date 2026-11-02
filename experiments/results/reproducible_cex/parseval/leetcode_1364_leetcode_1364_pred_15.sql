-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c1__edd780', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'm_s_4b2f54', '%');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'm_s_4b2f54', '%');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'A', 'D');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'A', 'D');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'm_s_4b2f54', '3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'm_s_4b2f54', '3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'A', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'A', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'm_s_4b2f54', '=');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'm_s_4b2f54', '=');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'm_s_4b2f54', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'm_s_4b2f54', '"');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'm_s_4b2f54', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'm_s_4b2f54', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'A', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'A', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'm_s_4b2f54', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'm_s_4b2f54', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'm_s_4b2f54', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'm_s_4b2f54', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'm_s_4b2f54', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'm_s_4b2f54', 'm_s_2cc0e2');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, 'm_s_4b2f54', 'm_s_2cc0e2');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'm_s_2cc0e2', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '%', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'A', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '!', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '#', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'D', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a', '?');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '3', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'B', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '"', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '3', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '6', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '!', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '#', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'I', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'G', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, '@', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'c', 'm_s_b1cbc6');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', '?');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'g', 'm_s_4b2f54');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '"', 'm_s_b1cbc6');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'c1__edd780', 1, 12, 7)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(M.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(C2.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS M ON C1.CUSTOMER_ID = M.USER_ID LEFT JOIN CUSTOMERS AS C2 ON M.CONTACT_NAME = C2.CUSTOMER_NAME AND M.CONTACT_EMAIL = C2.EMAIL GROUP BY I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'c1__edd780', 1, 35, 25)
*/