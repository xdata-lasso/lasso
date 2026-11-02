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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'e4', 'hria2ypuzhs', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'n', 'rmdp', -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '00t5c4ecigc', 'e376nium52', -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'qyp5s5bbp0', '2eutliqa11r', -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '9hl7', 'klex14ji', -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'yrq13p', 'u78d99r', -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'yp5qi2rk', '9v', -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'f8jegd21vy9u', 'j4hwbd', -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'dqwn', 'cx5hn', -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'dz79fjg', '8n2f3', -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'q7x', '7', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 188, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'dr', 'z16nijjai5d', -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, -2147483648, 188, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'd8y', 't1afgog', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'y', 'p1q430', -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, -2147483648, 1, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, '8c68', '8vacx7', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'f77p', 'o72ctdc', -2147483648, -2147483648, -2147483648, -2147483648, 3, -2147483648, -2147483648, 188, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'u7vfe4hria2y', 'uzhs', -2147483648, -2147483648, -2147483648, -2147483648, 4, -2147483648, -2147483648, NULL, 108);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'nprmdposii', '5u', -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, -2147483648, 1, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'c4ecigce', '76nium52', -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, -2147483648, NULL, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'bbp02eutliqa', '1ryytoo', -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, -2147483648, 188, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, '7zwau2dwyr', '13pyu', -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -2147483648, 1, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'i2rkf', 'vqx58pz0f', -2147483648, -2147483648, -2147483648, -2147483648, 11, -2147483648, -2147483648, NULL, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'u7vfe4hria2y', 'uzhs', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 188, 108);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 't2__7e0acf');

INSERT INTO "race" ("id", "race") VALUES (3, 'luhvdltti');

INSERT INTO "race" ("id", "race") VALUES (2, 't2__7e0acf');

INSERT INTO "race" ("id", "race") VALUES (5, 'unw6klfa');

INSERT INTO "race" ("id", "race") VALUES (6, 'rqro');

INSERT INTO "race" ("id", "race") VALUES (4, '5k5swwqcgs');

INSERT INTO "race" ("id", "race") VALUES (7, 'rwbbp6luhvd');

INSERT INTO "race" ("id", "race") VALUES (8, 'w6kl');

INSERT INTO "race" ("id", "race") VALUES (9, 'zbuo4nrqrof');

INSERT INTO "race" ("id", "race") VALUES (10, 'o9hl72kl');

INSERT INTO "race" ("id", "race") VALUES (11, '8d99rljsl');

INSERT INTO "race" ("id", "race") VALUES (12, '5k5swwqcgs');

INSERT INTO "race" ("id", "race") VALUES (-2147483636, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.race FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T1.weight_kg = 108 AND T1.height_cm = 188;

/*
Gold Result:
('t2__7e0acf',)
('luhvdltti',)
('unw6klfa',)
('rqro',)
('5k5swwqcgs',)
*/

-- Prediction Query
SELECT race.race FROM superhero JOIN race ON superhero.race_id = race.id WHERE weight_kg = 108 AND height_cm = 188;

/*
Prediction Result:
('t2__7e0acf',)
('luhvdltti',)
('unw6klfa',)
('rqro',)
('unw6klfa',)
('rqro',)
('unw6klfa',)
('rqro',)
('t2__7e0acf',)
('luhvdltti',)
('t2__7e0acf',)
('luhvdltti',)
('5k5swwqcgs',)
*/