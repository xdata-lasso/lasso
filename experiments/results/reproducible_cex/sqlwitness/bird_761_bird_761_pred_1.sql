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
INSERT INTO race (id, race) VALUES (100, 'Male'), (1, NULL), (78, 'default1'), (99, 'default2'), (101, 'default2'), (79, 'Male'), (80, 'Male'), (0, 'Male');
INSERT INTO publisher (id, publisher_name) VALUES (80, 'default2'), (1, NULL);
INSERT INTO gender (id, gender) VALUES (78, 'Male'), (80, 'default1');
INSERT INTO colour (id, colour) VALUES (99, 'default2'), (80, 'Male'), (100, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (79, 'Male'), (100, 'default1'), (101, 'default1'), (78, 'Male'), (99, NULL), (80, 'default1'), (1, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (99, 80, 99, 80, NULL, NULL, NULL, 100, 'default2', 'default1', 0, 80), (101, 80, 100, 78, 99, NULL, NULL, 100, 'default1', NULL, 101, 78), (78, NULL, 99, 80, 80, 1, 80, NULL, NULL, 'Male', 78, NULL), (79, 100, 99, 78, NULL, 1, 100, 99, 'default1', NULL, 1, 100), (0, 80, 100, 80, 80, 1, 0, 100, 'Male', 'default2', 0, NULL), (100, 1, NULL, 80, 99, 80, 80, 99, 'Male', 'default2', 1, 1), (80, NULL, 99, 78, 99, NULL, 79, 80, 'Male', 'default1', 1, 100), (1, NULL, 99, NULL, 80, NULL, NULL, 99, NULL, 'default1', 101, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
(None,)
('default1',)
(None,)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);

/*
Prediction Result:
('default1',)
('Male',)
('default1',)
*/