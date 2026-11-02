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
INSERT INTO "colour" ("id", "colour") VALUES (1, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'ilbnp');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'dpos');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Blue');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'ypuzhsrw', 'b', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 1072996612, 13244799);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, '37', 'nium52zbu', -2147483648, 1, 4, 4, -2147483648, -2147483648, -2147483648, -1179823637, 1119186446);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'bbp02eut', 'iqa', -2147483648, 1, 3, 3, -2147483648, -2147483648, -2147483648, -314162272, 2137741668);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'x1', 'ji7zwau2', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 364869063, -953437896);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'd99rljsl0', '4', -2147483648, 1, 1, 4, -2147483648, -2147483648, -2147483648, 1649269347, -1116181514);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'vqx58pz0f', '8jegd21vy9ux', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, -1492524358, -1612443122);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'cgsk9', '8c4p', -2147483648, 2, 2, 4, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'cgsk9', '8c4p', -2147483648, 8, 2, 4, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'a2ypuzhsrwbb', 'p6luhvdlttil', -2147483648, 1, 2, 3, -2147483648, -2147483648, -2147483648, 429706943, 462974032);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'cgsk9', '8c4p', -2147483648, 5, 2, 4, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'a2y', 'uzhs', -2147483648, 7, 3, 8, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'dlttil', 'n', -2147483648, 9, 2, 3, -2147483648, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'w6kl', 'a9', -2147483648, 10, 4, 6, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '9n8');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.colour = 'Blue' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id;

/*
Gold Result:
(46.15384615384615,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.eye_colour_id = (SELECT id FROM colour WHERE colour = 'Blue') THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1;

/*
Prediction Result:
(7.6923076923076925,)
*/