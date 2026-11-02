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
INSERT INTO PHONE VALUES (0, 0, NULL, NULL, 11);
INSERT INTO PHONE VALUES (1, NULL, 0, 10, 11);
INSERT INTO MARKET VALUES (0, 0, 0, 0, 0);
INSERT INTO MARKET VALUES (1, 0, 0, 0, 0);
INSERT INTO PHONE_MARKET VALUES (1, 0, 0);
INSERT INTO PHONE_MARKET VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price, RHS.phone_id AS phone_id_other, RHS.num_of_stock AS num_of_stock, RHS.name AS name_other, RHS.phone_id_other AS phone_id_other_other, RHS.memory_in_g AS memory_in_g_other, RHS.carrier AS carrier_other FROM phone AS LHS INNER JOIN (SELECT * FROM (SELECT LHS.market_id AS market_id, LHS.phone_id AS phone_id, LHS.num_of_stock AS num_of_stock, RHS.name AS name, RHS.phone_id AS phone_id_other, RHS.memory_in_g AS memory_in_g, RHS.carrier AS carrier, RHS.price AS price FROM phone_market AS LHS CROSS JOIN phone AS RHS) WHERE (phone_id <= phone_id_other AND phone_id <> phone_id_other)) AS RHS ON (LHS.phone_id = RHS.market_id AND LHS.price = RHS.price)) ORDER BY name;

/*
Gold Result:
(None,)
('0',)
*/

-- Prediction Query
SELECT Name FROM phone WHERE NOT Phone_id IN (SELECT Phone_ID FROM phone_market);

/*
Prediction Result:
(None,)
*/