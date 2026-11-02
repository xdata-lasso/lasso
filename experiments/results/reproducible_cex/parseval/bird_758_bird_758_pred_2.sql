-- Schema DDL
CREATE TABLE alignment (id INTEGER NOT NULL PRIMARY KEY, alignment TEXT DEFAULT NULL);

CREATE TABLE attribute (id INTEGER NOT NULL PRIMARY KEY, attribute_name TEXT DEFAULT NULL);

CREATE TABLE colour (id INTEGER NOT NULL PRIMARY KEY, colour TEXT DEFAULT NULL);

CREATE TABLE gender (id INTEGER NOT NULL PRIMARY KEY, gender TEXT DEFAULT NULL);

CREATE TABLE publisher (id INTEGER NOT NULL PRIMARY KEY, publisher_name TEXT DEFAULT NULL);

CREATE TABLE race (id INTEGER NOT NULL PRIMARY KEY, race TEXT DEFAULT NULL);

CREATE TABLE superhero (id INTEGER NOT NULL PRIMARY KEY, superhero_name TEXT DEFAULT NULL, full_name TEXT DEFAULT NULL, gender_id INTEGER DEFAULT NULL, eye_colour_id INTEGER DEFAULT NULL, hair_colour_id INTEGER DEFAULT NULL, skin_colour_id INTEGER DEFAULT NULL, race_id INTEGER DEFAULT NULL, publisher_id INTEGER DEFAULT NULL, alignment_id INTEGER DEFAULT NULL, height_cm INTEGER DEFAULT NULL, weight_kg INTEGER DEFAULT NULL, FOREIGN KEY (alignment_id) REFERENCES alignment (id), FOREIGN KEY (eye_colour_id) REFERENCES colour (id), FOREIGN KEY (gender_id) REFERENCES gender (id), FOREIGN KEY (hair_colour_id) REFERENCES colour (id), FOREIGN KEY (publisher_id) REFERENCES publisher (id), FOREIGN KEY (race_id) REFERENCES race (id), FOREIGN KEY (skin_colour_id) REFERENCES colour (id));

CREATE TABLE hero_attribute (hero_id INTEGER DEFAULT NULL, attribute_id INTEGER DEFAULT NULL, attribute_value INTEGER DEFAULT NULL, FOREIGN KEY (attribute_id) REFERENCES attribute (id), FOREIGN KEY (hero_id) REFERENCES superhero (id));

CREATE TABLE superpower (id INTEGER NOT NULL PRIMARY KEY, power_name TEXT DEFAULT NULL);

CREATE TABLE hero_power (hero_id INTEGER DEFAULT NULL, power_id INTEGER DEFAULT NULL, FOREIGN KEY (hero_id) REFERENCES superhero (id), FOREIGN KEY (power_id) REFERENCES superpower (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: colour --
INSERT INTO "colour" ("id", "colour") VALUES (1, 't3__deaac2');

INSERT INTO "colour" ("id", "colour") VALUES (2, 't3__deaac2');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'tliqa1');

INSERT INTO "colour" ("id", "colour") VALUES (3, '4ji7zwa');

INSERT INTO "colour" ("id", "colour") VALUES (4, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'ia2yp');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'tti');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'klfa9000t');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'uo4nrqrofqy');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'ytoo3o9hl7');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483638, NULL);

INSERT INTO "colour" ("id", "colour") VALUES (11, '5k5swwqcgs');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'ia2yp', 'uzhsrwbbp6lu', -2147483648, 1, 1, 1, 1, -2147483648, -2147483648, 185, 1019800248);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'lbn', 'rmdp', -2147483648, 1, 1, 1, 1, -2147483648, -2147483648, 185, 2026480202);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '9000t5c4ec', 'gce', -2147483648, 1, 1, 1, 5, -2147483648, -2147483648, 185, -1585009206);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'nrqrofqy', '5s5b', -2147483648, 1, 1, 1, 3, -2147483648, -2147483648, 185, 2107872094);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'ytoo3o9', 'l7', -2147483648, 2, 6, 2, 1, -2147483648, -2147483648, 185, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'dwyrq13pyu78', '9', -2147483648, 1, 3, 3, 1, -2147483648, -2147483648, 185, 244829661);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '4', 'p5qi2rk', -2147483648, 2, 1, 3, 5, -2147483648, -2147483648, 185, -705985602);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'f8jegd21vy9u', 'j4hwbd', -2147483648, 3, 1, 3, 3, -2147483648, -2147483648, 185, -736979194);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'q', 'nqcx5h', -2147483648, 1, 6, 2, 1, -2147483648, -2147483648, 185, -1245312912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'dz79fjg', '8n2f3', -2147483648, 6, 3, 6, 1, -2147483648, -2147483648, 185, 806170397);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, '9', 'ozk3zbily', -2147483648, 6, 1, 1, 5, -2147483648, -2147483648, 185, 638024588);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'f8jswwl', '7xb72', -2147483648, 1, 1, 1, 3, -2147483648, -2147483648, 185, 1350414441);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'r', 'z16nijjai5d', -2147483648, 1, 6, 1, 1, -2147483648, -2147483648, 185, -1625552518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, '8', 'yzt1afgogrit', -2147483648, 1, 3, 2, 1, -2147483648, -2147483648, 185, 678047687);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '1q43', '1jh3den', -2147483648, 3, 1, 6, 1, -2147483648, -2147483648, 185, 357330522);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'afu5w1of7', 'pzo72ctdc', -2147483648, 6, 1, 6, 1, -2147483648, -2147483648, 185, 1303877941);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'wgxd5ysxc', 'r0oz', -2147483648, 1, 1, 2, 1, -2147483648, -2147483648, 1, -870767087);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'q5l', 'pim5', -2147483648, 2, 1, 3, 1, -2147483648, -2147483648, 1, -1125548818);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, '2mnajjla3o', 'v8u', -2147483648, 3, 1, 1, 1, -2147483648, -2147483648, 185, 618058035);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, '78lfvyz7zz', 'be8yvkv42q7', -2147483648, 3, 1, 3, 1, -2147483648, -2147483648, 185, -2060082151);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, 'auvmkrpd', 'wzw', -2147483648, 2, 1, 6, 1, -2147483648, -2147483648, 185, -55494714);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, 'a9n0jxfo', 'ws', -2147483648, 2, 1, 3, 1, -2147483648, -2147483648, 185, 1719800120);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'gu7v', 'e4', -2147483648, 4, 4, 3, 2, -2147483648, -2147483648, 185, 1160656988);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'wbbp6', 'uhv', -2147483648, 3, 5, 5, 6, -2147483648, -2147483648, 1, 1526238907);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'mdpos', 'ie5', -2147483648, 1, 7, 7, 7, -2147483648, -2147483648, 1, -1209887326);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'gce', '76nium52', -2147483648, 1, 8, 1, 8, -2147483648, -2147483648, NULL, -443340271);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'p', '02eutliqa11r', -2147483648, 8, 9, 1, 9, -2147483648, -2147483648, NULL, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '4ji7zwa', '2dwyrq', -2147483648, 6, 10, 5, 10, -2147483648, -2147483648, NULL, -1097120355);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'gu7v', 'e4', -2147483648, 10, 11, 8, 11, -2147483648, -2147483648, 185, 1160656988);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'e4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 'Human');

INSERT INTO "race" ("id", "race") VALUES (4, 'Human');

INSERT INTO "race" ("id", "race") VALUES (5, 'nw6klf');

INSERT INTO "race" ("id", "race") VALUES (3, 'u');

INSERT INTO "race" ("id", "race") VALUES (2, NULL);

INSERT INTO "race" ("id", "race") VALUES (6, 't2__608031');

INSERT INTO "race" ("id", "race") VALUES (7, NULL);

INSERT INTO "race" ("id", "race") VALUES (8, 'Human');

INSERT INTO "race" ("id", "race") VALUES (9, 't2__608031');

INSERT INTO "race" ("id", "race") VALUES (10, NULL);

INSERT INTO "race" ("id", "race") VALUES (11, 'Human');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('t3__deaac2',)
('tliqa1',)
('4ji7zwa',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Prediction Result:
('t3__deaac2',)
('t3__deaac2',)
('tliqa1',)
('4ji7zwa',)
('tliqa1',)
('4ji7zwa',)
('tliqa1',)
('4ji7zwa',)
('t3__deaac2',)
('t3__deaac2',)
('t3__deaac2',)
('t3__deaac2',)
('t3__deaac2',)
('t3__deaac2',)
('5k5swwqcgs',)
*/