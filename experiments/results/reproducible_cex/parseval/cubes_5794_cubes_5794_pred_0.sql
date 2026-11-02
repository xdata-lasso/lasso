-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (1, 'peo_21cc3b', 582.588439, 680.190136, 'k5swwqcg', 'k9n8c');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483647, 'peo_b52123', 475.173408, 935.695299, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483646, 'rwbbp6luhvd', 179.378884, 304.02808, 'bnp', 'q_2_a429f9');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483645, 'mdpos', 133.007885, 75.403642, 'nw6klf', 'q_2_a429f9');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (2, 'a9000t5c4eci', 734.586266, 767.720387, 'e', '76nium52');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (3, 'zbuo4nrqrof', 586.906897, 389.878901, 's5bbp02e', 'tliqa1');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (4, 'ryytoo3', 228.583847, 111.926013, '72klex14ji7z', 'au2dwy');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (5, 'q13py', 326.912005, 798.947629, '9', 'rljsl0b4y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT birth_date, birth_place, MAX(n) AS maxn FROM (SELECT name, weight, n, name_other, height, birth_date, birth_place, n AS people_id FROM (SELECT LHS.name AS name, LHS.weight AS weight, LHS.n AS n, RHS.name AS name_other, RHS.height AS height, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT name, weight, COUNT(*) AS n FROM people GROUP BY name, weight) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.weight = RHS.weight))) GROUP BY birth_date, birth_place) ORDER BY birth_place;

/*
Gold Result:
('k9n8c',)
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_a429f9',)
*/