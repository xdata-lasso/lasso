-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'peo_98298d');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483647, 'hria2ypu', 882.963176, 841.297061, 'rwbbp', 'peo_f32b7f');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483646, 'luhvdltti', 182.319045, 998.421621, 'prmd', 'q_0_a4d9f0');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483645, 'posiie5unw6k', 768.216462, 83.204633, '9', 'q_0_a4d9f0');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (2, '00t5c4e', 950.466571, 796.740316, 'gce', '76nium52');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (3, 'zbuo4nrqrof', 586.906897, 389.878901, 's5bbp02e', 'tliqa1');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (4, 'ryytoo3', 228.583847, 111.926013, '72klex14ji7z', 'au2dwy');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (5, 'q13py', 326.912005, 798.947629, '9', 'rljsl0b4y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT LHS.birth_date AS birth_date, LHS.birth_place AS birth_place, LHS.n AS n, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_place AS birth_place_other FROM (SELECT birth_date, birth_place, COUNT(*) AS n FROM people GROUP BY birth_date, birth_place) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.birth_date = RHS.birth_date)) ORDER BY birth_place;

/*
Gold Result:
('peo_98298d',)
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_0_a4d9f0',)
*/