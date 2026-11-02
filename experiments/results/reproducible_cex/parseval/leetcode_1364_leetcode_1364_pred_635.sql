-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'con_581341');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_14e4ac', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_14e4ac', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'C', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_14e4ac', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, '#', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'q', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, '#', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, '$', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, '9', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'c', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, '@', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'A', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'A', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, '3', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, '$', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'A', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_8d1b6b', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 's', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'c', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483588, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483587, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483586, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483585, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483584, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483583, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483582, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483581, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483580, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483579, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483578, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483577, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483576, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483575, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483574, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483573, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483572, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483571, NULL, 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483570, NULL, 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483569, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483568, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483567, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483566, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483565, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483564, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483563, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483562, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483561, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483560, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483559, 'cus_8d1b6b', 'con_2c87f4');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483558, 'cus_8d1b6b', 'con_2c87f4');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_993b3e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_2c87f4', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_581341', 'con_28c040');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_4114a4', 'con_2a13e4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_993b3e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_2c87f4', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'I', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'G', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_993b3e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_2c87f4', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '_', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'O', 'con_bd7032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483634, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483648, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 4, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 3, 2);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 5, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 5, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 5, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1644814318);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483648, 'cus_14e4ac', 1, 8, 6)
(-2147483644, 'cus_8d1b6b', 247012447, 0, 0)
(-2147483643, 'cus_8d1b6b', 1744686505, 0, 0)
(-2147483642, 'cus_8d1b6b', 1115440883, 0, 0)
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 2, 1, 1)
(1, 'cus_14e4ac', 1, 8, 6)
(2, 'cus_14e4ac', 1644814318, 8, 6)
(3, 'cus_14e4ac', 1, 8, 6)
*/

-- Prediction Query
WITH A AS (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, I.USER_ID FROM INVOICES AS I JOIN CUSTOMERS AS CUS ON I.USER_ID = CUS.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST, CUS.customer_id NULLS LAST), B AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), C AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CON JOIN CUSTOMERS AS CUS ON CUS.EMAIL = CON.CONTACT_EMAIL WHERE CON.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT A.INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, COALESCE(B.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM A LEFT JOIN B ON A.USER_ID = B.USER_ID LEFT JOIN C ON B.USER_ID = C.USER_ID ORDER BY INVOICE_ID, A.INVOICE_ID NULLS LAST, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483648, 'cus_14e4ac', 1, 8, 79)
(-2147483644, 'cus_8d1b6b', 247012447, 0, 0)
(-2147483643, 'cus_8d1b6b', 1744686505, 0, 0)
(-2147483642, 'cus_8d1b6b', 1115440883, 0, 0)
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 2, 1, 73)
(1, 'cus_14e4ac', 1, 8, 79)
(2, 'cus_14e4ac', 1644814318, 8, 79)
(3, 'cus_14e4ac', 1, 8, 79)
*/