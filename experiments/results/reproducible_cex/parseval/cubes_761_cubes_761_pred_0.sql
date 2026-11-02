-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: musical --
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483648, '5k5swwqcgs', 1, '9n8', '4', 'mus_b81021', 'gu7v');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483647, 'e4', 1, 'hria2ypuzhs', 'rwbbp6luhvd', 'mus_b81021', 'tti');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483646, 'bnp', 1, 'mdpos', 'ie5', 'mus_b81021', 'nw6klf');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483645, 'a9000t5c4eci', 1, 'gce376nium52', 'zbuo4nrqrof', 'mus_b81021', 'qyp5s5bbp0');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483644, '2eutliqa11r', 1, 'ytoo3o9', 'l7', 'mus_b81021', 'klex14ji');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483643, '7zwau2dwyr', 1, '13pyu', '8d99rljsl', 'mus_b81021', 'b4yp5qi');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483642, 'rkf9vqx5', NULL, 'pz0f8jegd', '1vy9uxj4', 'mus_b81021', 'wb');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483641, 'v', NULL, 'ph2', 'nd', 'mus_b81021', 'wnqcx');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483640, '5hncprjtu0d', NULL, '79fjgq8', 'n2f3dqv0gcb9', 'mus_b81021', 'ozk3zbily');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483639, 'kn6vc', 1, '6ah', 'f8jswwl', NULL, '7xb72');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483638, 'xa', 1, '7ryfdrz16n', 'jja', NULL, '5dh');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483637, 'ogrgjd8y', 1, 't1afgog', 'itsj3', NULL, 'y');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483636, 'p1q430', 1, 'jh3den8', 'c68x8vacx7', 'mus_b81021', 'f');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483635, '5w1of7', 1, 'pzo72ctdc', 'mfg62', 'mus_b81021', '0v');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483634, 'q8qdjpe1', 1, 'o22', '8507cvtjp', 'mus_b81021', 'ttg6bnou5zi3');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483633, 'c4bfkfoac', 1, '0', '7z2zezjo7wg', 'mus_b81021', 'd5ysxc');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483632, 'r0oz', 1, 'dgj5i', 'lq5lnpim', 'mus_b81021', 'k58qs27p');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483631, 'r94gth2m', 1, 'ajjl', '3', 'mus_b81021', 'okv8uttmu2');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483630, 'e578', 1, 'fvy', '7zzbe8y', 'mus_b81021', 'kv42q7');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483629, 'x58b4', 1, 'pmaus3auvmkr', 'pdjwzw5chn9', 'mus_b81021', 'o705');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483628, 'a9n0jxfofws', 1, 'do2zobb', 'q0k32od', 'mus_b81021', 'cl5ams');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee, n AS count___ FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) ORDER BY nominee, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('mus_b81021', 3)
('mus_b81021', 15)
*/

-- Prediction Query
SELECT Nominee, COUNT(*) FROM musical GROUP BY Nominee;

/*
Prediction Result:
(None, 3)
('mus_b81021', 18)
*/