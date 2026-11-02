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
-- DATASET 3
INSERT INTO "Addresses" ("Address_ID", "Line_1") VALUES ('99', '999 Oak St');
INSERT INTO "Marketing_Regions" ("Marketing_Region_Code", "Marketing_Region_Name") VALUES ('AP', 'Asia Pacific');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Service_Type_Description") VALUES ('S3', 'Basic');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (10, '99', 'AP', 'NullPhone1', NULL, 'b_email@example.com');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (20, '99', 'AP', 'NullPhone2', NULL, 'a_email@example.com');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (30, '99', 'AP', 'NullPhoneAndEmail', NULL, NULL);
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (40, '99', 'AP', 'ValidPhoneNullEmail', '100-0000', NULL);
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (50, '99', 'AP', 'ValidPhoneValidEmail1', '100-0000', 'z_email@example.com');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (60, '99', 'AP', 'ValidPhoneValidEmail2', '100-0000', 'm_email@example.com');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address") VALUES (70, '99', 'AP', 'SecondPhone', '200-0000', 'a_email@example.com');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (1, 'S3', 10, 'film');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (2, 'S3', 20, 'film');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (3, 'S3', 30, 'film');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (4, 'S3', 40, 'film');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (5, 'S3', 50, 'film');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (6, 'S3', 60, 'film');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Name") VALUES (7, 'S3', 70, 'film');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "store_phone", "store_email_address" FROM (SELECT "LHS"."workshop_group_id" AS "workshop_group_id", "LHS"."address_id" AS "address_id", "LHS"."currency_code" AS "currency_code", "LHS"."marketing_region_code" AS "marketing_region_code", "LHS"."store_name" AS "store_name", "LHS"."store_phone" AS "store_phone", "LHS"."store_email_address" AS "store_email_address", "LHS"."other_details" AS "other_details", "RHS"."service_id" AS "service_id", "RHS"."service_type_code" AS "service_type_code", "RHS"."product_description" AS "product_description", "RHS"."product_name" AS "product_name", "RHS"."product_price" AS "product_price", "RHS"."other_product_service_details" AS "other_product_service_details" FROM "drama_workshop_groups" AS "LHS" LEFT JOIN "services" AS "RHS" ON ("LHS"."workshop_group_id" = "RHS"."workshop_group_id")) WHERE ("product_name" = 'film') ORDER BY store_phone, "store_phone" NULLS LAST, "store_email_address" NULLS LAST;

/*
Gold Result:
(None, 'a_email@example.com')
(None, 'b_email@example.com')
(None, None)
('100-0000', 'm_email@example.com')
('100-0000', 'z_email@example.com')
('100-0000', None)
('200-0000', 'a_email@example.com')
*/

-- Prediction Query
SELECT T1.Store_Phone, T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID = T2.Workshop_Group_ID WHERE T2.Product_Name = 'film';

/*
Prediction Result:
(None, 'b_email@example.com')
(None, 'a_email@example.com')
(None, None)
('100-0000', None)
('100-0000', 'z_email@example.com')
('100-0000', 'm_email@example.com')
('200-0000', 'a_email@example.com')
*/