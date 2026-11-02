-- Schema DDL
CREATE TABLE "STAFF" (
    "STAFF_ID" INT,
    "GENDER" TEXT,
    "FIRST_NAME" TEXT,
    "LAST_NAME" TEXT,
    "EMAIL_ADDRESS" TEXT,
    "PHONE_NUMBER" TEXT,
    PRIMARY KEY ("STAFF_ID")
);
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "CUSTOMER_TYPE_CODE" TEXT,
    "ADDRESS_LINE_1" TEXT,
    "ADDRESS_LINE_2" TEXT,
    "TOWN_CITY" TEXT,
    "STATE" TEXT,
    "EMAIL_ADDRESS" TEXT,
    "PHONE_NUMBER" TEXT,
    PRIMARY KEY ("CUSTOMER_ID")
);
CREATE TABLE "PRODUCTS" (
    "PRODUCT_ID" INT,
    "PARENT_PRODUCT_ID" INT,
    "PRODUCT_CATEGORY_CODE" TEXT,
    "DATE_PRODUCT_FIRST_AVAILABLE" DATETIME,
    "DATE_PRODUCT_DISCONTINUED" DATETIME,
    "PRODUCT_NAME" TEXT,
    "PRODUCT_DESCRIPTION" TEXT,
    "PRODUCT_PRICE" FLOAT,
    PRIMARY KEY ("PRODUCT_ID")
);
CREATE TABLE "COMPLAINTS" (
    "CUSTOMER_ID" INT,
    "PRODUCT_ID" INT,
    "STAFF_ID" INT,
    "COMPLAINT_ID" INT,
    "COMPLAINT_OUTCOME_CODE" TEXT,
    "COMPLAINT_STATUS_CODE" TEXT,
    "COMPLAINT_TYPE_CODE" TEXT,
    "DATE_COMPLAINT_RAISED" DATETIME,
    "DATE_COMPLAINT_CLOSED" DATETIME,
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID"),
    FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCTS"("PRODUCT_ID"),
    FOREIGN KEY ("STAFF_ID") REFERENCES "STAFF"("STAFF_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STAFF VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO STAFF VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PRODUCTS VALUES (0, 0, 19, 20, 21, 0, 22, 23);
INSERT INTO PRODUCTS VALUES (-1, 0, 24, 25, 26, 27, 28, 29);
INSERT INTO COMPLAINTS VALUES (-1, 0, -1, 0, 18, 39, 40, 41, 42);
INSERT INTO COMPLAINTS VALUES (0, 0, -1, 0, 43, 44, 45, 46, 47);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT LHS.product_id AS product_id, LHS.parent_product_id AS parent_product_id, LHS.product_category_code AS product_category_code, LHS.date_product_first_available AS date_product_first_available, LHS.date_product_discontinued AS date_product_discontinued, LHS.product_name AS product_name, LHS.product_description AS product_description, LHS.product_price AS product_price, RHS.complaint_outcome_code AS complaint_outcome_code, RHS.n AS n FROM products AS LHS INNER JOIN (SELECT complaint_outcome_code, product_id, COUNT(*) AS n FROM complaints GROUP BY complaint_outcome_code, product_id) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('0', 1)
('0', 1)
*/

-- Prediction Query
SELECT t1.product_name, COUNT(*) FROM products AS t1 JOIN complaints AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_name;

/*
Prediction Result:
('0', 2)
*/