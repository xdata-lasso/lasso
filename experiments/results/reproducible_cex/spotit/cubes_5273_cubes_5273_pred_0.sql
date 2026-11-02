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
INSERT INTO PHONE VALUES (4, 12, 0, 0, 13);
INSERT INTO PHONE VALUES (3, 10, 0, 0, 11);
INSERT INTO MARKET VALUES (1, 0, 0, 0, 0);
INSERT INTO MARKET VALUES (0, 0, 0, 0, 0);
INSERT INTO PHONE_MARKET VALUES (1, 3, 0);
INSERT INTO PHONE_MARKET VALUES (1, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT carrier, MAX(n) AS n FROM (SELECT carrier, n, name, memory_in_g, price, n AS phone_id FROM (SELECT LHS.carrier AS carrier, LHS.n AS n, RHS.name AS name, RHS.memory_in_g AS memory_in_g, RHS.price AS price FROM (SELECT carrier, COUNT(*) AS n FROM phone GROUP BY carrier) AS LHS INNER JOIN phone AS RHS ON (LHS.n = RHS.phone_id AND LHS.carrier = RHS.carrier))) GROUP BY carrier) ORDER BY carrier;

/*
Gold Result:
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/