-- Schema DDL
CREATE TABLE "grapes" ("ID" INTEGER PRIMARY KEY, "Grape" TEXT UNIQUE, "Color" TEXT);

CREATE TABLE "appellations" ("No" INTEGER PRIMARY KEY, "Appelation" TEXT UNIQUE, "County" TEXT, "State" TEXT, "Area" TEXT, "isAVA" TEXT);

CREATE TABLE "wine" ("Appelation" TEXT, "Grape" TEXT, "No" INTEGER, "Winery" TEXT, "State" TEXT, "Name" TEXT, "Year" INTEGER, "Price" INTEGER, "Score" INTEGER, "Cases" INTEGER, "Drink" TEXT, FOREIGN KEY ("Appelation") REFERENCES "appellations" ("Appelation"), FOREIGN KEY ("Grape") REFERENCES "grapes" ("Grape"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: appellations --
INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483648, 'appelation_1', 'Napa', '5k5swwqcgs', '9n8', '4');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483647, 'appelation_2', 'app_c7495b', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (-2147483646, 'appelation_3', 'Napa', 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (2, 'appelation_4', NULL, 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (3, 'appelation_5', 'Napa', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (4, 'appelation_6', 'Napa', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (5, 'appelation_7', 'Napa', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (6, 'appelation_8', 'Napa', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "appellations" ("no", "appelation", "county", "state", "area", "isava") VALUES (7, 'appelation_9', 'Napa', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "area", "county", COUNT(*) AS "n" FROM "appellations" GROUP BY "area", "county") WHERE ("county" = 'Napa') ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM APPELLATIONS WHERE County = 'Napa';

/*
Prediction Result:
(7,)
*/