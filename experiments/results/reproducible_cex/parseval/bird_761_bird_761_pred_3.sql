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

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '76nium52', 't1__89645e', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'fqyp', 't1__89645e', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -921187550, -2070843029);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'iqa', 't1__89645e', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -314162272, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'qi2rkf9v', 'x58pz', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1529584866, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'j4hwbd', 'lph2gn', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1968874827, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'hncprjtu0dz', 't1__89645e', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1748371085, -1742081330);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'gcb98oz', '3zb', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1554531873, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'ah0f8jsww', 'q7x', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -541746689, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, '16nijjai5dh', 't1__89645e', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1583472758, 1449284300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, '1afgogritsj', NULL, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -197933860, 2111987706);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'jh3den8', NULL, 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 195720193, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'w1of77pz', NULL, 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 87529806, NULL);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, 'g6', NULL, 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -242584410, -698610044);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'io22785', 't1__89645e', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2119806856, -1962347906);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '36c', 'bfkfoacd', 3, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2115816682, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'wgxd5ysxc', 'r0oz', 4, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -870767087, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'pim5', '58q', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1817366143, 8855);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '2m', 'ajjl', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2096405521, 885499);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'yz7zzbe8yvk', 'v42q7sx58b4p', 6, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 319284352, 8855);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'rpdjwzw5ch', '9mo7', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -354292049, 885499);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'b', 'q0k32od', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -613916489, 8855);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'lwyng', '1', 6, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 681061317, 885499);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'o6l0hdt', 'fuqyxuzkb', 8, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -30041412, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'elboeowii', 'z5nxih6', 3, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -251205568, -1);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (14, 'qb0tbindz39t', 'j', 9, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -841516418, 8855);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (15, 'c', '3tdu6bd0w960', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 740386991, 885499);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (16, '62nh55y3dohv', '06dza3', 10, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1595632888, 0);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (17, 'hy08ftp6', 'wt', -2147483644, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1051623642, -1);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (4, '5c4ec');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483644, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'jpttg');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483642, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (5, 'j5');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483640, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (6, 'okv8uttmu2');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483638, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (7, 'a9n0jxfofws');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483636, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (8, 'iz');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483634, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (9, 'xlyotow9');

INSERT INTO "gender" ("id", "gender") VALUES (-2147483632, 'Male');

INSERT INTO "gender" ("id", "gender") VALUES (10, 'xw1rxe9');

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
('t1__89645e',)
(None,)
('uzhsrwbbp6lu',)
('rmdp',)
('9mo7',)
('wt',)
*/

-- Prediction Query
SELECT superhero.superhero_name FROM superhero INNER JOIN gender ON superhero.gender_id = gender.id WHERE gender.gender = 'Male' AND superhero.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);

/*
Prediction Result:
('16nijjai5dh',)
('1afgogritsj',)
('ia2yp',)
('n',)
('rpdjwzw5ch',)
('hy08ftp6',)
*/