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
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '9n8');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'e4', 't1__1a825f', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'sr', 't1__1a825f', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 906324270, 1908028688);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'e5u', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -2147483648, 0, 1861536320);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'ecigce376n', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 0, -2147483648, 0, 1313172851);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'rofqyp5s5b', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -2147483648, -1, 2107872094);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'ytoo3o9', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -2147483648, -1, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '2dwyrq', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1, -2147483648, -1, -1097120355);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'qi2rkf9v', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, '9uxj4hwbdvl', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 2103044118, -1642259219);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'p', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -988981234, -841004020);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'qv0gcb98ozk', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -155284187, 1686459626);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '8j', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -932772113, -639539893);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'z16nijjai5d', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 0, -1625552518);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'og', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -1, -946046410);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, '1jh3den', 't1__b27ef6', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 0, 357330522);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'cgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'a2y', 'uzhs', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'cgsk9', NULL, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, 1610062532, -106629402);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483647, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-1, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'lbn');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (0, 'Marvel Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 't2__9aa643');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 'Marvel Comics');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__b27ef6',)
*/

-- Prediction Query
SELECT "superhero"."superhero_name", "superhero"."height_cm" FROM "superhero" INNER JOIN "publisher" ON "superhero"."publisher_id" = "publisher"."id" WHERE "publisher"."publisher_name" = 'Marvel Comics' ORDER BY "superhero"."height_cm" DESC, superhero.id NULLS LAST, publisher.id NULLS LAST;

/*
Prediction Result:
('9uxj4hwbdvl', 2103044118)
('cgsk9', 1610062532)
('e4', 1160656988)
('sr', 906324270)
('qi2rkf9v', 556727997)
('e5u', 0)
('ecigce376n', 0)
('z16nijjai5d', 0)
('1jh3den', 0)
('rofqyp5s5b', -1)
('ytoo3o9', -1)
('2dwyrq', -1)
('og', -1)
('qv0gcb98ozk', -155284187)
('8j', -932772113)
('p', -988981234)
*/