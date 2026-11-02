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
INSERT INTO Addresses (Address_ID, Line_1, Line_2, City_Town, State_County, Other_Details) VALUES ('1', '100 Main St', 'Suite 1', 'Springfield', 'IL', 'HQ');
INSERT INTO Marketing_Regions (Marketing_Region_Code, Marketing_Region_Name, Marketing_Region_Descriptrion, Other_Details) VALUES ('MR1', 'North', 'Northern Region', 'Active');
INSERT INTO Ref_Service_Types (Service_Type_Code, Parent_Service_Type_Code, Service_Type_Description) VALUES ('ST1', NULL, 'Stage Lighting');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('PM1', 'Credit Card');
INSERT INTO Drama_Workshop_Groups (Workshop_Group_ID, Address_ID, Currency_Code, Marketing_Region_Code, Store_Name, Store_Phone, Store_Email_Address, Other_Details) VALUES (1, 1, 'USD', 'MR1', 'Main Workshop', '555-0100', 'workshop@example.com', 'None');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (1, 'ST1', 1, 'High End Service', 'Service Only Item', 999.99, 'Not a product');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name, Customer_Phone, Customer_Email_Address, Other_Details) VALUES ('1', 1, 'Alice Smith', '555-0101', 'alice@example.com', 'VIP');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name, Store_Phone, Store_Email_Address, Other_Details) VALUES ('1', 'MR1', 1, 'Downtown Store', '555-0102', 'store@example.com', 'Open');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (1, 1, 1, '2023-01-10 10:00:00', '2023-01-15 10:00:00', '2023-01-14 10:00:00', 'First order');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('1', 'Beta Cable', 15.5, 'Audio cable', '3 meters');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('2', 'Zebra Spotlight', 250.0, 'Stage spotlight', 'LED');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('3', 'Gamma Stand', 120.0, 'Mic stand', 'Adjustable');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('4', 'Alpha Microphone', 250.0, 'Wireless mic', 'UHF');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (1, 1, 1, '5', 'Standard');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (2, 3, 1, '2', 'Standard');
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (1, 'PM1', 1, 1, '5', 'Paid', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_name_other AS product_name FROM (SELECT LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_price AS product_price, LHS.product_description AS product_description, LHS.other_product_service_details AS other_product_service_details, LHS.maxproduct_price AS maxproduct_price, RHS.product_id AS product_id_other, RHS.product_name AS product_name_other, RHS.product_price AS product_price_other, RHS.product_description AS product_description_other, RHS.other_product_service_details AS other_product_service_details_other, RHS.maxproduct_price AS maxproduct_price_other FROM (SELECT product_id, product_name, product_price, product_description, other_product_service_details, MAX(product_price) OVER () AS maxproduct_price FROM products) AS LHS CROSS JOIN (SELECT product_id, product_name, product_price, product_description, other_product_service_details, MAX(product_price) OVER () AS maxproduct_price FROM products) AS RHS) WHERE (product_price_other = maxproduct_price_other) ORDER BY product_name;

/*
Gold Result:
('Alpha Microphone',)
('Zebra Spotlight',)
*/

-- Prediction Query
SELECT Product_Name FROM PRODUCTS ORDER BY Product_Price DESC, PRODUCTS.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra Spotlight',)
*/