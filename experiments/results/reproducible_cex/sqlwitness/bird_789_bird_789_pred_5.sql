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
INSERT INTO race (id, race) VALUES (0, 'Alien'), (1, 'default2'), (2, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Alien'), (0, 'default2'), (2, 'Alien'), (3, 'default2'), (4, NULL);
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (1, 'default1');
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, 'Alien'), (2, 'default2'), (3, NULL), (4, 'Alien'), (5, 'default1'), (6, 'default1'), (7, NULL), (8, NULL), (9, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, NULL), (2, 'Alien'), (3, 'default1'), (4, NULL), (5, 'Alien'), (6, 'default1'), (7, NULL), (8, 'default2'), (9, 'default2'), (10, 'Alien');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, 7, 0, 3, 0, 2, 4, 'default1', NULL, 1, 0), (1, 3, 5, NULL, NULL, 3, 0, 1, 'Alien', 'default2', 0, NULL), (2, 7, 0, NULL, 2, 3, 0, 7, 'default1', NULL, 1, 1), (3, 10, 9, NULL, 8, 2, 1, 6, NULL, 'default1', 1, 1), (4, 0, 8, 0, 6, NULL, 2, 3, 'Alien', 'default2', 1, 1), (5, 7, 6, 0, NULL, NULL, 0, 4, 'default2', 'default1', 1, 1), (6, 1, 6, 0, 2, 4, 2, 4, 'default2', 'default1', NULL, NULL), (7, 10, 8, NULL, NULL, NULL, 1, 9, 'default2', NULL, NULL, NULL), (8, 7, 7, NULL, 9, 4, NULL, 6, NULL, NULL, 0, NULL), (9, 3, 1, 1, 2, 3, 0, 3, 'default2', NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.weight_kg) AS REAL) / COUNT(T1.id) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Alien';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT AVG(s.weight_kg) AS average_weight FROM superhero AS s JOIN race AS r ON s.race_id = r.id WHERE r.race = 'Alien';

/*
Prediction Result:
(0.6666666666666666,)
*/