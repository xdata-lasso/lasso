-- Schema DDL
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "CUSTOMER_ID" INT,
    "ORDER_DATE" DATE,
    "TOTAL_AMOUNT" FLOAT,
    "TAX_RATE" FLOAT,
    PRIMARY KEY ("ORDER_ID"),
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID")
);
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "NAME" TEXT,
    "DISCOUNT_RATE" FLOAT,
    PRIMARY KEY ("CUSTOMER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ORDERS VALUES (-2147483648, -2147483648, '0001-01-01', -1, 2);
INSERT INTO ORDERS VALUES (-2147483647, -2147483647, '0001-01-01', 1, 3);
INSERT INTO CUSTOMERS VALUES (-2147483648, 17, 0);
INSERT INTO CUSTOMERS VALUES (-2147483647, 18, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Gold Result:
('18', 1.0)
*/

-- Prediction Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount / o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Prediction Result:
('17', -1.0)
*/