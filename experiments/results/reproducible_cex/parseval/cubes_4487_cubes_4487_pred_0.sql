-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artwork --
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483648, 'art_be98ab', '5k5swwqcgs');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483647, 'art_be98ab', '9n8');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483646, 'art_be98ab', '4');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483645, 'art_016b55', 'gu7v');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483644, 'art_016b55', 'e4');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483643, 'art_016b55', 'hria2ypuzhs');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483642, 'art_be98ab', 'rwbbp6luhvd');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483641, 'art_be98ab', 'tti');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483640, 'art_be98ab', 'bnp');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483639, 'art_016b55', 'mdpos');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483638, 'art_016b55', 'ie5');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483637, 'art_016b55', 'nw6klf');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483636, NULL, 'a9000t5c4eci');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483635, NULL, 'gce376nium52');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483634, NULL, 'zbuo4nrqrof');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483633, NULL, 'qyp5s5bbp0');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483632, NULL, '2eutliqa11r');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483631, NULL, 'ytoo3o9');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483630, 'art_be98ab', 'l7');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483629, 'art_be98ab', 'klex14ji');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483628, 'art_be98ab', '7zwau2dwyr');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483627, 'art_016b55', '13pyu');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483626, 'art_016b55', '8d99rljsl');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483625, 'art_016b55', 'b4yp5qi');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483624, 'art_be98ab', 'rkf9vqx5');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483623, 'art_be98ab', 'pz0f8jegd');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483622, 'art_be98ab', '1vy9uxj4');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483621, 'art_016b55', 'wb');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483620, 'art_016b55', 'v');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483619, 'art_016b55', 'ph2');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483618, 'art_be98ab', 'nd');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483617, 'art_be98ab', 'wnqcx');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483616, 'art_be98ab', '5hncprjtu0d');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483615, 'art_016b55', '79fjgq8');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483614, 'art_016b55', 'n2f3dqv0gcb9');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483613, 'art_016b55', 'ozk3zbily');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483612, 'art_be98ab', 'kn6vc');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483611, 'art_be98ab', '6ah');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483610, 'art_be98ab', 'f8jswwl');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483609, 'art_016b55', '7xb72');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483608, 'art_016b55', 'xa');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483607, 'art_016b55', '7ryfdrz16n');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (2, 'jja', '5dh');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (3, 'ogrgjd8y', 't1afgog');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.type AS TYPE, LHS.n AS n FROM (SELECT TYPE, COUNT(*) AS n FROM artwork GROUP BY TYPE) AS LHS INNER JOIN (SELECT TYPE, MAX(n) OVER () AS n FROM (SELECT TYPE, COUNT(*) AS n FROM artwork GROUP BY TYPE)) AS RHS ON (LHS.type = RHS.type AND LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
('art_016b55',)
('art_be98ab',)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('art_016b55',)
*/