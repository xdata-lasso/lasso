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
INSERT INTO race (id, race) VALUES (1, 'default2'), (99, NULL), (0, NULL), (101, 'brown'), (100, 'brown');
INSERT INTO publisher (id, publisher_name) VALUES (101, 'default1'), (0, NULL), (100, 'default2'), (99, 'Brown'), (1, 'Brown'), (2, 'default2'), (3, 'default1'), (4, 'default1'), (5, 'brown');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (101, 'Brown');
INSERT INTO colour (id, colour) VALUES (1, NULL), (100, 'brown'), (101, 'default1'), (99, 'default1'), (0, 'default2'), (2, NULL), (3, 'brown'), (4, 'brown'), (5, NULL), (6, 'brown'), (7, 'brown'), (8, NULL), (9, 'brown'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, 'brown'), (99, 'Brown'), (101, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 1, 8, 101, 99, 2, 1, 11, 'default1', 'default1', 101, 100), (0, 101, 99, 1, 13, 1, 100, 1, NULL, 'default2', NULL, NULL), (100, 99, 1, 1, 13, NULL, NULL, 7, 'Brown', 'brown', NULL, 100), (99, 101, 3, 1, 5, 99, 1, 13, 'default2', 'brown', 99, 100), (101, 101, 2, 1, 99, NULL, 0, 11, 'default2', 'brown', 101, 100), (2, 99, 2, NULL, 1, 4, 0, 10, 'default1', 'default1', 99, 0), (3, 1, 11, 101, 10, 4, 1, 6, NULL, 'Brown', 0, 100), (4, 1, 0, 1, NULL, 0, 101, 6, 'default1', 'default2', 0, 1), (5, NULL, 4, NULL, 12, 100, 101, 6, 'brown', 'default1', 0, 99), (6, 101, 1, 1, 13, NULL, 0, 3, NULL, 'default1', NULL, 0), (7, NULL, 1, NULL, 9, 4, 100, 4, 'brown', 'default2', 99, 100), (8, 101, 2, 101, 13, 4, 0, 10, 'default1', 'brown', 101, NULL), (9, 99, 101, NULL, 8, 5, 0, NULL, 'default1', 'default1', 1, 100), (10, 99, 10, 101, 8, 1, 101, 13, 'Brown', 'default1', 101, 0), (11, 101, 12, 101, 10, 1, NULL, 101, 'brown', 'default1', 99, 101), (12, NULL, 0, 101, 0, NULL, 0, 12, 'Brown', 'brown', 101, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.weight_kg < 100 AND T2.colour = 'Brown';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE LOWER(T2.colour) = 'brown' AND T1.weight_kg < 100;

/*
Prediction Result:
('default1',)
*/