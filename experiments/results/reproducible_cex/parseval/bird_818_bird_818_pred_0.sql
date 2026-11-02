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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'wbbp6luhvdlt', 'ilbnp', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1236688122, 2087640001);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'o9hl72kl', 'x1', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -74849714, 105869088);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, '3pyu78d99r', 'jsl', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -346339240, 1692174491);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, '8pz0f8je', 'd2', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1675430660, -688509700);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'h2gn', 'q', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -664193365, -1070063173);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'dz79fjg', '8n2f3', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'i', 'yrk', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 32204797, -1672720816);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'xa', '7ryfdrz16n', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'yzt1afgog', 'itsj3', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -491938169, -106471771);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'e', '8c68', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -683007527, 2035306060);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, '1of77p', 'o72ctdc', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 1303877941, -1284905200);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'q8qdjpe1', 'o22', 1, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, 2004147439, -691774480);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'qcgsk9', '8c4p', 3, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 3, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'u7', 'fe4hri', 5, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, 1914020640, 1268590800);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'hvdlttilbnpr', 'dpos', 6, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'qcgsk9', '8c4p', 7, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'ia2yp', 'uzhsrwbbp6lu', 8, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, 1019800248, -1910425938);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (1, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (2, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (4, 'e5u');

INSERT INTO "alignment" ("id", "alignment") VALUES (3, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (5, 't2__5baf0d');

INSERT INTO "alignment" ("id", "alignment") VALUES (6, NULL);

INSERT INTO "alignment" ("id", "alignment") VALUES (7, 'Bad');

INSERT INTO "alignment" ("id", "alignment") VALUES (8, 'Bad');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, '5k5swwqcgs');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'a9000t5c4eci');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'e');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (5, '5k5swwqcgs');

INSERT INTO "gender" ("id", "gender") VALUES (6, 'puzhsrw');

INSERT INTO "gender" ("id", "gender") VALUES (7, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (8, 'Female');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Bad';

/*
Gold Result:
(20.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN gender.id = 2 THEN 1 ELSE 0 END) AS REAL) * 100.0 / CAST(COUNT(*) AS REAL)) AS female_percentage FROM superhero JOIN gender ON superhero.gender_id = gender.id WHERE superhero.alignment_id = 2;

/*
Prediction Result:
(None,)
*/