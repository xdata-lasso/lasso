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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, '3-D Man', 'ypuzhsrw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, '3-D Man', 'mdpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, '3-D Man', '9000t5c4ec', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1683203397, 528680845);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 743312762, -1822992503);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, NULL, 'g', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -890215420, 1610062532);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '3-D Man', 'vfe4hria2', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1219478689, -1670923962);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, '3-D Man', 'rmdp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2026480202, -1576219117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, '3-D Man', '00t5c4ecigc', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 528680845, -1585009206);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, '3-D Man', 'fqyp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -921187550, -2070843029);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '3-D Man', 'yytoo', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1644911394, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '3-D Man', 'q13py', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 244829661, -1362461264);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: superpower --
INSERT INTO "superpower" ("id", "power_name") VALUES (1, 't3__4ad3c3');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483647, 't3__4ad3c3');

INSERT INTO "superpower" ("id", "power_name") VALUES (3, 't3__4ad3c3');

INSERT INTO "superpower" ("id", "power_name") VALUES (2, 'yytoo');

INSERT INTO "superpower" ("id", "power_name") VALUES (4, 'pgu7vfe4');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483643, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (5, '5k5swwqcgs');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483641, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (6, 'rwbbp6luhvd');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483639, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (7, '5u');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483637, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (8, '52zb');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483635, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (9, '02eu');

INSERT INTO "superpower" ("id", "power_name") VALUES (-2147483633, NULL);

INSERT INTO "superpower" ("id", "power_name") VALUES (10, '72klex14ji7z');

-- Inserting into table: hero_power --
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (3, 1);

INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 2);

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
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.superhero_name = '3-D Man';

/*
Gold Result:
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('yytoo',)
('yytoo',)
('yytoo',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('t3__4ad3c3',)
('5k5swwqcgs',)
('rwbbp6luhvd',)
('5u',)
('52zb',)
('02eu',)
('72klex14ji7z',)
*/

-- Prediction Query
SELECT DISTINCT t3.power_name FROM superhero AS t1 INNER JOIN hero_power AS t2 ON t1.id = t2.hero_id INNER JOIN superpower AS t3 ON t2.power_id = t3.id WHERE t1.superhero_name = '3-D Man';

/*
Prediction Result:
('t3__4ad3c3',)
('yytoo',)
('5k5swwqcgs',)
('rwbbp6luhvd',)
('5u',)
('52zb',)
('02eu',)
('72klex14ji7z',)
*/