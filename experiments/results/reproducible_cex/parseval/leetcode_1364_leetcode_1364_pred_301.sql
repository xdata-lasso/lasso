-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_aee5d3', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'A', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'b_s_aee5d3', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'a_s_fd26e5', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'A', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'a_s_fd26e5', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'A', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'a_s_fd26e5', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'A', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'a_s_fd26e5', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'A', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'a_s_fd26e5', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483588, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483587, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483586, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483585, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483584, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483583, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483582, 'a_s_fd26e5', 'a_s_40ba20');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483581, 'cus_1a281c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483580, 'a_s_fd26e5', 'a_s_40ba20');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_40ba20', 'a_s_fd26e5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'a_s_40ba20', 'G');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'G', 'a_s_fd26e5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'a_s_40ba20', 'a_s_fd26e5');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'O', 'a_s_fd26e5');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 2, 1)
(-2147483645, 'cus_8d1b6b', 1, 2, 1)
(-2147483644, 'cus_8d1b6b', 1, 1, 1)
(-2147483643, 'b_s_aee5d3', 1, 2, 1)
(-2147483642, 'b_s_aee5d3', 1, 2, 1)
(-2147483641, 'b_s_aee5d3', 1, 2, 1)
(0, 'cus_8d1b6b', 1, 2, 1)
(1, 'b_s_aee5d3', 1, 2, 1)
(2, 'b_s_aee5d3', 1, 2, 1)
(3, 'b_s_aee5d3', 1, 2, 1)
*/

-- Prediction Query
WITH T1 AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT, SUM(TRUSTED_FLAG) AS TRUSTED_CONTACTS_CNT FROM (SELECT A.*, CASE WHEN NOT B.CUSTOMER_NAME IS NULL THEN 1 ELSE 0 END AS TRUSTED_FLAG FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_NAME = B.CUSTOMER_NAME AND A.CONTACT_EMAIL = B.EMAIL) AS C GROUP BY USER_ID) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COALESCE(C.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN T1 AS C ON A.USER_ID = C.USER_ID ORDER BY A.INVOICE_ID, B.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 2, 0)
(-2147483645, 'cus_8d1b6b', 1, 2, 0)
(-2147483644, 'cus_8d1b6b', 1, 22, 22)
(-2147483643, 'b_s_aee5d3', 1, 23, 22)
(-2147483642, 'b_s_aee5d3', 1, 23, 22)
(-2147483641, 'b_s_aee5d3', 1, 23, 22)
(0, 'cus_8d1b6b', 1, 2, 0)
(1, 'b_s_aee5d3', 1, 23, 22)
(2, 'b_s_aee5d3', 1, 23, 22)
(3, 'b_s_aee5d3', 1, 23, 22)
*/