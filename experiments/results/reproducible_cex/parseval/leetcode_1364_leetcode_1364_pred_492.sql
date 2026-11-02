-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c1__0546c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c1__0546c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', '+');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', '+');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'e');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', '`');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', '`');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', '0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', '0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', ',');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', ',');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'D');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'D');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', '(');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', '(');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', '!');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'cus_8d1b6b', '@');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'cus_8d1b6b', 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, NULL, 'ct__9cd641');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'cus_8d1b6b', 'ct__9cd641');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__9cd641', 'ct__83e957');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '+', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'A', 'e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'e', '"');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 's', 'a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'G', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '!', '"');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '"', 'a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '0', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'A', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'O', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, ',', '#');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'j', ')');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'D', ')');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'a', '-');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '#', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, '`', 'a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '@', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'K', '$');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'c1__0546c1', 1, 7, 3)
(0, 'c1__0546c1', 1, 7, 3)
(1, 'c1__0546c1', 1, 7, 3)
*/

-- Prediction Query
SELECT INVOICE_ID, C1.CUSTOMER_NAME, PRICE, COUNT(CT.CONTACT_NAME) AS CONTACTS_CNT, COUNT(C2.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS CT ON CT.USER_ID = I.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CT.CONTACT_EMAIL = C2.EMAIL GROUP BY INVOICE_ID ORDER BY INVOICE_ID, C1.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'c1__0546c1', 1, 29, 25)
(0, 'c1__0546c1', 1, 29, 25)
(1, 'c1__0546c1', 1, 29, 25)
*/