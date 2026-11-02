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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1015, 'treatment', 'Michael Cross', '1983-10-20', 'would');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1016, 'institution', 'Mary Tucker', '1983-10-21', 'baby');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1017, 'weight', 'Daniel Brown', '1983-10-22', 'act');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1018, 'artist', 'Amy Edwards', '1983-10-23', 'low');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1019, 'community', 'John Calhoun', '1983-10-24', 'pretty');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1020, 'hundred', 'Amy Romero', '1983-10-25', 'order');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1021, 'able', 'Andrea Jones', '1983-10-26', 'black');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1022, 'in', 'Jennifer David', '1983-10-27', 'back');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1023, 'evidence', 'Lauren Williams', '1983-10-28', 'note');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1024, 'with', 'Matthew Cunningham', '1983-10-29', 'different');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1025, 'step', 'Dean Santiago', '1983-10-30', 'move');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1026, 'still', 'Derek Anderson', '1983-10-31', 'cause');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1027, 'look', 'Joyce Hickman', '1983-11-01', 'worker');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1028, 'join', 'Stephanie Dalton', '1993-05-13', 'city');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1029, 'various', 'Paula Robinson', '1993-05-14', 'during');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1030, 'professional', 'Melissa Marshall', '1993-05-15', 'identify');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1031, 'parent', 'Sylvia Martinez', '1993-05-16', 'rule');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1032, 'day', 'John Schmidt', '1993-05-17', 'claim');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1033, 'serious', 'Emily Fischer', '1993-05-18', 'seat');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1034, 'same', 'Robert Mcclain', '1993-05-19', 'difficult');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1035, 'if', 'Terry Griffin', '1993-05-20', 'attack');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1036, 'miss', 'Scott Cole', '1993-05-21', 'involve');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1037, 'instead', 'Sara Ramirez', '1993-05-22', 'give');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1038, 'either', 'Kari Allen', '1993-05-23', 'occur');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1039, 'choose', 'Micheal Young', '1993-05-24', 'man');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1040, 'reality', 'Steven Miller', '1993-05-25', 'just');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (28, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (48, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (58, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (68, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (78, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (88, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (98, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (108, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (118, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (128, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (138, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (148, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (158, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (-72, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (38, NULL, NULL, NULL, NULL);
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (28.0, 'direction', '1996-01-10', '1980-03-23', '249.489.4134x3524');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (48.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (58.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (68.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (78.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (88.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (98.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (108.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (118.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (128.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (138.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (148.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (158.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-72.0, 'single', '1996-01-10', '2021-01-01', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (38.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (48.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (58.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (68.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (78.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (88.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (98.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (108.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (118.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (128.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (138.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (148.0, 'single', '2099-12-31', '2099-12-31', '900-984-2710x947');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code, contact_number FROM (SELECT * FROM (SELECT * FROM customer_contact_channels ORDER BY active_from_date, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST) LIMIT 17);

/*
Gold Result:
('single', '900-984-2710x947')
('direction', '249.489.4134x3524')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
('single', '900-984-2710x947')
*/

-- Prediction Query
SELECT channel_code, contact_number FROM customer_contact_channels WHERE active_to_date - active_from_date = (SELECT active_to_date - active_from_date FROM customer_contact_channels ORDER BY (active_to_date - active_from_date) DESC, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_from_date NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST LIMIT 1);

/*
Prediction Result:
('single', '900-984-2710x947')
*/