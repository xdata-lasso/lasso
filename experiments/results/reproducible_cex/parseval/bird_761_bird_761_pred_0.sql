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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ia2yp', 'uzhsrwbbp6lu', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1019800248, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'n', 'rmdp', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2026480202, 1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '76nium52', 't1__07de85', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'fqyp', 't1__07de85', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -921187550, -2070843029);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'iqa', 't1__07de85', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -314162272, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'qi2rkf9v', 'x58pz', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1529584866, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'j4hwbd', 'lph2gn', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1968874827, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'hncprjtu0dz', 't1__07de85', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1748371085, -1742081330);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'gcb98oz', '3zb', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1554531873, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'ah0f8jsww', 'q7x', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -541746689, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, '16nijjai5dh', 't1__07de85', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1583472758, 1449284300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '1afgogritsj', NULL, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -197933860, 2111987706);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'jh3den8', NULL, 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 195720193, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'w1of77pz', NULL, 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 87529806, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'g6', NULL, 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -242584410, -698610044);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'io22785', 't1__07de85', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2119806856, -1962347906);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '6c4bfkfo', 'c', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -406331049, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'xd', 'ysxcmr0o', 2, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 853709925, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'm5k', '8qs27p2r', -2147483644, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -95808609, 885499);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'jla', 'okv8uttm', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1553368934, 8855);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'be8yvkv42q7', 'x58b4', 2, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1122409769, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'mkrpdj', 'wzw5chn9mo70', 6, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 628082526, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, '0', '0k32o', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1898678660, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'orlwyngc1dj', '9erhizgk1yoe', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1483450542, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, '521gwnlas6e', 'lboeowii1z5', 2, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1557188093, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'lyotow', 'oaawg96aq', 8, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2061634386, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (15, 'n5wcgumbc', '3tdu6bd0w960', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 740386991, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (14, '9y', 'k7', 9, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1046720861, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (17, '3', 'rmkio18r', -2147483638, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 431832073, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (16, '6ewt', 'xxnja', 10, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2080232972, 0);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (4, '5c4ec');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483644, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'jpttg');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483642, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (5, 'dgj5i');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483640, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (6, 'e578');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483638, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (7, '9n0jxfofwsz');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483636, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (8, 'o6l0hdt6fu');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483634, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (9, 'bindz');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483632, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (10, '162nh55y3d');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'gu7v');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('t1__07de85',)
(None,)
('uzhsrwbbp6lu',)
('rmdp',)
('c',)
('8qs27p2r',)
('3tdu6bd0w960',)
('rmkio18r',)
*/

-- Prediction Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'M' AND T1.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);

/*
Prediction Result:
*/