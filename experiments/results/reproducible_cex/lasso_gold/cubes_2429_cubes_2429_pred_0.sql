-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1109, 'occur', 'Kevin Shaw', '1984-07-04', 'voice');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1110, 'ask', 'Brooke Yu', '1984-07-05', 'over');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1111, 'small', 'Cody Larson', '1984-07-06', 'employee');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1112, 'former', 'Cynthia Wilson', '1984-07-07', 'particular');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1121, 'evidence', 'Joyce Hickman', '1992-04-12', 'authority');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1122, 'individual', 'Alexandra Howell', '1992-04-13', 'until');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1123, 'catch', 'Ariel Medina', '1992-04-14', 'election');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1124, 'remain', 'Brandi Bailey', '1992-04-15', 'hope');
INSERT INTO "products" ("product_id", "product_details") VALUES (1113, 'phone');
INSERT INTO "products" ("product_id", "product_details") VALUES (1114, 'among');
INSERT INTO "products" ("product_id", "product_details") VALUES (1115, 'president');
INSERT INTO "products" ("product_id", "product_details") VALUES (1116, 'beat');
INSERT INTO "products" ("product_id", "product_details") VALUES (1125, 'feel');
INSERT INTO "products" ("product_id", "product_details") VALUES (1126, 'coach');
INSERT INTO "products" ("product_id", "product_details") VALUES (1127, 'left');
INSERT INTO "products" ("product_id", "product_details") VALUES (1128, 'these');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1117, 1109, 'kind', '1988-11-08', 'necessary');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1118, 1109, 'really', '1988-11-09', 'four');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1119, 1109, 'past', '1988-11-10', 'worry');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1120, 1109, 'other', '1988-11-11', 'every');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1129, 1121, 'of', '1996-08-16', 'surface');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1130, 1121, 'score', '1996-08-17', 'ready');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1131, 1121, 'five', '1996-08-18', 'newspaper');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1132, 1121, 'population', '1996-08-19', 'across');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1117, 1113, 'democratic');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1117, 1113, 'relationship');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1117, 1113, 'sense');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1117, 1113, 'edge');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1129, 1125, 'region');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1129, 1125, 'technology');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1129, 1125, 'once');
INSERT INTO "order_items" ("order_id", "product_id", "order_quantity") VALUES (1129, 1125, 'firm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_details, product_id FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.product_id AS product_id, LHS.product_details AS product_details, RHS.order_id AS order_id, RHS.order_quantity AS order_quantity FROM products AS LHS INNER JOIN order_items AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_id) LIMIT 1);

/*
Gold Result:
('phone', 1113)
*/

-- Prediction Query
SELECT t2.product_details, t2.product_id FROM order_items AS t1 JOIN products AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_id ORDER BY SUM(t1.order_quantity), t2.product_details NULLS LAST, t2.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('feel', 1125)
*/