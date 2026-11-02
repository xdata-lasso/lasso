-- Schema DDL
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("CUSTOMER_ID")
);
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "CUSTOMER_ID" INT,
    "AMOUNT" FLOAT,
    PRIMARY KEY ("ORDER_ID"),
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CUSTOMERS VALUES (0, 11);
INSERT INTO CUSTOMERS VALUES (-1, 15);
INSERT INTO ORDERS VALUES (0, 0, 2241);
INSERT INTO ORDERS VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
('11', 2241.0)
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c LEFT JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Prediction Result:
('11', 2241.0)
('15', None)
*/