-- Schema DDL
CREATE TABLE "PHONE" (
    "PHONE_ID" INT,
    "NAME" TEXT,
    "MEMORY_IN_G" INT,
    "CARRIER" TEXT,
    "PRICE" FLOAT,
    PRIMARY KEY ("PHONE_ID")
);
CREATE TABLE "MARKET" (
    "MARKET_ID" INT,
    "DISTRICT" TEXT,
    "NUM_OF_EMPLOYEES" INT,
    "NUM_OF_SHOPS" FLOAT,
    "RANKING" INT,
    PRIMARY KEY ("MARKET_ID")
);
CREATE TABLE "PHONE_MARKET" (
    "MARKET_ID" INT,
    "PHONE_ID" TEXT,
    "NUM_OF_STOCK" INT,
    PRIMARY KEY ("MARKET_ID", "PHONE_ID"),
    FOREIGN KEY ("PHONE_ID") REFERENCES "PHONE"("PHONE_ID"),
    FOREIGN KEY ("MARKET_ID") REFERENCES "MARKET"("MARKET_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PHONE VALUES (0, 15, 0, 1, 1);
INSERT INTO PHONE VALUES (-1, 16, 0, 0, 1);
INSERT INTO MARKET VALUES (0, 0, 0, 0, 0);
INSERT INTO MARKET VALUES (1, 0, 0, 0, 0);
INSERT INTO PHONE_MARKET VALUES (1, -1, 0);
INSERT INTO PHONE_MARKET VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price FROM phone AS LHS INNER JOIN (SELECT MAX(price) AS price FROM phone) AS RHS ON (LHS.price = RHS.price)) ORDER BY carrier;

/*
Gold Result:
('0',)
('1',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/