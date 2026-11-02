-- Schema DDL
CREATE TABLE "Ref_Payment_Methods" ("payment_method_code" TEXT(10) PRIMARY KEY, "payment_method_description" TEXT(80));

CREATE TABLE "Ref_Service_Types" ("Service_Type_Code" TEXT(15) PRIMARY KEY, "Parent_Service_Type_Code" TEXT(15), "Service_Type_Description" TEXT(255));

CREATE TABLE "Addresses" ("Address_ID" TEXT(100) PRIMARY KEY, "Line_1" TEXT(255), "Line_2" TEXT(255), "City_Town" TEXT(255), "State_County" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Products" ("Product_ID" TEXT(100) PRIMARY KEY, "Product_Name" TEXT(255), "Product_Price" REAL(20, 4), "Product_Description" TEXT(255), "Other_Product_Service_Details" TEXT(255));

CREATE TABLE "Marketing_Regions" ("Marketing_Region_Code" TEXT(15) PRIMARY KEY, "Marketing_Region_Name" TEXT(255), "Marketing_Region_Descriptrion" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Clients" ("Client_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Customer_Email_Address" TEXT(255), "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Drama_Workshop_Groups" ("Workshop_Group_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Currency_Code" TEXT(15), "Marketing_Region_Code" TEXT(15), "Store_Name" TEXT(255), "Store_Phone" TEXT(255), "Store_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Performers" ("Performer_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Customer_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Customers" ("Customer_ID" TEXT(100) PRIMARY KEY, "Address_ID" INTEGER, "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Customer_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Stores" ("Store_ID" TEXT(100) PRIMARY KEY, "Marketing_Region_Code" TEXT(15), "Address_ID" INTEGER, "Store_Name" TEXT(255), "Store_Phone" TEXT(255), "Store_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Marketing_Region_Code") REFERENCES "Marketing_Regions" ("Marketing_Region_Code"), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Bookings" ("Booking_ID" INTEGER PRIMARY KEY, "Workshop_Group_ID" TEXT(100), "Customer_ID" INTEGER, "Status_Code" TEXT(15), "Store_ID" INTEGER, "Order_Date" DATETIME, "Planned_Delivery_Date" DATETIME, "Actual_Delivery_Date" DATETIME, "Other_Order_Details" TEXT(255), FOREIGN KEY ("Workshop_Group_ID") REFERENCES "Drama_Workshop_Groups" ("Workshop_Group_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Clients" ("Client_ID"));

CREATE TABLE "Performers_in_Bookings" ("Order_ID" INTEGER, "Performer_ID" INTEGER, PRIMARY KEY ("Order_ID", "Performer_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Bookings" ("Booking_ID"), FOREIGN KEY ("Performer_ID") REFERENCES "Performers" ("Performer_ID"));

CREATE TABLE "Customer_Orders" ("Order_ID" INTEGER PRIMARY KEY, "Store_ID" INTEGER, "Customer_ID" INTEGER, "Order_Date" DATETIME, "Planned_Delivery_Date" DATETIME, "Actual_Delivery_Date" DATETIME, "Other_Order_Details" TEXT(255), FOREIGN KEY ("Store_ID") REFERENCES "Stores" ("Store_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Order_Items" ("Order_Item_ID" INTEGER PRIMARY KEY, "Product_ID" INTEGER, "Order_ID" INTEGER, "Order_Quantity" TEXT(288), "Other_Item_Details" TEXT(255), FOREIGN KEY ("Product_ID") REFERENCES "Products" ("Product_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Customer_Orders" ("Order_ID"));

CREATE TABLE "Invoices" ("Invoice_ID" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "Order_ID" INTEGER, "Product_ID" INTEGER, "Order_Quantity" TEXT(288), "Other_Item_Details" TEXT(255), "Order_Item_ID" INTEGER, FOREIGN KEY ("payment_method_code") REFERENCES "Ref_Payment_Methods" ("payment_method_code"), FOREIGN KEY ("Order_ID") REFERENCES "Customer_Orders" ("Order_ID"));

CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15), "Workshop_Group_ID" INTEGER, "Product_Description" TEXT(255), "Product_Name" TEXT(255), "Product_Price" REAL(20, 4), "Other_Product_Service_Details" TEXT(255), FOREIGN KEY ("Service_Type_Code") REFERENCES "Ref_Service_Types" ("Service_Type_Code"), FOREIGN KEY ("Workshop_Group_ID") REFERENCES "Drama_Workshop_Groups" ("Workshop_Group_ID"));

CREATE TABLE "Bookings_Services" ("Order_ID" INTEGER UNIQUE, "Product_ID" INTEGER UNIQUE, PRIMARY KEY ("Order_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "Services" ("Service_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Bookings" ("Booking_ID"));

CREATE TABLE "Invoice_Items" ("Invoice_Item_ID" INTEGER PRIMARY KEY, "Order_ID" INTEGER, "Product_ID" INTEGER, "Invoice_ID" INTEGER, "Order_Item_ID" INTEGER, "Order_Quantity" INTEGER, "Other_Item_Details" TEXT(255), FOREIGN KEY ("Order_ID") REFERENCES "Bookings_Services" ("Order_ID"), FOREIGN KEY ("Product_ID") REFERENCES "Bookings_Services" ("Product_ID"), FOREIGN KEY ("Invoice_ID") REFERENCES "Invoices" ("Invoice_ID"), FOREIGN KEY ("Order_Item_ID") REFERENCES "Order_Items" ("Order_Item_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('396 Tyler Road Suite 473
Evansland, UT 08353', 'coach', 'less', 'Washingtonborough', 'Michigan', 'policy');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('9748 Melanie Meadows Apt. 456
Brandonton, OK 74139', 'coach', 'less', 'Washingtonborough', 'Michigan', 'policy');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('68784 David Court Suite 558
Kariborough, PA 67232', 'interest', 'month', 'North Benjaminmouth', 'New Mexico', 'natural');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('8970 April Points
Whitneyfort, NC 49892', 'interest', 'month', 'North Benjaminmouth', 'New Mexico', 'natural');
INSERT INTO "ref_service_types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('charge', 'form', 'Safe team wish candidate have no.');
INSERT INTO "ref_service_types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('head', 'form', 'Safe team wish candidate have no.');
INSERT INTO "ref_service_types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('loss', 'church', 'Throw cause use five hotel pattern successful order.');
INSERT INTO "ref_service_types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('kid', 'church', 'Throw cause use five hotel pattern successful order.');
INSERT INTO "drama_workshop_groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (1147, '396 Tyler Road Suite 473
Evansland, UT 08353', 'from', 'effort', 'Derek Wright', '704-569-6325', 'stephanie24@example.org', 'president');
INSERT INTO "drama_workshop_groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (1151, '396 Tyler Road Suite 473
Evansland, UT 08353', 'from', 'effort', 'Derek Wright', '704-569-6325', 'stephanie24@example.org', 'president');
INSERT INTO "drama_workshop_groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (1153, '68784 David Court Suite 558
Kariborough, PA 67232', 'movement', 'them', 'Katherine Hart', '627-585-8549x73348', 'tyronerobertson@example.com', 'until');
INSERT INTO "drama_workshop_groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (1157, '68784 David Court Suite 558
Kariborough, PA 67232', 'movement', 'them', 'Katherine Hart', '627-585-8549x73348', 'tyronerobertson@example.com', 'until');
INSERT INTO "services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (1148, 'charge', 1147, 'Market bed hotel lead drive.', 'film', 1149.5, 'past');
INSERT INTO "services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (1152, 'charge', NULL, 'Market bed hotel lead drive.', 'film', 1149.5, 'past');
INSERT INTO "services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (1154, 'loss', 1153, 'Challenge quite all way body affect.', 'film', 1155.5, 'former');
INSERT INTO "services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (1158, 'loss', NULL, 'Challenge quite all way body affect.', 'film', 1155.5, 'former');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "store_phone", "store_email_address" FROM (SELECT "LHS"."workshop_group_id" AS "workshop_group_id", "LHS"."address_id" AS "address_id", "LHS"."currency_code" AS "currency_code", "LHS"."marketing_region_code" AS "marketing_region_code", "LHS"."store_name" AS "store_name", "LHS"."store_phone" AS "store_phone", "LHS"."store_email_address" AS "store_email_address", "LHS"."other_details" AS "other_details", "RHS"."service_id" AS "service_id", "RHS"."service_type_code" AS "service_type_code", "RHS"."product_description" AS "product_description", "RHS"."product_name" AS "product_name", "RHS"."product_price" AS "product_price", "RHS"."other_product_service_details" AS "other_product_service_details" FROM "drama_workshop_groups" AS "LHS" LEFT JOIN "services" AS "RHS" ON ("LHS"."workshop_group_id" = "RHS"."workshop_group_id")) WHERE ("product_name" = 'film') ORDER BY store_phone, "store_phone" NULLS LAST, "store_email_address" NULLS LAST;

/*
Gold Result:
('627-585-8549x73348', 'tyronerobertson@example.com')
('704-569-6325', 'stephanie24@example.org')
*/

-- Prediction Query
SELECT T1.Store_Phone, T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID = T2.Workshop_Group_ID WHERE T2.Product_Name = 'film';

/*
Prediction Result:
('704-569-6325', 'stephanie24@example.org')
('627-585-8549x73348', 'tyronerobertson@example.com')
*/