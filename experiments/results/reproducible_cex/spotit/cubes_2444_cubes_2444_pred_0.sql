-- Schema DDL
CREATE TABLE "ADDRESSES" (
    "ADDRESS_ID" INT,
    "ADDRESS_CONTENT" TEXT,
    "CITY" TEXT,
    "ZIP_POSTCODE" TEXT,
    "STATE_PROVINCE_COUNTY" TEXT,
    "COUNTRY" TEXT,
    "OTHER_ADDRESS_DETAILS" TEXT,
    PRIMARY KEY ("ADDRESS_ID")
);
CREATE TABLE "PRODUCTS" (
    "PRODUCT_ID" INT,
    "PRODUCT_DETAILS" TEXT,
    PRIMARY KEY ("PRODUCT_ID")
);
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "PAYMENT_METHOD" TEXT,
    "CUSTOMER_NAME" TEXT,
    "DATE_BECAME_CUSTOMER" DATETIME,
    "OTHER_CUSTOMER_DETAILS" TEXT,
    PRIMARY KEY ("CUSTOMER_ID")
);
CREATE TABLE "CUSTOMER_ADDRESSES" (
    "CUSTOMER_ID" INT,
    "ADDRESS_ID" INT,
    "DATE_ADDRESS_FROM" DATETIME,
    "ADDRESS_TYPE" TEXT,
    "DATE_ADDRESS_TO" DATETIME,
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID"),
    FOREIGN KEY ("ADDRESS_ID") REFERENCES "ADDRESSES"("ADDRESS_ID")
);
CREATE TABLE "CUSTOMER_CONTACT_CHANNELS" (
    "CUSTOMER_ID" INT,
    "CHANNEL_CODE" TEXT,
    "ACTIVE_FROM_DATE" DATETIME,
    "ACTIVE_TO_DATE" DATETIME,
    "CONTACT_NUMBER" TEXT,
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID")
);
CREATE TABLE "CUSTOMER_ORDERS" (
    "ORDER_ID" INT,
    "CUSTOMER_ID" INT,
    "ORDER_STATUS" TEXT,
    "ORDER_DATE" DATETIME,
    "ORDER_DETAILS" TEXT,
    PRIMARY KEY ("ORDER_ID"),
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID")
);
CREATE TABLE "ORDER_ITEMS" (
    "ORDER_ID" INT,
    "PRODUCT_ID" INT,
    "ORDER_QUANTITY" TEXT,
    FOREIGN KEY ("ORDER_ID") REFERENCES "CUSTOMER_ORDERS"("ORDER_ID"),
    FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCTS"("PRODUCT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ADDRESSES VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO ADDRESSES VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO PRODUCTS VALUES (1, 0);
INSERT INTO PRODUCTS VALUES (0, 0);
INSERT INTO CUSTOMERS VALUES (0, 73, 74, 75, 76);
INSERT INTO CUSTOMERS VALUES (1, 80, 81, 82, 83);
INSERT INTO CUSTOMER_ADDRESSES VALUES (0, -1, 0, 0, 0);
INSERT INTO CUSTOMER_ADDRESSES VALUES (1, -1, 0, 0, 0);
INSERT INTO CUSTOMER_CONTACT_CHANNELS VALUES (0, 0, 0, 0, 0);
INSERT INTO CUSTOMER_CONTACT_CHANNELS VALUES (0, 0, 0, 0, 0);
INSERT INTO CUSTOMER_ORDERS VALUES (1, 0, 77, 78, 79);
INSERT INTO CUSTOMER_ORDERS VALUES (0, 0, 84, 85, 86);
INSERT INTO ORDER_ITEMS VALUES (0, 0, NULL);
INSERT INTO ORDER_ITEMS VALUES (0, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.date_became_customer AS date_became_customer, LHS.other_customer_details AS other_customer_details, LHS.order_id AS order_id, LHS.order_status AS order_status, LHS.order_date AS order_date, LHS.order_details AS order_details, LHS.product_id AS product_id, LHS.order_quantity AS order_quantity FROM (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.date_became_customer AS date_became_customer, LHS.other_customer_details AS other_customer_details, LHS.order_id AS order_id, LHS.order_status AS order_status, LHS.order_date AS order_date, LHS.order_details AS order_details, RHS.product_id AS product_id, RHS.order_quantity AS order_quantity FROM (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.date_became_customer AS date_became_customer, LHS.other_customer_details AS other_customer_details, RHS.order_id AS order_id, RHS.order_status AS order_status, RHS.order_date AS order_date, RHS.order_details AS order_details FROM customers AS LHS INNER JOIN customer_orders AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN order_items AS RHS ON (LHS.order_id = RHS.order_id)) AS LHS INNER JOIN (SELECT MAX(order_quantity) AS order_quantity FROM order_items) AS RHS ON (LHS.order_quantity = RHS.order_quantity)) ORDER BY customer_name;

/*
Gold Result:
('74',)
*/

-- Prediction Query
SELECT t1.customer_name FROM customers AS t1 JOIN customer_orders AS t2 ON t1.customer_id = t2.customer_id JOIN order_items AS t3 ON t2.order_id = t3.order_id WHERE t3.order_quantity = (SELECT MAX(order_quantity) FROM order_items);

/*
Prediction Result:
('74',)
*/