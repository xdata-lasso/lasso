-- Schema DDL
CREATE TABLE "CUSTOMERS" (
    "CID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("CID")
);
CREATE TABLE "ORDERS" (
    "OID" INT,
    "CID" INT,
    "AMOUNT" FLOAT,
    PRIMARY KEY ("OID", "CID"),
    FOREIGN KEY ("CID") REFERENCES "CUSTOMERS"("CID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CUSTOMERS VALUES (-1, 11);
INSERT INTO CUSTOMERS VALUES (0, 12);
INSERT INTO ORDERS VALUES (0, 0, 100);
INSERT INTO ORDERS VALUES (1, 0, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Prediction Result:
(1,)
*/