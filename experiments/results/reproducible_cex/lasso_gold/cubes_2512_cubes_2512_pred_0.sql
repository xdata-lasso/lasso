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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('4739 Benson Overpass
North Derek, CA 59751', 'consider', 'way', 'Osbornmouth', 'Texas', 'hand');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('922 Kirby Port
Port Michelleland, AZ 84577', 'spend', 'part', 'Debrashire', 'Nebraska', 'prepare');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('security', 'Joshua Vance', 'today', 'coach');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('purpose', 'Stephen Gardner', 'quality', 'five');
INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description", "other_product_service_details") VALUES ('seek', 'Melody Thompson', 1065.5, 'Meeting building cut catch so ago.', 'once');
INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description", "other_product_service_details") VALUES ('meeting', 'Robert Sullivan', 1068.5, 'Authority art keep machine daughter parent fine.', 'serious');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('page', '4739 Benson Overpass
North Derek, CA 59751', 'Robert Arnold', '+1-711-346-7866x912', 'howens@example.com', 'career');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('from', '922 Kirby Port
Port Michelleland, AZ 84577', 'Shannon Hester', '(658)981-5371', 'donaldwilliams@example.com', 'treat');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('unit', 'security', '4739 Benson Overpass
North Derek, CA 59751', 'Kristen Matthews', '001-626-380-1824x22535', 'james84@example.org', 'process');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('power', 'purpose', '922 Kirby Port
Port Michelleland, AZ 84577', 'Victor Barrera', '995-532-7877x47016', 'brandywilliams@example.com', 'miss');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1066, 'unit', 'page', '1972-06-15', '1973-07-16', '1974-08-18', 'floor');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1069, 'power', 'from', '1975-09-18', '1976-10-19', '1974-08-17', 'picture');
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_quantity", "other_item_details") VALUES (1067, 'seek', 1066, '1', 'possible');
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_quantity", "other_item_details") VALUES (1070, 'meeting', 1069, '1', 'us');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actual_delivery_date FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.store_id AS store_id, LHS.order_date AS order_date, LHS.planned_delivery_date AS planned_delivery_date, LHS.actual_delivery_date AS actual_delivery_date, LHS.other_order_details AS other_order_details, RHS.order_item_id AS order_item_id, RHS.product_id AS product_id, RHS.order_quantity AS order_quantity, RHS.other_item_details AS other_item_details FROM customer_orders AS LHS INNER JOIN (SELECT * FROM order_items WHERE (order_quantity = 1)) AS RHS ON (LHS.order_id = RHS.order_id)) ORDER BY actual_delivery_date;

/*
Gold Result:
('1974-08-17',)
('1974-08-18',)
*/

-- Prediction Query
SELECT T1.Actual_Delivery_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID = T2.Order_ID WHERE T2.Order_Quantity = 1;

/*
Prediction Result:
('1974-08-18',)
('1974-08-17',)
*/