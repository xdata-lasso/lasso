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
INSERT INTO race (id, race) VALUES (78, 'Male'), (101, 'default2'), (0, 'default2'), (1, 'default1'), (100, 'M'), (99, NULL), (79, 'M'), (80, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (80, NULL), (100, NULL), (101, NULL), (78, NULL), (0, 'M'), (99, 'default1'), (79, 'default1'), (1, 'M'), (2, 'default2');
INSERT INTO gender (id, gender) VALUES (99, 'default1'), (79, 'default1'), (0, 'Male'), (100, 'Male');
INSERT INTO colour (id, colour) VALUES (0, NULL), (100, 'default2'), (101, 'Male'), (99, 'Male'), (1, 'default2'), (78, 'default2'), (80, 'default2'), (79, 'default2');
INSERT INTO alignment (id, alignment) VALUES (99, NULL), (1, 'M'), (100, 'Male');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (78, 100, 79, 99, 80, NULL, 80, 0, 'M', NULL, NULL, 80), (79, 99, NULL, 0, 78, 78, NULL, 100, 'default2', 'default1', 1, 100), (101, 1, 78, 79, 99, 79, 1, 101, NULL, 'default2', 101, NULL), (80, 1, 1, 100, 1, 100, 0, 0, 'default2', 'default2', 79, 0), (100, 99, 79, 100, 1, 0, 79, 1, NULL, NULL, 80, 1), (99, NULL, 100, NULL, 99, 80, 80, 79, 'M', 'M', 99, 79);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'M' AND T1.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);

/*
Prediction Result:
*/