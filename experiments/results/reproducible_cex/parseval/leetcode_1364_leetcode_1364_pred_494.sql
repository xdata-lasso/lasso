-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_15498b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'b_s_4d0185', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'b_s_15498b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'b_s_4d0185', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'b_s_15498b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'b_s_4d0185', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'b_s_4d0185', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'b_s_4d0185', 'Q');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'b_s_4d0185', 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, NULL, 'a_s_5b0026');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, NULL, 'a_s_5b0026');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_5b0026', 'a_s_082e76');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'a_s_082e76');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'E', 'a_s_2ee1fb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'a_s_9d5cc5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'a_s_5b0026', 'a_s_082e76');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'a_s_5b0026', 'a_s_082e76');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483643, 'a_s_5b0026', 'a_s_2ee1fb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483644, 'a_s_5b0026', 'a_s_9d5cc5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'a_s_082e76');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'a', 'a_s_2ee1fb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'a_s_9d5cc5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483640, 'a_s_5b0026', 'a_s_082e76');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483635, 'a_s_5b0026', 'a_s_9d5cc5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_3d853b', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_e3aace', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483640, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, -2147483646, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, -2147483640, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483645, 'b_s_4d0185', 1, 0, 0)
(-2147483644, 'b_s_4d0185', 1, 1, 1)
(-2147483643, 'b_s_15498b', 1, 1, 1)
(-1, 'b_s_15498b', 1, 3, 0)
(0, 'b_s_15498b', 1, 3, 0)
(1, 'b_s_15498b', 1, 1, 1)
(2, 'b_s_15498b', 1, 1, 1)
(3, 'b_s_15498b', 1, 1, 1)
*/

-- Prediction Query
WITH CONTACTTYPES AS (SELECT A.USER_ID, COUNT(A.CONTACT_NAME) AS CONTACTS, COUNT(B.CUSTOMER_NAME) AS TRUSTED_CONTACTS FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY A.USER_ID) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COALESCE(C.CONTACTS, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTTYPES AS C ON A.USER_ID = C.USER_ID ORDER BY INVOICE_ID, B.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483645, 'b_s_4d0185', 1, 0, 0)
(-2147483644, 'b_s_4d0185', 1, 32, 18)
(-2147483643, 'b_s_15498b', 1, 32, 18)
(-1, 'b_s_15498b', 1, 3, 0)
(0, 'b_s_15498b', 1, 3, 0)
(1, 'b_s_15498b', 1, 32, 18)
(2, 'b_s_15498b', 1, 32, 18)
(3, 'b_s_15498b', 1, 32, 18)
*/