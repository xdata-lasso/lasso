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
INSERT INTO race (id, race) VALUES (100, 'Male'), (79, 'default2'), (1, 'default2'), (101, 'Male'), (78, 'default1'), (99, NULL), (80, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (79, 'default1'), (0, 'default2'), (99, 'default1'), (100, 'default2'), (78, NULL), (101, NULL), (80, 'default1'), (1, 'Male'), (2, 'default1'), (3, 'Male');
INSERT INTO gender (id, gender) VALUES (1, NULL), (78, NULL), (0, 'Male'), (80, 'default1'), (100, NULL), (99, NULL), (79, 'default2'), (101, 'default2'), (2, NULL), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default1'), (7, NULL), (8, NULL), (9, 'default2'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, 'default1'), (14, NULL), (15, 'default1'), (16, 'default1');
INSERT INTO colour (id, colour) VALUES (1, NULL), (100, 'Male'), (0, 'default2'), (101, 'Male'), (78, 'default2'), (80, NULL), (99, 'default1'), (79, 'Male'), (2, 'Male'), (3, 'Male'), (4, NULL), (5, 'Male');
INSERT INTO alignment (id, alignment) VALUES (79, 'default2'), (99, 'default1'), (1, 'Male'), (0, NULL), (101, 'Male'), (80, 'default1'), (100, 'default2'), (78, 'default1'), (2, 'Male'), (3, NULL), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, NULL), (8, 'default2'), (9, 'Male');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (100, 80, 100, 99, 4, 101, 79, 2, NULL, 'default1', 1, 1), (79, 6, 3, 9, 2, 0, 1, 78, 'default2', 'default1', NULL, 1), (78, 3, 3, 7, 4, 79, 78, 5, NULL, 'default1', 78, 99), (101, 99, 1, 0, 78, 78, 100, 80, 'default2', NULL, 0, 78), (0, 80, 0, 2, 0, 100, NULL, 3, 'Male', 'default1', 78, 0), (1, 3, 101, 0, 2, 2, 99, 3, NULL, NULL, 100, 100), (80, 2, 100, 8, 2, 78, 99, 3, 'default2', 'default1', 101, 1), (99, 79, 2, 3, 101, 101, NULL, 0, 'Male', 'default2', 99, 100), (2, 1, 100, 79, 101, 80, 79, 3, NULL, 'default1', 80, 99), (3, 8, 4, 7, NULL, 78, 79, 1, 'default2', 'default2', 78, NULL), (4, 100, 0, 3, 78, 3, 1, 80, 'default1', 'default2', 79, 78), (5, 1, 79, 80, 1, NULL, 79, NULL, NULL, 'default1', 1, 101), (6, 99, 2, 11, 5, 99, 1, 4, 'Male', NULL, 78, 101), (7, 7, 78, 2, 79, NULL, 79, 2, 'Male', 'Male', 78, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN gender AS g ON s.gender_id = g.id WHERE g.gender = 'Male' AND s.weight_kg > (0.79 * (SELECT AVG(weight_kg) FROM superhero));

/*
Prediction Result:
(None,)
('default2',)
*/