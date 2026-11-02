-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483648, '5k5swwqcgs', 'shi_f8ace5', '9n8', 1610062532);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483647, 'pgu7vfe4', 'shi_f8ace5', 'hria2ypuzhs', 700293388);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483646, 'wbbp6luhvdlt', 'shi_f8ace5', 'ilbnp', 1236688122);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (2, 'dpos', 'shi_f8ace5', 'ie5', -1209887326);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (3, 'klfa9000t', 'shi_f8ace5', 'c4ecigce', -1585009206);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483645, '52zb', 'shi_f8ace5', 'uo4nrqrofqy', -1106983592);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483642, '5bbp0', 'G', '2eutliqa11r', 2137741668);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483641, 'ytoo3o9hl7', 'G', 'klex14ji', -453362185);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483640, 'au2dwyrq13', 'A', 'yu78', 244829661);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483639, 'jsl', 'O', 'b4yp5qi', -227162283);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483638, 'f9v', 'O', 'x58pz', -1529584866);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483637, 'd2', 'A', 'vy9uxj4', -1612443122);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483636, 'd', 'G', 'lph2gn', 1968874827);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483635, 'nqcx5h', 'G', 'cprj', -841004020);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483634, 'dz79fjg', 'A', '8n2f3', 806170397);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483633, 'qv0gcb98ozk', 'O', 'zbilyrkn', -688098735);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483632, '6ah', 'O', 'f8jswwl', 1255343543);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483631, '7', 'A', '2fxa7ryfdrz', 61479715);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483630, 'jja', NULL, '5dh', 1583472758);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483629, 'rg', NULL, 'd8y', 1129658414);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483628, '1afgo', NULL, 'ri', -902895762);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483627, 'ayxp1q43', 'shi_f8ace5', '1jh3den', 357330522);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483626, '68x8vacx7a', 'shi_f8ace5', 'u5', -290314193);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483625, 'f77pzo72ctd', 'shi_f8ace5', 't', -1284905200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY TYPE;

/*
Gold Result:
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('shi_f8ace5',)
*/