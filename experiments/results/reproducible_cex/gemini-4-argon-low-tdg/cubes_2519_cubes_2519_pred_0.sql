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
-- DATASET 1
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('ADDR1', '123 Main St', 'Apt 1', 'Metropolis', 'NY', 'None');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (1, 'ADDR1', 'USD', 'NA', 'Main Store', '555-0100', 'store@example.com', 'None');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('STC_A', 'STC_B', 'Zeta Service');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('STC_B', 'STC_A', 'Alpha Service');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('STC_C', NULL, 'Beta Service');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('STC_D', 'STC_C', 'Omega Unmatched Service');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (10, 'STC_A', 1, 'Prod Desc A1', 'Prod Name A1', 100.0, 'Boundary Exact');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (20, 'STC_A', 1, 'Prod Desc A2', 'Prod Name A2', 150.5, 'Duplicate Service Type above 100');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (30, 'STC_B', 1, 'Prod Desc B1', 'Prod Name B1', 250.0, 'Normal above 100');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (40, 'STC_C', 1, 'Prod Desc C1', 'Prod Name C1', 99.9999, 'Just below 100');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (50, 'STC_C', 1, 'Prod Desc C2', 'Prod Name C2', NULL, 'Null Price');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (60, NULL, 1, 'Prod Desc Null', 'Prod Name Null', 500.0, 'Null Service Type Code');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P1', 'Decoy Product', 300.0, 'Decoy Product Desc', 'Decoy Details');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_type_description FROM (SELECT LHS.service_type_code AS service_type_code, LHS.parent_service_type_code AS parent_service_type_code, LHS.service_type_description AS service_type_description, RHS.service_id AS service_id, RHS.workshop_group_id AS workshop_group_id, RHS.product_description AS product_description, RHS.product_name AS product_name, RHS.product_price AS product_price, RHS.other_product_service_details AS other_product_service_details FROM ref_service_types AS LHS INNER JOIN services AS RHS ON (LHS.service_type_code = RHS.service_type_code)) WHERE (product_price >= 100.0) ORDER BY service_type_description;

/*
Gold Result:
('Alpha Service',)
('Zeta Service',)
('Zeta Service',)
*/

-- Prediction Query
SELECT T1.Service_Type_Description FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code = T2.Service_Type_Code WHERE T2.Product_Price > 100;

/*
Prediction Result:
('Zeta Service',)
('Alpha Service',)
*/