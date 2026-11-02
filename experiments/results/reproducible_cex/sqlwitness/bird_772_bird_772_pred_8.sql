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
INSERT INTO race (id, race) VALUES (1, 'Female'), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, 'Female'), (6, 'Female'), (7, 'Dark Horse Comics'), (8, 'Female'), (9, 'Female'), (10, 'Female'), (11, 'Dark Horse Comics'), (12, 'default2'), (13, 'Female'), (14, 'Female'), (15, 'Female'), (16, 'default1'), (17, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (0, 'Dark Horse Comics'), (2, 'default1'), (3, 'Female');
INSERT INTO gender (id, gender) VALUES (1, 'Female'), (0, NULL), (2, 'default1'), (3, NULL), (4, 'Dark Horse Comics'), (5, 'Female'), (6, 'default1'), (7, NULL), (8, 'Female'), (9, 'default2'), (10, 'Female'), (11, 'Female'), (12, 'default1'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, 'Dark Horse Comics'), (17, 'default1'), (18, 'Female'), (19, NULL), (20, 'Dark Horse Comics'), (21, 'default2'), (22, 'Female'), (23, 'default1'), (24, NULL), (25, 'default2');
INSERT INTO colour (id, colour) VALUES (0, 'default2'), (1, NULL), (2, NULL), (3, NULL), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default2'), (8, 'Dark Horse Comics'), (9, NULL), (10, 'default1'), (11, 'Female'), (12, 'Female'), (13, 'default2'), (14, 'Female'), (15, NULL), (16, 'default1'), (17, 'default2'), (18, NULL), (19, 'Female'), (20, 'default2'), (21, 'default1'), (22, 'Dark Horse Comics'), (23, NULL), (24, 'default1'), (25, NULL), (26, 'default1'), (27, 'Dark Horse Comics'), (28, 'Female'), (29, 'Female');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'default1'), (2, 'Female'), (3, 'Female'), (4, 'Dark Horse Comics'), (5, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 4, 23, 8, 15, 3, 5, 0, NULL, 'Dark Horse Comics', 1, 0), (0, NULL, 23, 21, 25, 0, 8, 11, 'Dark Horse Comics', 'Female', 0, 0), (2, NULL, 6, 14, 11, 0, 15, 18, 'Dark Horse Comics', 'Female', 0, 0), (3, 3, 17, 12, 25, NULL, 1, 14, 'Dark Horse Comics', NULL, 1, 0), (4, 1, 27, 2, 14, 2, 4, 29, 'default2', 'Female', NULL, 0), (5, 5, 12, 13, 29, 3, 0, 25, NULL, 'default2', 0, NULL), (6, 4, 10, NULL, 9, 1, 15, 16, 'Dark Horse Comics', NULL, NULL, 1), (7, 5, 25, 13, 27, 1, 0, 21, 'Dark Horse Comics', NULL, 1, 1), (8, 3, 1, 17, 14, 2, 12, 26, 'Female', 'Dark Horse Comics', NULL, NULL), (9, 0, 1, 9, 17, 2, 8, 3, 'default1', NULL, 1, 1), (10, 4, 22, 7, 19, 1, 5, 8, 'default1', 'Female', NULL, 0), (11, 2, 3, 9, 13, 3, 0, 3, 'default2', 'Female', 1, 0), (12, 2, 2, 13, 26, 0, 6, 3, 'default1', NULL, 1, 0), (13, 0, 10, 12, 24, 3, 15, NULL, NULL, 'default1', 1, 1), (14, 3, 18, 10, 22, 0, 14, 5, 'default2', 'Dark Horse Comics', 1, NULL), (15, 3, 24, 3, 19, NULL, 12, 1, NULL, 'Dark Horse Comics', 1, 0), (16, 1, 25, 4, 20, 1, 17, NULL, NULL, 'Dark Horse Comics', NULL, 1), (17, 1, 2, 14, 14, NULL, 7, 17, NULL, NULL, NULL, NULL), (18, 3, 29, 1, 9, 3, 12, 18, 'Female', 'default2', 1, NULL), (19, 1, 28, 12, 20, 1, 6, 25, 'default2', 'Female', 1, NULL), (20, 3, NULL, 7, 12, 0, 12, 13, 'Female', 'default1', 1, 1), (21, 1, 16, 8, 18, 0, 4, 2, NULL, NULL, NULL, NULL), (22, 5, 15, 1, 10, 2, 17, 20, NULL, 'Female', NULL, 0), (23, 2, 13, 2, 12, 1, 6, 26, NULL, 'default2', 0, NULL), (24, 3, 28, 22, 0, 1, 3, 10, 'Female', 'default2', NULL, 1), (25, 3, 7, 1, 19, 2, 3, 1, 'default2', 'Female', NULL, 0), (26, NULL, 16, 9, 17, 2, 16, 11, 'default2', 'default1', 1, NULL), (27, 4, 14, 21, 29, 2, 15, 10, 'Female', NULL, 0, NULL), (28, 1, 17, 3, 24, 1, 12, NULL, 'Female', 'default2', 1, NULL), (29, 3, 28, NULL, 15, 2, 7, 2, 'default1', 'default1', 1, NULL), (30, 3, 2, 10, 17, 3, 17, 25, 'default1', 'default1', 1, NULL), (31, 2, 24, 17, 0, 0, 11, 16, 'default1', 'default2', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.eye_colour_id, T1.hair_colour_id, T1.skin_colour_id FROM superhero AS T1 INNER JOIN publisher AS T2 ON T2.id = T1.publisher_id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T2.publisher_name = 'Dark Horse Comics' AND T3.gender = 'Female';

/*
Gold Result:
(18, 22, 5)
(16, 18, 2)
*/

-- Prediction Query
SELECT T2.colour AS eye_colour, T3.colour AS hair_colour, T4.colour AS skin_colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id INNER JOIN colour AS T4 ON T1.skin_colour_id = T4.id INNER JOIN publisher AS T5 ON T1.publisher_id = T5.id WHERE T1.gender_id = (SELECT id FROM gender WHERE gender = 'Female') AND T5.publisher_name = 'Dark Horse Comics';

/*
Prediction Result:
*/