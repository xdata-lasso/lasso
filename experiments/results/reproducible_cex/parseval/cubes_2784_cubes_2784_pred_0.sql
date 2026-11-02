-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

-- Inserting into table: entrepreneur --
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483648, -2147483648, 'hria2ypu', 882.963176, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483647, -2147483648, 'rwbbp', 503.083789, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483646, -2147483648, 'hvdlttilbnpr', 986.066566, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (2, -2147483648, 'posiie5unw6k', 768.216462, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (3, -2147483648, 'a9000t5c4eci', 734.586266, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483645, -2147483648, 'e', 467.07027, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483642, -2147483648, 'um5', 452.706544, 'G');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483641, -2147483648, 'u', 225.300904, 'G');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483640, -2147483648, 'rqrofqyp5s', 499.570479, 'A');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483639, -2147483648, 'p', 705.580387, 'G');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483638, -2147483648, 'eutliqa11r', 997.73177, 'G');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483637, -2147483648, 'oo3o9', 111.926013, '!');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483636, -2147483648, 'lex', 913.303855, 'E');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483635, -2147483648, 'i7z', 353.163664, 'E');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483634, -2147483648, '2dwyrq', 433.533777, '!');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483633, -2147483648, 'yu78', 49.538289, 'W');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483632, -2147483648, 'jsl', 419.361606, 'W');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483631, -2147483648, 'p5qi2rk', 811.601922, 'A');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483630, -2147483648, 'vqx58pz0f', 707.476301, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483629, -2147483648, 'gd', 452.27611, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483628, -2147483648, 'y9uxj4', 124.573829, 'ent_0c1fe3');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483627, -2147483648, 'v', 185.427628, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483626, -2147483648, 'h2gndqwnqcx5', 635.267184, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483625, -2147483648, 'p', 269.734861, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.people_id AS people_id_other FROM entrepreneur AS LHS INNER JOIN (SELECT people_id, COUNT(*) AS n FROM entrepreneur GROUP BY people_id) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY investor;

/*
Gold Result:
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('ent_0c1fe3',)
*/