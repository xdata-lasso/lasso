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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'wbbp6luhvdlt', 'ilbnp', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'fa9', '00t5c4e', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1274489983, -1683203397);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '52zbuo4nrq', 'rofqyp5s5b', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, '1', 'ryytoo3', 2, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1666765085, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'u7vfe4hria2y', 'uzhs', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'u7vfe4hria2y', 'uzhs', 6, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'tti', 'bnp', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '0t5c4ecigc', 'e376nium52', 8, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 's5bbp02e', 'tliqa1', 9, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2074205376, 274769912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'x14ji7zwau2d', 'yrq13p', 10, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -533293970, 176380444);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'kf9vq', 'x58pz0f8je', 11, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1196308825, 910894705);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 't4__06ba99');

INSERT INTO "gender" ("id", "gender") VALUES (2, 't4__06ba99');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483647, 't4__06ba99');

INSERT INTO "gender" ("id", "gender") VALUES (3, 't4__06ba99');

INSERT INTO "gender" ("id", "gender") VALUES (4, '2dwyrq13pyu7');

INSERT INTO "gender" ("id", "gender") VALUES (5, '5k5swwqcgs');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483642, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (6, '5k5swwqcgs');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483640, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (7, 'b');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483638, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (8, 'dposiie5unw');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483636, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (9, '4nrq');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483634, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (10, 'oo3o9');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483632, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (11, '9rljsl0b4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (1, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483647, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (2, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (3, '7zw');

INSERT INTO "superpower" ("id", "power_name") VALUES (4, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (5, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (6, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (7, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (8, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (9, 'Phoenix Force');

INSERT INTO "superpower" ("id", "power_name") VALUES (10, 'Phoenix Force');

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (4, 4);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 5);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (6, 6);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (7, 7);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (8, 8);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (9, 9);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (10, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.gender FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T3.power_name = 'Phoenix Force';

/*
Gold Result:
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('t4__06ba99',)
('5k5swwqcgs',)
('b',)
('dposiie5unw',)
('4nrq',)
('oo3o9',)
('9rljsl0b4',)
*/

-- Prediction Query
SELECT DISTINCT gender.gender FROM gender INNER JOIN superhero ON gender.id = superhero.gender_id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Phoenix Force';

/*
Prediction Result:
('t4__06ba99',)
('5k5swwqcgs',)
('b',)
('dposiie5unw',)
('4nrq',)
('oo3o9',)
('9rljsl0b4',)
*/