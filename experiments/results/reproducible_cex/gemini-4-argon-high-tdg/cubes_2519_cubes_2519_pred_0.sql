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
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (1, NULL, 'USD', 'NA', 'Main Workshop', '555-0100', 'main@workshop.com', 'Group 1');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('ST_A', 'P_3', 'Zebra Stage Design');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('ST_B', 'P_1', 'Alpha Audio Mixing');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('ST_C', 'P_2', 'Middle Lighting Rig');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('ST_D', 'P_4', 'Boundary Below Service');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('ST_E', 'P_5', 'Negative Price Service');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('ST_F', 'P_6', 'Null Price Service');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (1, 'ST_A', 1, 'Desc C', 'Name B', 250.0, 'Detail 1');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (2, 'ST_B', 1, 'Desc A', 'Name C', 100.01, 'Detail 2');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (3, 'ST_C', 1, 'Desc B', 'Name A', 100.0, 'Detail 3');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (4, 'ST_D', 1, 'Desc D', 'Name D', 99.99, 'Detail 4');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (5, 'ST_E', 1, 'Desc E', 'Name E', -150.0, 'Detail 5');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (6, 'ST_F', 1, 'Desc F', 'Name F', NULL, 'Detail 6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_type_description FROM (SELECT LHS.service_type_code AS service_type_code, LHS.parent_service_type_code AS parent_service_type_code, LHS.service_type_description AS service_type_description, RHS.service_id AS service_id, RHS.workshop_group_id AS workshop_group_id, RHS.product_description AS product_description, RHS.product_name AS product_name, RHS.product_price AS product_price, RHS.other_product_service_details AS other_product_service_details FROM ref_service_types AS LHS INNER JOIN services AS RHS ON (LHS.service_type_code = RHS.service_type_code)) WHERE (product_price >= 100.0) ORDER BY service_type_description;

/*
Gold Result:
('Alpha Audio Mixing',)
('Middle Lighting Rig',)
('Zebra Stage Design',)
*/

-- Prediction Query
SELECT T1.Service_Type_Description FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code = T2.Service_Type_Code WHERE T2.Product_Price > 100;

/*
Prediction Result:
('Zebra Stage Design',)
('Alpha Audio Mixing',)
*/