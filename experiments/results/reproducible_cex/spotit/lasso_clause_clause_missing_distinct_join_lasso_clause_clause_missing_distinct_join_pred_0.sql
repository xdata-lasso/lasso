-- Schema DDL
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("CUSTOMER_ID")
);
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "CUSTOMER_ID" INT,
    "ORDER_DATE" DATE,
    PRIMARY KEY ("ORDER_ID"),
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CUSTOMERS VALUES (-1, 10);
INSERT INTO CUSTOMERS VALUES (0, NULL);
INSERT INTO ORDERS VALUES (0, 0, '0001-01-01');
INSERT INTO ORDERS VALUES (-1, -1, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT c.name) FROM Customers AS c JOIN Orders AS o ON c.customer_id = o.customer_id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(c.customer_id) FROM Customers AS c JOIN Orders AS o ON c.customer_id = o.customer_id;

/*
Prediction Result:
(2,)
*/