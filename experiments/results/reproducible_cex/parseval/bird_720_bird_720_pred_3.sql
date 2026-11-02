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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ypuzhsrw', 't1__487d2b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'tilbn', 't1__487d2b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 462974032, -1137908826);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, '6klfa9', 't1__487d2b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '5s5b', 't1__487d2b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2107872094, 882961052);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '1', 'ryytoo3', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1666765085, 1178636309);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'itsj3', 't1__487d2b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -491938169, -106471771);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'o72ctdc', 't1__487d2b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1303877941, -1284905200);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (1, '0t5c4ecigc');

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (5, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T2.power_id) > 15;

/*
Gold Result:
('ryytoo3',)
('t1__487d2b',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN (SELECT hero_id FROM hero_power GROUP BY hero_id HAVING COUNT(DISTINCT power_id) > 15) AS power_count ON superhero.id = power_count.hero_id;

/*
Prediction Result:
*/