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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'ypuzhsrw', 'b', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1072996612, 13244799);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'ie5', 'nw6klf', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1038707349, 1419861592);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (1, 't2__4c8a0f');

INSERT INTO "superpower" ("id", "power_name") VALUES (4, 't2__4c8a0f');

INSERT INTO "superpower" ("id", "power_name") VALUES (2, 'hvdltt');

INSERT INTO "superpower" ("id", "power_name") VALUES (3, 'lbn');

INSERT INTO "superpower" ("id", "power_name") VALUES (5, '5k5swwqcgs');

INSERT INTO "superpower" ("id", "power_name") VALUES (6, '9n8c4pgu7v');

INSERT INTO "superpower" ("id", "power_name") VALUES (7, '4h');

INSERT INTO "superpower" ("id", "power_name") VALUES (8, 'a2y');

INSERT INTO "superpower" ("id", "power_name") VALUES (9, 'uzhsrwbbp6lu');

INSERT INTO "superpower" ("id", "power_name") VALUES (10, 'dlttil');

INSERT INTO "superpower" ("id", "power_name") VALUES (11, 'nprmdposii');

INSERT INTO "superpower" ("id", "power_name") VALUES (12, 'unw6klfa');

INSERT INTO "superpower" ("id", "power_name") VALUES (13, '00t5c4ecigc');

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 3);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 5);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 6);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 7);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 8);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 9);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 10);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 11);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2, 12);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Gold Result:
('t2__4c8a0f',)
('hvdltt',)
('lbn',)
('5k5swwqcgs',)
('9n8c4pgu7v',)
('a2y',)
('uzhsrwbbp6lu',)
('dlttil',)
('nprmdposii',)
('00t5c4ecigc',)
*/

-- Prediction Query
SELECT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Prediction Result:
('t2__4c8a0f',)
('t2__4c8a0f',)
('hvdltt',)
('lbn',)
('hvdltt',)
('lbn',)
('hvdltt',)
('lbn',)
('t2__4c8a0f',)
('t2__4c8a0f',)
('t2__4c8a0f',)
('t2__4c8a0f',)
('t2__4c8a0f',)
('t2__4c8a0f',)
('hvdltt',)
('lbn',)
('5k5swwqcgs',)
('9n8c4pgu7v',)
('a2y',)
('uzhsrwbbp6lu',)
('dlttil',)
('nprmdposii',)
('00t5c4ecigc',)
*/