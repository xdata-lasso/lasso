-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

-- Inserting into table: perpetrator --
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1, -2147483648, 'hria2ypu', 882.963176, 'sr', 'per_e5e02b', 906324270, 50);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (2, -2147483648, 'p', 503.083789, 'hvdltt', 'per_e5e02b', -1610064545, 50);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (3, -2147483648, 'nprmdposii', 75.403642, 'nw6klf', 'per_e5e02b', 1038707349, 50);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (4, -2147483648, '5sw', 357.862717, 'cgsk9', '8c4p', 1871297066, 21);

INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (5, -2147483648, 'vfe4hria2', 378.476082, 'uzhs', 'rwbbp6luhvd', -1377057208, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM perpetrator WHERE (injured >= 50 AND injured > 20) ORDER BY country, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('per_e5e02b',)
('per_e5e02b',)
('per_e5e02b',)
*/

-- Prediction Query
SELECT Country FROM perpetrator WHERE Injured > 50 INTERSECT SELECT Country FROM perpetrator WHERE Injured < 20;

/*
Prediction Result:
*/