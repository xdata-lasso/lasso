-- Schema DDL
CREATE TABLE "CUSTOMERS" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "ORDERS" (
    "ID" INT,
    "CUSTOMER_ID" INT,
    "ITEM" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CUSTOMERS VALUES (-1, 10);
INSERT INTO CUSTOMERS VALUES (0, 12);
INSERT INTO ORDERS VALUES (0, 0, 11);
INSERT INTO ORDERS VALUES (1, 0, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.id) FROM customers AS c INNER JOIN orders AS o ON c.id = o.customer_id;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.id) FROM customers AS c WHERE c.id IN (SELECT customer_id FROM orders);

/*
Prediction Result:
(1,)
*/