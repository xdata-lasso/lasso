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
INSERT INTO race (id, race) VALUES (99, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (99, 'default2'), (101, 'default1'), (100, NULL);
INSERT INTO gender (id, gender) VALUES (100, NULL), (99, 'default2'), (101, NULL), (0, 'default2'), (1, 'default2');
INSERT INTO colour (id, colour) VALUES (99, NULL), (0, 'default2'), (1, 'default1'), (101, NULL), (100, NULL), (2, 'default1'), (3, NULL), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, 'default2'), (9, 'default1'), (10, 'default2'), (11, 'default1'), (12, 'default1'), (13, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (1, 'default2'), (99, NULL), (100, 'default2'), (101, NULL), (0, 'default2'), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, 'default2');
INSERT INTO alignment (id, alignment) VALUES (101, 'default1'), (100, 'default1'), (0, 'default1'), (99, NULL), (1, 'default1'), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'default1'), (6, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (99, 2, 8, 1, 13, 100, 99, 2, 'default1', NULL, 99, 0), (100, 5, 13, 101, 1, 100, NULL, 7, NULL, 'default2', 100, 100), (1, 5, 4, 0, 3, NULL, 99, 10, NULL, 'default2', 100, 101), (101, 3, 6, 99, 7, 101, NULL, 100, NULL, 'default2', 1, 100), (0, 0, 11, 100, 1, NULL, NULL, 99, 'default1', 'default2', NULL, 99), (2, 101, 3, 100, 2, 101, NULL, 4, 'default2', 'default1', 1, 0), (3, 0, 100, NULL, 2, 99, 99, 4, NULL, 'default2', 0, 100), (4, 3, 12, 101, 12, 101, 99, 101, 'default1', 'default2', 99, 101), (5, 101, 13, 100, 0, 101, 99, 11, NULL, 'default2', NULL, 100), (6, 2, 1, 101, 0, NULL, NULL, 1, 'default1', NULL, 101, 100), (7, 1, 99, 99, 6, 100, 99, 2, 'default1', NULL, 100, 0), (8, 3, 6, 100, 6, 101, NULL, 5, 'default1', 'default2', 101, 101), (9, NULL, 1, 99, 101, 101, NULL, 0, 'default1', NULL, 100, 0), (10, 6, NULL, 1, 1, NULL, NULL, 7, 'default2', NULL, 1, 1), (11, NULL, 6, 0, 3, 101, 99, 1, 'default1', NULL, NULL, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (1, 7, 100), (0, 0, NULL), (3, NULL, 0), (2, 6, 100), (6, 9, 1), (0, 3, NULL), (3, 2, 0), (0, 101, NULL), (3, NULL, NULL), (99, 101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Prediction Result:
('default1',)
('default1',)
*/