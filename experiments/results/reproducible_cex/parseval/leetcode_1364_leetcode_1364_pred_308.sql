-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_78d92f', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'k', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'I', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'd', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'c_s_78d92f', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, '"', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'C', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'B', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'D', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'Q');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, '@', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'A', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, '#', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'B', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cus_8d1b6b', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, '#', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, NULL, 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, 'cus_8d1b6b', 'ct__1f7daf');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483588, 'cus_8d1b6b', 'ct__1f7daf');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__1f7daf', 'ct__37574f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__a35007', 'ct__a15fe4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__cb1d61', 'ct__b626b2');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'ct__37574f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'ct__a15fe4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'ct__1f7daf', 'ct__37574f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Q', 'ct__b626b2');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'ct__a15fe4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483611, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_78d92f', 1, 7, 2)
(-2147483644, 'c_s_78d92f', 1, 7, 2)
(-2147483643, 'c_s_78d92f', 1, 7, 2)
(-2147483642, 'c_s_78d92f', 1, 7, 2)
(-2147483641, 'c_s_78d92f', 1, 7, 2)
(-2147483640, 'c_s_78d92f', 1, 7, 2)
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'c_s_78d92f', 1, 7, 2)
(1, 'c_s_78d92f', 1, 7, 2)
*/

-- Prediction Query
WITH T1 AS (SELECT CT.USER_ID, COUNT(CT.CONTACT_NAME) AS CONTACTS_CNT, COUNT(C.EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CT LEFT JOIN CUSTOMERS AS C ON CT.CONTACT_EMAIL = C.EMAIL GROUP BY 1), T2 AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, I.INVOICE_ID, I.PRICE FROM CUSTOMERS AS C INNER JOIN INVOICES AS I ON I.USER_ID = C.CUSTOMER_ID) SELECT T2.INVOICE_ID, T2.CUSTOMER_NAME, T2.PRICE, COALESCE(T1.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(T1.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM T2 LEFT JOIN T1 ON T2.CUSTOMER_ID = T1.USER_ID ORDER BY 1, T2.INVOICE_ID NULLS LAST, T2.CUSTOMER_NAME NULLS LAST, T2.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_78d92f', 1, 36, 31)
(-2147483644, 'c_s_78d92f', 1, 36, 31)
(-2147483643, 'c_s_78d92f', 1, 36, 31)
(-2147483642, 'c_s_78d92f', 1, 36, 31)
(-2147483641, 'c_s_78d92f', 1, 36, 31)
(-2147483640, 'c_s_78d92f', 1, 36, 31)
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'c_s_78d92f', 1, 36, 31)
(1, 'c_s_78d92f', 1, 36, 31)
*/