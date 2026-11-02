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
-- DATASET 2
-- Tests ORDER BY store_phone (ASC vs DESC), tie-breaking on store_email_address (ASC vs DESC), and NULLS LAST vs NULLS FIRST on both columns
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('1', '200 Broadway', NULL, 'Gotham', 'NJ', NULL);
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('DIR', NULL, 'Directing');
-- Group 1: Phone '555-0102', Email 'a@test.com'
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (1, 1, 'USD', 'NA', 'Alpha', '555-0102', 'a@test.com', NULL);
-- Group 2: Phone '555-0101', Email 'z@test.com' (Inserted out of order to test primary sort)
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (2, 1, 'USD', 'NA', 'Beta', '555-0101', 'z@test.com', NULL);
-- Group 3: Phone '555-0101', Email 'a@test.com' (Tests secondary sort tie-breaker)
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (3, 1, 'USD', 'NA', 'Gamma', '555-0101', 'a@test.com', NULL);
-- Group 4: Phone '555-0101', Email NULL (Tests NULLS LAST on secondary sort column)
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (4, 1, 'USD', 'NA', 'Delta', '555-0101', NULL, NULL);
-- Group 5: Phone NULL, Email 'b@test.com' (Tests NULL handling on primary sort column)
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (5, 1, 'USD', 'NA', 'Epsilon', NULL, 'b@test.com', NULL);
-- Group 6: Phone NULL, Email NULL (Tests NULLS LAST when primary sort is also NULL)
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (6, 1, 'USD', 'NA', 'Zeta', NULL, NULL, NULL);
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (1, 'DIR', 1, 'S1', 'N1', 10.0, NULL);
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (2, 'DIR', 2, 'S2', 'N2', 20.0, NULL);
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (3, 'DIR', 3, 'S3', 'N3', 30.0, NULL);
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (4, 'DIR', 4, 'S4', 'N4', 40.0, NULL);
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (5, 'DIR', 5, 'S5', 'N5', 50.0, NULL);
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (6, 'DIR', 6, 'S6', 'N6', 60.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT store_phone, store_email_address FROM (SELECT LHS.workshop_group_id AS workshop_group_id, LHS.address_id AS address_id, LHS.currency_code AS currency_code, LHS.marketing_region_code AS marketing_region_code, LHS.store_name AS store_name, LHS.store_phone AS store_phone, LHS.store_email_address AS store_email_address, LHS.other_details AS other_details, RHS.service_id AS service_id, RHS.service_type_code AS service_type_code, RHS.product_description AS product_description, RHS.product_name AS product_name, RHS.product_price AS product_price, RHS.other_product_service_details AS other_product_service_details FROM drama_workshop_groups AS LHS INNER JOIN services AS RHS ON (LHS.workshop_group_id = RHS.workshop_group_id)) ORDER BY store_phone, store_email_address NULLS LAST;

/*
Gold Result:
(None, 'b@test.com')
(None, None)
('555-0101', 'a@test.com')
('555-0101', 'z@test.com')
('555-0101', None)
('555-0102', 'a@test.com')
*/

-- Prediction Query
SELECT T1.Store_Phone, T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID = T2.Workshop_Group_ID;

/*
Prediction Result:
('555-0102', 'a@test.com')
('555-0101', 'z@test.com')
('555-0101', 'a@test.com')
('555-0101', None)
(None, 'b@test.com')
(None, None)
*/