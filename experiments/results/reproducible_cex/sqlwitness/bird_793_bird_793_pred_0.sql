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
INSERT INTO race (id, race) VALUES (22, NULL), (2, 'default1'), (1, 'default1'), (0, 'Male'), (20, 'default2'), (21, 'Male'), (3, 'default1'), (4, 'Male');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (22, 'default2'), (2, 'Male'), (0, NULL), (21, 'default1'), (20, 'Male'), (3, NULL), (4, 'default1'), (5, 'default2'), (6, 'Male'), (7, 'Male'), (8, NULL), (9, NULL), (10, 'default1'), (11, 'god/eternal'), (12, 'default2'), (13, 'god/eternal'), (14, 'default1');
INSERT INTO gender (id, gender) VALUES (22, 'Male'), (0, NULL), (1, 'default1'), (20, 'Male'), (2, NULL), (21, 'default1');
INSERT INTO colour (id, colour) VALUES (22, 'default2'), (2, NULL), (0, 'default1'), (1, 'god/eternal'), (21, 'Male'), (20, 'default1'), (3, 'default2'), (4, 'Male'), (5, 'default1'), (6, 'default1'), (7, 'god/eternal'), (8, 'Male'), (9, 'god/eternal'), (10, 'default1'), (11, NULL), (12, NULL);
INSERT INTO alignment (id, alignment) VALUES (21, 'default1'), (2, 'god/eternal'), (0, 'god/eternal'), (22, 'Male'), (1, NULL), (20, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 22, 21, 1, 22, 1, 21, 20, 'default1', NULL, 1, NULL), (21, 1, 4, 20, 4, 8, 3, 11, 'Male', 'god/eternal', 21, 2), (1, NULL, 22, 2, 21, 9, 22, 3, 'Male', 'god/eternal', NULL, 0), (20, 22, 7, 21, 20, 3, 2, 8, 'god/eternal', 'god/eternal', 20, NULL), (2, 1, 4, 1, 8, 3, 1, 7, 'god/eternal', 'god/eternal', 20, 2), (22, 2, 9, 0, 3, 22, 20, NULL, 'default2', NULL, 21, 0), (3, NULL, 7, 21, 4, 8, 20, 3, 'default1', NULL, 22, 22), (4, 22, 7, 0, 0, 6, NULL, 10, 'god/eternal', 'Male', NULL, 2), (5, 21, 6, NULL, 7, 8, 1, 2, 'default1', 'Male', 1, 0), (6, 22, 21, 21, 5, 8, 4, 8, 'god/eternal', 'default1', 0, 22), (7, 1, 1, NULL, 22, 6, 21, 22, 'default1', 'default2', 2, 21), (8, 0, 10, 21, 20, 10, 3, 2, NULL, 'Male', 1, 1), (9, 20, 10, 0, 3, 3, 0, 1, 'Male', 'Male', 21, 0), (10, NULL, 20, 0, 6, 7, 1, 12, 'default2', 'Male', 21, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T1.race_id = 21 AND T1.gender_id = 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero INNER JOIN race ON superhero.race_id = race.id INNER JOIN gender ON superhero.gender_id = gender.id WHERE race.race = 'god/eternal' AND gender.gender = 'Male';

/*
Prediction Result:
(0,)
*/