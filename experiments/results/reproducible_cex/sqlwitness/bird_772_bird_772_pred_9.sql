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
INSERT INTO race (id, race) VALUES (0, 'Dark Horse Comics'), (1, 'Female'), (2, 'default1'), (3, 'Female'), (4, 'Female'), (5, 'default2'), (6, 'Female');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Female'), (0, 'Dark Horse Comics'), (2, 'Female'), (3, 'default1'), (4, 'Dark Horse Comics'), (5, 'default2'), (6, NULL), (7, NULL), (8, 'default2'), (9, NULL), (10, 'Dark Horse Comics'), (11, 'default2'), (12, 'default2'), (13, 'Female'), (14, NULL), (15, 'default1'), (16, 'default2'), (17, 'default2'), (18, 'Dark Horse Comics'), (19, 'default1'), (20, NULL), (21, NULL), (22, 'Dark Horse Comics'), (23, 'default1'), (24, 'Dark Horse Comics'), (25, 'Dark Horse Comics'), (26, 'default1'), (27, 'default2'), (28, 'Female'), (29, NULL), (30, 'Female'), (31, 'default2'), (32, NULL), (33, NULL), (34, 'default1');
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (1, NULL), (2, 'Female'), (3, 'default1'), (4, 'default1'), (5, 'Female'), (6, 'default1'), (7, 'Female'), (8, 'Dark Horse Comics'), (9, 'Dark Horse Comics'), (10, 'default2'), (11, 'Dark Horse Comics'), (12, 'default1'), (13, 'Female'), (14, 'Female'), (15, 'default2'), (16, 'default1'), (17, 'Dark Horse Comics'), (18, NULL), (19, 'Female'), (20, 'default2'), (21, 'Dark Horse Comics'), (22, 'default2'), (23, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'Dark Horse Comics'), (0, 'default2'), (2, NULL), (3, 'Dark Horse Comics'), (4, NULL), (5, NULL), (6, 'Dark Horse Comics'), (7, 'Female'), (8, 'default2'), (9, NULL), (10, 'Dark Horse Comics'), (11, 'default2'), (12, 'default1'), (13, NULL), (14, 'Female'), (15, 'default2'), (16, 'Female'), (17, 'Dark Horse Comics'), (18, 'Female');
INSERT INTO alignment (id, alignment) VALUES (1, 'Dark Horse Comics'), (0, NULL), (2, NULL), (3, 'default2'), (4, 'Female'), (5, NULL), (6, NULL), (7, 'Dark Horse Comics'), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, NULL), (12, 'Female');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 7, 1, 23, 4, 20, 6, 7, 'Dark Horse Comics', 'default1', NULL, NULL), (1, 7, 8, 2, 8, 22, 1, 17, 'Dark Horse Comics', 'Dark Horse Comics', NULL, NULL), (2, 3, 9, 18, 7, NULL, 4, NULL, 'Female', 'Dark Horse Comics', 1, 1), (3, 11, 7, 7, 10, 26, 6, 10, 'default2', 'Female', NULL, 0), (4, 7, 0, 13, 11, 2, 1, 4, 'default2', 'Female', 0, 0), (5, 4, 10, 2, 15, 23, 0, 8, 'Dark Horse Comics', 'Female', NULL, 0), (6, 7, 11, 2, 4, 3, 0, 7, 'default2', NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.eye_colour_id, T1.hair_colour_id, T1.skin_colour_id FROM superhero AS T1 INNER JOIN publisher AS T2 ON T2.id = T1.publisher_id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T2.publisher_name = 'Dark Horse Comics' AND T3.gender = 'Female';

/*
Gold Result:
(8, 8, 17)
*/

-- Prediction Query
SELECT c1.colour AS eye_colour, c2.colour AS hair_colour, c3.colour AS skin_colour FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id JOIN colour AS c1 ON s.eye_colour_id = c1.id JOIN colour AS c2 ON s.hair_colour_id = c2.id JOIN colour AS c3 ON s.skin_colour_id = c3.id JOIN publisher AS p ON s.publisher_id = p.id WHERE g.gender = 'Female' AND p.publisher_name = 'Dark Horse Comics';

/*
Prediction Result:
('default2', 'default2', 'Dark Horse Comics')
*/