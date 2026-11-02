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
INSERT INTO race (id, race) VALUES (99, 'default1'), (100, 'default2'), (101, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (100, 'default1');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (101, 'default1'), (100, NULL), (0, NULL), (99, 'default1'), (2, NULL), (3, NULL), (4, NULL), (5, NULL), (6, 'default1'), (7, NULL), (8, 'default1'), (9, NULL), (10, 'default1');
INSERT INTO colour (id, colour) VALUES (99, 'default2'), (1, NULL), (101, 'default2'), (100, NULL), (0, 'default2'), (2, NULL), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, NULL), (8, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (101, 'default1'), (99, NULL), (100, 'default2'), (1, 'default2'), (0, 'default2'), (2, NULL), (3, 'default1'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'default1'), (8, NULL), (9, NULL), (10, 'default1'), (11, 'default1'), (12, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'default2'), (100, 'default2'), (99, NULL), (101, NULL), (2, NULL), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, NULL), (10, NULL), (11, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (101, NULL, 2, NULL, 1, 0, 99, NULL, NULL, 'default1', 1, 1), (100, 10, NULL, NULL, 7, 0, NULL, 1, NULL, 'default2', 1, NULL), (99, 2, 0, 99, 7, NULL, 100, 1, 'default1', 'default2', 99, 0), (0, 10, 4, 100, 6, NULL, NULL, 3, NULL, 'default1', 99, 0), (1, NULL, 101, 10, 100, 0, NULL, 99, 'default1', 'default1', NULL, 0), (2, 1, 0, 4, 3, 0, 100, NULL, NULL, 'default2', 101, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (1, 0, 1), (NULL, 2, NULL), (0, NULL, 99), (11, 99, NULL), (12, 99, 1), (0, 99, 100), (11, 0, 0), (0, NULL, 100), (7, 99, 100), (11, 2, 101), (3, 0, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT T3.colour FROM hero_attribute AS T1 JOIN superhero AS T2 ON T1.hero_id = T2.id JOIN colour AS T3 ON T2.skin_colour_id = T3.id WHERE T1.attribute_value = 100;

/*
Prediction Result:
(None,)
(None,)
('default2',)
*/