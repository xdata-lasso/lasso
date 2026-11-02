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

INSERT INTO "colour" ("id", "colour") VALUES (2, '9000t5c4ec');

INSERT INTO "colour" ("id", "colour") VALUES (4, '6nium52zb');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (5, '5k5swwqcgs');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'b');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Blue');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'hria2ypuzhs', 'rwbbp6luhvd', 1, 1, 1, 1, -2147483648, -2147483648, -2147483648, -1377057208, -841692980);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ytoo3o9hl7', 'klex14ji', 1, 2, 2, 1, -2147483648, -2147483648, -2147483648, -453362185, 481163439);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'yrq13pyu78d9', 'rljsl0b4y', 1, 4, 2, 1, -2147483648, -2147483648, -2147483648, -1116181514, 1255852738);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, '0gcb98', 'zk3z', 1, 2, 4, 1, -2147483648, -2147483648, -2147483648, 1686459626, -1554531873);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, '6vck6ah0f8js', 'wlq7xb', 1, 2, 4, 1, -2147483648, -2147483648, -2147483648, 602161869, 1350414441);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'dr', 'z16nijjai5d', 1, 1, 4, 1, -2147483648, -2147483648, -2147483648, -1625552518, -1738458256);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'qcgsk9', '8c4p', 3, 2, 3, 3, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'pgu7vfe4', 'hria2ypuzhs', 5, 5, 5, 5, -2147483648, -2147483648, -2147483648, 700293388, 906324270);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'dlttil', 'n', 6, 5, 2, 6, -2147483648, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'qcgsk9', '8c4p', 7, 2, 3, 7, -2147483648, -2147483648, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'ia2yp', 'uzhsrwbbp6lu', 8, 2, 2, 8, -2147483648, -2147483648, -2147483648, 1019800248, -1910425938);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '9n8');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (1, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (2, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (4, 'posiie5unw6k');

INSERT INTO "gender" ("id", "gender") VALUES (3, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (5, 't2__4280df');

INSERT INTO "gender" ("id", "gender") VALUES (6, NULL);

INSERT INTO "gender" ("id", "gender") VALUES (7, 'Female');

INSERT INTO "gender" ("id", "gender") VALUES (8, 'Female');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'gu7v');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'e4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.colour = 'Blue' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T2.gender = 'Female';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T3.colour = 'Blue' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.gender) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id WHERE T2.gender = 'Female';

/*
Prediction Result:
(0.0,)
*/