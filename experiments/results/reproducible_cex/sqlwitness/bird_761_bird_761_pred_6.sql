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
INSERT INTO race (id, race) VALUES (80, 'Male'), (0, 'default1'), (99, 'default2'), (78, 'default2'), (1, NULL), (100, 'Male'), (79, 'default1'), (101, NULL), (2, 'default1'), (3, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (79, 'Male'), (80, 'default1'), (99, NULL), (78, 'default2'), (1, NULL), (100, 'default2'), (101, 'default1'), (0, 'default2'), (2, 'default2'), (3, 'default1'), (4, 'Male'), (5, 'Male'), (6, NULL);
INSERT INTO gender (id, gender) VALUES (1, NULL), (0, 'Male'), (78, 'default2'), (99, 'default1'), (80, NULL), (100, 'Male'), (101, 'default1'), (79, 'Male'), (2, 'Male'), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'Male'), (7, 'Male');
INSERT INTO colour (id, colour) VALUES (78, 'default2'), (79, 'Male'), (99, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, NULL, 7, 78, 101, 101, 78, 'default1', 'default2', 0, 78), (99, NULL, NULL, 2, 78, 2, 100, NULL, NULL, 'Male', 99, NULL), (78, NULL, 78, 0, NULL, 3, 80, 79, 'Male', NULL, 1, 99), (80, NULL, NULL, 80, 79, 6, NULL, NULL, 'Male', 'default2', 1, 99), (1, NULL, 78, 3, 99, 80, 3, 79, NULL, 'Male', 99, 100), (101, NULL, 99, 79, 99, 0, 78, NULL, 'Male', 'default1', NULL, NULL), (100, NULL, 78, 2, NULL, 5, 80, 78, NULL, 'Male', 0, 79), (79, NULL, NULL, 1, 99, 101, 99, 78, 'default1', NULL, 1, 101), (2, NULL, 78, 4, 99, 5, 101, 99, NULL, NULL, NULL, NULL), (3, NULL, 78, 79, 79, 5, 101, NULL, 'default1', 'default2', 1, 0), (4, NULL, 78, NULL, NULL, 2, 3, 99, NULL, 'default1', 100, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('default2',)
(None,)
('Male',)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 WHERE T1.gender_id = (SELECT id FROM gender WHERE gender = 'Male') AND T1.weight_kg > (SELECT AVG(weight_kg) FROM superhero) * 0.79;

/*
Prediction Result:
('Male',)
*/