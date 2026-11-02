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
INSERT INTO race (id, race) VALUES (1, 'Alien'), (0, 'Alien'), (2, 'default1'), (3, 'Alien'), (4, 'default2'), (5, 'Alien'), (6, NULL), (7, 'Alien'), (8, 'Alien'), (9, 'Alien'), (10, 'default2'), (11, 'default1'), (12, 'default2'), (13, 'default1'), (14, 'Alien'), (15, NULL), (16, NULL), (17, NULL), (18, NULL), (19, NULL), (20, 'default1'), (21, 'Alien');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (0, 'Alien'), (2, 'Alien'), (3, 'Alien'), (4, 'default2'), (5, 'Alien'), (6, 'default2'), (7, 'default2'), (8, 'Alien'), (9, 'default2'), (10, NULL), (11, 'default2'), (12, 'default2'), (13, 'default2'), (14, NULL), (15, 'Alien'), (16, 'default2'), (17, NULL), (18, 'Alien'), (19, 'default2'), (20, 'default2'), (21, 'default2'), (22, 'default1'), (23, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'Alien'), (0, 'default2'), (2, 'default1'), (3, 'default1'), (4, 'default2'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, 'Alien'), (9, 'Alien'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'default2'), (1, 'default1'), (2, 'default1'), (3, 'default1'), (4, 'Alien'), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, 'Alien'), (10, 'Alien'), (11, NULL), (12, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, NULL, 3, 1, 15, 21, 9, 'default2', NULL, NULL, 0), (1, NULL, 10, 12, 6, 6, 16, 10, NULL, NULL, 0, 1), (2, NULL, NULL, 12, 9, 22, 9, 5, 'default2', 'default2', 0, NULL), (3, NULL, 0, 5, 12, 7, 6, 0, 'Alien', 'default2', NULL, NULL), (4, NULL, 11, 12, 2, 7, 10, 4, 'default2', 'default1', 0, 1), (5, NULL, 4, 1, 0, 9, 2, 2, 'default2', 'default2', 0, 1), (6, NULL, 8, 11, 7, 9, 10, 8, NULL, 'default1', NULL, 1), (7, NULL, 5, 6, 9, 10, 8, 1, 'default2', 'Alien', 0, NULL), (8, NULL, 4, 2, 6, 11, 11, 0, 'default1', 'default2', 1, 1), (9, NULL, 11, 3, 4, 9, 15, 1, 'Alien', 'Alien', NULL, 1), (10, NULL, NULL, 6, 7, 19, 16, 4, NULL, 'default1', 0, 0), (11, NULL, 11, 13, 2, 20, 21, 0, 'default2', 'Alien', 0, NULL), (12, NULL, 11, 0, 8, 7, 19, 10, 'Alien', 'default1', 0, 1), (13, NULL, 10, 2, 7, 22, 8, 1, NULL, 'default1', 0, 1), (14, NULL, 3, 4, 0, 19, 20, 5, 'Alien', 'Alien', 1, 1), (15, NULL, 5, 10, 11, 0, 7, 2, 'default2', NULL, NULL, NULL), (16, NULL, 0, 4, 4, 10, 16, 10, NULL, 'default2', 0, 1), (17, NULL, 7, 9, 11, 21, 5, 1, 'default2', NULL, 1, 1), (18, NULL, 10, 9, 0, 2, 1, 9, NULL, 'Alien', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.weight_kg) AS REAL) / COUNT(T1.id) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Alien';

/*
Gold Result:
(0.25,)
*/

-- Prediction Query
SELECT AVG(CAST(weight_kg AS REAL)) FROM superhero JOIN race ON superhero.race_id = race.id WHERE race.race = 'Alien';

/*
Prediction Result:
(0.5,)
*/