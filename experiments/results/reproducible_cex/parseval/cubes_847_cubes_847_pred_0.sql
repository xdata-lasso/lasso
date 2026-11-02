-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

-- Inserting into table: perpetrator --
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483648, 1, 'per_ae9c0f', 1.0, 'hria2ypu', 'per_974f47', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1, 1, 'lhs_2c9f00', 1.0, 'lhs_ba4127', 'lhs_ca005a', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483646, 1, 'rhs_2b113f', 1.0, 'hsrwbbp', 'rhs_849cbb', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483645, 1, 'per_ae9c0f', 1.0, 'luhvdltti', 'per_974f47', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483644, 1, 'per_cb56f3', 1.0, 'bnp', 'per_634da9', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483643, 1, 'rhs_2b113f', 1.0, 'mdpos', 'rhs_849cbb', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483642, 1, 'rhs_e2d4eb', 1.0, 'ie5', 'rhs_b119e3', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483641, 1, 'per_ae9c0f', 1.0, NULL, 'per_974f47', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483640, 1, 'rhs_2b113f', 1.0, NULL, 'rhs_849cbb', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483639, 1, 'per_ae9c0f', 1.0, 'nw6klf', NULL, 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483638, 1, 'rhs_2b113f', 1.0, 'a9000t5c4eci', NULL, 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483637, 1, 'per_ae9c0f', 1.0, 'gce376nium52', 'per_974f47', NULL, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483636, 1, 'rhs_2b113f', 1.0, 'zbuo4nrqrof', 'rhs_849cbb', NULL, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483635, 1, 'per_ae9c0f', 1.0, 'p5s5bbp', 'per_974f47', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483634, 1, 'rhs_2b113f', 1.0, 'eutliqa11r', 'rhs_849cbb', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483633, 1, NULL, 1.0, 'ytoo3o9', 'per_974f47', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483632, 1, NULL, 1.0, 'l7', 'rhs_849cbb', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483631, 1, 'per_ae9c0f', NULL, 'klex14ji', 'per_974f47', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483630, 1, 'rhs_2b113f', NULL, '7zwau2dwyr', 'rhs_849cbb', 1, 1);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483629, 1, 'per_ae9c0f', 1.0, '13pyu', 'per_974f47', 1, NULL);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (-2147483628, 1, 'rhs_2b113f', 1.0, '8d99rljsl', 'rhs_849cbb', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other FROM perpetrator AS LHS INNER JOIN perpetrator AS RHS ON (LHS.people_id = RHS.perpetrator_id AND LHS.location = RHS.location)) ORDER BY LOCATION;

/*
Gold Result:
('lhs_ba4127',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('hria2ypu',)
*/