-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: musical --
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483647, 'luhvdltti', -1364429300, 'nprmdposii', '5u', 'w6kl', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483646, 'a9', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (2, 'qyp5s5bbp0', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (3, 'klex14ji', -453362185, 'au2dwyrq13', 'yu78', '9', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483645, 'rljsl0b4y', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483642, 'j4hwbdvlph', -261132974, 'dqwn', 'cx5hn', 'p', 'G');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483641, 'jtu0d', 401805964, 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'G');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483640, 'kn6vc', 1784916884, 'ah0f8jsww', 'q7x', '7', 'A');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483639, '2fxa7ryfdrz', 61479715, 'jja', '5dh', 'ogrgjd8y', 'G');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483638, 't1afgog', -946046410, 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'G');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483637, 'afu5w1of7', 76996700, 'o72ctdc', 'mfg62', '0v', '!');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483636, 'q8qdjpe1', -1180042408, '78507cvt', 'ptt', '6b', 'I');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483635, 'ou5z', 1691780814, '6c4bfkfo', 'c', '0', 'I');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483634, '7z2zezjo7wg', 1248858185, '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'A');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483633, 'pim5', -1125548818, '94gth', '2mnajjla3o', 'v8u', 'I');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483632, 'tmu2n', -1817527403, '78lfvyz7zz', 'be8yvkv42q7', 'x58b4', 'I');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483631, 'pmaus3auvmkr', 609771851, 'j', 'wzw5chn9mo70', 'a9n0jxfo', 'A');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483630, 'ws', 1719800120, 'o', '2zobb0q0k32o', 'w', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483629, 'l', 895277769, 'amsorlwyng', '1', 'j', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483628, '9erhizgk1yoe', 1483450542, 'o6l0hdt6fu', 'yxuzk', '5', 'mus_60160b');

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483627, '1gwnlas6', -2076274980, 'ow', 'i1z', 'nxih662q', NULL);

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483626, 'xlyotow9', 727608179, 'awg96aqb0tbi', 'ndz39tajz9', 'd8n5w', NULL);

INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (-2147483625, 'g', -794767771, 'c', '3tdu6bd0w960', 'vzxw1rxe', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT RESULT, YEAR, MAX(n) AS n FROM (SELECT RESULT, YEAR, COUNT(*) AS n FROM musical GROUP BY RESULT, YEAR) GROUP BY RESULT, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT RESULT FROM musical GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('mus_60160b',)
*/