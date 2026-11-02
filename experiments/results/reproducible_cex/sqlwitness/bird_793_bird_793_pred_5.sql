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
INSERT INTO race (id, race) VALUES (21, 'default1'), (20, NULL), (22, 'default2'), (0, NULL), (2, 'default2'), (1, 'default1'), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, 'default1'), (7, 'Male'), (8, 'Male'), (9, 'default1'), (10, 'default2'), (11, 'Male'), (12, 'default2'), (13, 'Male'), (14, NULL), (15, NULL), (16, 'default1'), (17, 'Male');
INSERT INTO publisher (id, publisher_name) VALUES (22, 'Male'), (20, NULL), (1, NULL), (2, 'default2'), (21, 'Male'), (0, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'Male'), (6, 'default1'), (7, NULL), (8, 'default1'), (9, 'Male'), (10, 'default1'), (11, 'Male'), (12, 'default2'), (13, 'default1');
INSERT INTO gender (id, gender) VALUES (21, 'default1'), (22, 'Male'), (0, 'default2'), (2, 'default2'), (1, NULL), (20, NULL), (3, NULL), (4, 'default1'), (5, 'default1'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, 'default2'), (10, NULL), (11, 'default1'), (12, 'default1'), (13, NULL), (14, NULL), (15, 'Male'), (16, 'Male'), (17, 'default1'), (18, 'default2');
INSERT INTO colour (id, colour) VALUES (2, NULL), (1, 'default1'), (20, 'default1'), (22, 'Male'), (21, 'default2'), (0, NULL), (3, NULL), (4, 'default2'), (5, 'default2'), (6, NULL), (7, NULL), (8, 'Male'), (9, NULL), (10, 'Male'), (11, 'Male'), (12, 'default1'), (13, 'default1'), (14, NULL), (15, 'default2'), (16, 'default2');
INSERT INTO alignment (id, alignment) VALUES (20, 'default1'), (22, NULL), (21, NULL), (1, NULL), (2, 'default1'), (0, 'default1'), (3, 'Male'), (4, 'Male'), (5, NULL), (6, NULL), (7, NULL), (8, NULL), (9, 'default1'), (10, 'default2'), (11, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (20, 5, 7, 3, 14, 6, 13, 22, 'default1', NULL, 20, 0), (21, 10, 22, 2, 5, 9, 8, 2, 'default1', 'Male', NULL, 0), (22, 5, 14, 9, 20, 11, 1, 12, 'default1', 'default1', NULL, 21), (2, 0, 22, 22, 13, 11, 21, 10, NULL, 'default2', 1, 22), (1, 9, 22, 15, 2, 5, 14, 16, 'default2', NULL, 21, NULL), (0, 22, 8, 15, NULL, 10, 7, 5, NULL, 'default1', 2, 2), (3, 0, 13, 17, 2, 1, 10, 20, 'Male', NULL, 21, 20), (4, 7, 4, NULL, 16, 6, 5, 3, 'default2', 'default2', 21, 20), (5, 22, 22, 5, 21, 4, 22, 5, NULL, NULL, 22, NULL), (6, 22, 5, NULL, 12, 0, 21, 11, 'default1', 'default2', 0, 20), (7, 9, 16, 22, 13, 0, 13, 22, NULL, 'default2', NULL, 21), (8, 1, 5, 21, 7, 8, 10, 7, 'default1', 'Male', NULL, 2), (9, 2, 12, NULL, 7, 4, 16, 10, 'Male', NULL, 21, 2), (10, 9, 13, 15, 0, 4, 12, 8, 'default1', NULL, 2, 0), (11, 2, 15, 15, 2, 22, 22, 14, NULL, 'default1', 2, NULL), (12, 5, 9, 17, 3, 3, 2, 1, 'default1', NULL, 20, 22);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T1.race_id = 21 AND T1.gender_id = 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T1.race_id = 21 AND T2.gender = 'Male';

/*
Prediction Result:
(1,)
*/