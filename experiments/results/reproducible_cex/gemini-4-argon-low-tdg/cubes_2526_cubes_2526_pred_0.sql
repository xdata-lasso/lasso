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
INSERT INTO Ref_Service_Types (Service_Type_Code, Parent_Service_Type_Code, Service_Type_Description) VALUES ('CODE_2', 'CODE_1', NULL);
INSERT INTO Ref_Service_Types (Service_Type_Code, Parent_Service_Type_Code, Service_Type_Description) VALUES ('CODE_1', NULL, NULL);
INSERT INTO Ref_Service_Types (Service_Type_Code, Parent_Service_Type_Code, Service_Type_Description) VALUES ('CODE_3', 'CODE_2', 'Zebra Training');
INSERT INTO Ref_Service_Types (Service_Type_Code, Parent_Service_Type_Code, Service_Type_Description) VALUES ('CODE_0', 'CODE_3', 'Alpha Training');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (10, 'CODE_2', NULL, 'Desc A', 'Prod A', 10.0, 'Det A');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (20, 'CODE_1', NULL, 'Desc B', 'Prod B', 20.0, 'Det B');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (30, 'CODE_1', NULL, 'Desc C', 'Prod C', 30.0, 'Det C');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (40, 'CODE_3', NULL, 'Desc D', 'Prod D', 40.0, 'Det D');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (50, 'CODE_0', NULL, 'Desc E', 'Prod E', 50.0, 'Det E');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (60, 'CODE_0', NULL, 'Desc F', 'Prod F', 60.0, 'Det F');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (70, 'CODE_0', NULL, 'Desc G', 'Prod G', 70.0, 'Det G');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_type_description, service_type_code, n AS count___ FROM (SELECT service_type_code, service_type_description, COUNT(*) AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_type_code AS service_type_code, LHS.workshop_group_id AS workshop_group_id, LHS.product_description AS product_description, LHS.product_name AS product_name, LHS.product_price AS product_price, LHS.other_product_service_details AS other_product_service_details, RHS.parent_service_type_code AS parent_service_type_code, RHS.service_type_description AS service_type_description FROM services AS LHS INNER JOIN ref_service_types AS RHS ON (LHS.service_type_code = RHS.service_type_code)) GROUP BY service_type_code, service_type_description) ORDER BY service_type_description, service_type_code NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 'CODE_1', 2)
(None, 'CODE_2', 1)
('Alpha Training', 'CODE_0', 3)
('Zebra Training', 'CODE_3', 1)
*/

-- Prediction Query
SELECT T1.Service_Type_Description, T2.Service_Type_Code, COUNT(*) FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code = T2.Service_Type_Code GROUP BY T2.Service_Type_Code;

/*
Prediction Result:
('Alpha Training', 'CODE_0', 3)
(None, 'CODE_1', 2)
(None, 'CODE_2', 1)
('Zebra Training', 'CODE_3', 1)
*/