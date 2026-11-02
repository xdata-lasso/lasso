-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (2, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'peo_fc4b58');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (3, 'hria2ypu', 882.963176, 841.297061, 'rwbbp', 'peo_fc4b58');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (4, 'luhvdltti', 182.319045, 998.421621, 'prmd', 'posiie5unw6k');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (5, 'fa9', 877.276439, 627.258639, '0t5c4ecigc', 'e376nium52');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (6, 'zbuo4nrqrof', 586.906897, 389.878901, 's5bbp02e', 'tliqa1');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (7, 'ryytoo3', 228.583847, 111.926013, '72klex14ji7z', 'au2dwy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_birth_place_ FROM (SELECT COUNT(*) AS n FROM people) ORDER BY count_distinct_birth_place_;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Birth_Place) FROM people;

/*
Prediction Result:
(5,)
*/