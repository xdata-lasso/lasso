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
INSERT INTO "Ref_Payment_Methods" ("payment_method_code", "payment_method_description") VALUES ('28', '-23');
INSERT INTO "Ref_Service_Types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('29', '-23', '-23');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('31', '-23', '-23', '-23', '-23', '-23');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('30', '-23', '-23', '-23', '-23', '-23');
INSERT INTO "Products" ("product_id", "product_name", "product_price", "product_description", "other_product_service_details") VALUES ('33', '47', -23, '48', '49');
INSERT INTO "Products" ("product_id", "product_name", "product_price", "product_description", "other_product_service_details") VALUES ('32', '47', -24, '-23', '-23');
INSERT INTO "Marketing_Regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('35', '-23', '-23', '-23');
INSERT INTO "Marketing_Regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('34', '-23', '-23', '-23');
INSERT INTO "Clients" ("client_id", "address_id", "customer_email_address", "customer_name", "customer_phone", "other_details") VALUES (36, '31', '-23', '-23', '-23', '-23');
INSERT INTO "Drama_Workshop_Groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (37, NULL, '-23', '-23', '-23', '-23', '-23', '-23');
INSERT INTO "Performers" ("performer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES (38, '31', '-23', '-23', '-23', '-23');
INSERT INTO "Customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('39', '30', '-23', '-23', '-23', '-23');
INSERT INTO "Stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('40', '34', '30', '-23', '-23', '-23', '-23');
INSERT INTO "Bookings" ("booking_id", "workshop_group_id", "customer_id", "status_code", "store_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (26, NULL, 36, '-23', -23, -23, -23, -23, '-23');
INSERT INTO "Performers_in_Bookings" ("order_id", "performer_id") VALUES (26, 38);
INSERT INTO "Customer_Orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (42, '40', '39', -23, -23, -23, '-23');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_quantity", "other_item_details") VALUES (43, '32', 42, '-23', '-23');
INSERT INTO "Invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (44, '28', 42, -23, '-23', '-23', -23);
INSERT INTO "Services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (27, '29', 37, '-23', '-23', -23, '-23');
INSERT INTO "Bookings_Services" ("order_id", "product_id") VALUES (26, 27);
INSERT INTO "Invoice_Items" ("invoice_item_id", "order_id", "product_id", "invoice_id", "order_item_id", "order_quantity", "other_item_details") VALUES (46, 26, 27, 44, 43, -23, '-23');
INSERT INTO "Invoice_Items" ("invoice_item_id", "order_id", "product_id", "invoice_id", "order_item_id", "order_quantity", "other_item_details") VALUES (45, 26, 27, 44, 43, -23, '-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_name_other AS product_name FROM (SELECT LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_price AS product_price, LHS.product_description AS product_description, LHS.other_product_service_details AS other_product_service_details, LHS.maxproduct_price AS maxproduct_price, RHS.product_id AS product_id_other, RHS.product_name AS product_name_other, RHS.product_price AS product_price_other, RHS.product_description AS product_description_other, RHS.other_product_service_details AS other_product_service_details_other, RHS.maxproduct_price AS maxproduct_price_other FROM (SELECT product_id, product_name, product_price, product_description, other_product_service_details, MAX(product_price) OVER () AS maxproduct_price FROM products) AS LHS CROSS JOIN (SELECT product_id, product_name, product_price, product_description, other_product_service_details, MAX(product_price) OVER () AS maxproduct_price FROM products) AS RHS) WHERE (product_price_other = maxproduct_price_other) ORDER BY product_name;

/*
Gold Result:
('47',)
*/

-- Prediction Query
SELECT Product_Name FROM PRODUCTS ORDER BY Product_Price DESC, PRODUCTS.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('47',)
*/