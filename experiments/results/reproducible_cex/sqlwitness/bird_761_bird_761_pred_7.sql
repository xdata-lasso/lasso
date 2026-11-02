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
INSERT INTO race (id, race) VALUES (100, 'default2'), (0, NULL), (99, 'default2'), (1, 'default2'), (101, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (99, 'default2'), (0, 'Male'), (100, 'default1'), (78, 'default2'), (101, 'Male'), (79, NULL), (80, 'Male');
INSERT INTO gender (id, gender) VALUES (80, 'Male');
INSERT INTO colour (id, colour) VALUES (0, 'default2'), (78, 'default2'), (100, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (99, NULL, 0, 80, 78, 80, 1, 78, 'Male', 'Male', 79, 101), (80, NULL, NULL, 80, 0, 78, 100, 100, 'default2', NULL, 1, 101), (78, NULL, NULL, 80, 78, NULL, 1, 0, 'Male', 'default1', 0, 80), (100, NULL, 78, 80, NULL, 79, 99, NULL, 'default1', 'Male', NULL, 0), (101, NULL, 78, 80, 100, 0, 1, 0, NULL, 'default1', 99, 79);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('default1',)
(None,)
('Male',)
('default1',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id WHERE g.gender = 'Male' AND s.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);

/*
Prediction Result:
('Male',)
('default2',)
('Male',)
(None,)
*/