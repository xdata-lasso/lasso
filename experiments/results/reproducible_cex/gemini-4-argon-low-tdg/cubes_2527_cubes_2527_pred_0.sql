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
INSERT INTO Addresses (Address_ID, Line_1, City_Town) VALUES ('1', '10 Main St', 'TownA');
INSERT INTO Drama_Workshop_Groups (Workshop_Group_ID, Address_ID, Store_Name) VALUES (1, 1, 'Workshop A');
INSERT INTO Clients (Client_ID, Address_ID, Customer_Name) VALUES (1, 1, 'Client A');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (1, '1', 1, 'Z_STAT', 3, '2023-01-01', '2023-01-01', '2023-01-01');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (2, '1', 1, 'A_STAT', 3, '2023-01-02', '2023-01-01', '2023-01-02');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (3, '1', 1, 'A_STAT', 3, '2023-01-03', '2023-01-01', '2023-01-03');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (4, '1', 1, 'M_STAT', 2, '2023-02-01', '2023-02-01', '2023-02-01');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (5, '1', 1, 'W_STAT', 99, '2023-02-02', '2023-02-01', '2023-02-02');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (6, '1', 1, 'X_STAT', 3, '2023-03-01', '2023-03-01', '2023-03-01');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (7, '1', 1, 'N_STAT', 2, '2023-04-01', NULL, '2023-04-01');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date) VALUES (8, '1', 1, 'N_STAT', 2, '2023-04-02', NULL, '2023-04-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status_code FROM (SELECT LHS.planned_delivery_date AS planned_delivery_date, LHS.n AS n, RHS.booking_id AS booking_id, RHS.customer_id AS customer_id, RHS.workshop_group_id AS workshop_group_id, RHS.status_code AS status_code, RHS.order_date AS order_date, RHS.actual_delivery_date AS actual_delivery_date, RHS.other_order_details AS other_order_details FROM (SELECT planned_delivery_date, COUNT(*) AS n FROM bookings GROUP BY planned_delivery_date) AS LHS INNER JOIN bookings AS RHS ON (LHS.n = RHS.store_id AND LHS.planned_delivery_date = RHS.planned_delivery_date)) ORDER BY status_code;

/*
Gold Result:
('A_STAT',)
('A_STAT',)
('M_STAT',)
('Z_STAT',)
*/

-- Prediction Query
SELECT Status_Code FROM BOOKINGS GROUP BY Status_Code ORDER BY COUNT(*) DESC, Status_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_STAT',)
*/