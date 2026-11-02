-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cu__ae23b4', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, '!', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, '1', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'c', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, '@', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'C', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, '!', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, '0', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, '!', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'B', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, '@', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'A', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'Q', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'Q', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'S', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'A', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'C', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, '"', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'a', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'D', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'a', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, '!', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'B', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, '@', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cu2_45e077', 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, NULL, 'co__b3c168');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, NULL, 'co__b3c168');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__b3c168', 'co__952066');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'co__b3c168', 'I');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'co__8183fd', 'T');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '_', 'p');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__8183fd', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'cu__ae23b4', 1, 3, 1)
(2, 'cu__ae23b4', 1, 3, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE, COUNT(CO.CONTACT_NAME) AS CONTACTS_CNT, COUNT(CU2.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID LEFT JOIN CUSTOMERS AS CU2 ON CO.CONTACT_EMAIL = CU2.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, CU.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'cu__ae23b4', 1, 45, 29)
(2, 'cu__ae23b4', 1, 45, 29)
*/