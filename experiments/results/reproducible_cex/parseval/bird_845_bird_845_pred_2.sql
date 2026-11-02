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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ypuzhsrw', 'b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1072996612, 13244799);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'lbn', 'rmdp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2026480202, -1576219117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, '00t5c4ecigc', 'e376nium52', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'kf9vq', 'x58pz0f8je', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, 1196308825);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'j4hwbdvlph', 'gndqwnqc', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, 555413010);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'dqv0gcb9', 'ozk3zbily', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, 638024588);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 'jswwlq7xb', '72fxa7ryfd', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, NULL, 564390026);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (2, 't3__cc03b8');

INSERT INTO "superpower" ("id", "power_name") VALUES (3, '5u');

INSERT INTO "superpower" ("id", "power_name") VALUES (1, 'u0dz7');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483645, 'G');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483644, 'A');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483643, 'O');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483642, 'A');

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm * 100 > (SELECT AVG(height_cm) FROM superhero) * 80;

/*
Gold Result:
('t3__cc03b8',)
('5u',)
('t3__cc03b8',)
('5u',)
('t3__cc03b8',)
('5u',)
*/

-- Prediction Query
SELECT DISTINCT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.height_cm > (SELECT AVG(height_cm) * 0.8 FROM superhero);

/*
Prediction Result:
('t3__cc03b8',)
('5u',)
*/