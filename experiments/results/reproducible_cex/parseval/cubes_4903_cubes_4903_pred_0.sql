-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1, 'mou_9cff48', 1.0, 1.0, 'mou_6e29aa', 'mou_f5dd53');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (2, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (3, 'hsrwbbp', 503.083789, 320.851235, 'vd', 'tti');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (4, 'bnp', 787.938887, 986.066566, 'dposiie5unw', 'klfa9000t');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (5, 'c4ecigce', 467.07027, 875.837169, 'nium52zbu', '4nrq');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (6, 'rofqyp5s5b', 22.720462, 990.777211, '02eutliqa11r', 'ytoo3o9');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (7, 'l7', 443.457804, 774.422647, 'ex1', 'ji7zwau2');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (8, 'dwyrq13pyu78', 49.538289, 557.003843, 'jsl', 'b4yp5qi');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (9, 'rkf9vqx5', 541.393553, 235.518744, 'z0f8jegd21', 'y9uxj4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, LHS.n AS n, RHS.name AS name_other FROM (SELECT mountain_id, name, height, prominence, RANGE, country, COUNT(*) OVER () AS n FROM mountain) AS LHS INNER JOIN (SELECT country, name, MAX(n) AS n FROM (SELECT mountain_id, name, height, prominence, RANGE, country, COUNT(*) OVER () AS n FROM mountain) GROUP BY country, name) AS RHS ON (LHS.mountain_id = RHS.n AND LHS.country = RHS.country)) ORDER BY RANGE;

/*
Gold Result:
('z0f8jegd21',)
*/

-- Prediction Query
SELECT RANGE FROM mountain GROUP BY RANGE ORDER BY COUNT(*) DESC, RANGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('02eutliqa11r',)
*/