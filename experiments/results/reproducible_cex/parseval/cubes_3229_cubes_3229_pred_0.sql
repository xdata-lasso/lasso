-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1, '5k5swwqcgs', 'shi_d63dc9', '9n8', 1610062532);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483647, 'pgu7vfe4', 'shi_90bdb9', 'hria2ypuzhs', 700293388);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483646, 'wbbp6luhvdlt', 'ilbnp', 'q_0_993000', 1236688122);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483645, 'dpos', 'ie5', 'q_0_993000', -1209887326);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (2, 'klfa9000t', 'c4ecigce', '76nium52', -443340271);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (3, 'uo4nrqrofqy', '5s5b', 'p', 882961052);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (4, '2eutliqa11r', 'ytoo3o9', 'l7', 1178636309);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (5, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', 244829661);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('9n8',)
*/

-- Prediction Query
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*) > 2;

/*
Prediction Result:
*/