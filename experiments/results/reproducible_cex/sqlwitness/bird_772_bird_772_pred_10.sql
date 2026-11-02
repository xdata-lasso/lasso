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
INSERT INTO race (id, race) VALUES (0, NULL), (1, 'Female'), (2, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Female'), (0, 'default1'), (2, 'Female'), (3, 'Female'), (4, 'default1'), (5, 'default2'), (6, 'Dark Horse Comics'), (7, 'default1'), (8, 'default2'), (9, 'default2'), (10, 'Dark Horse Comics'), (11, NULL), (12, 'Dark Horse Comics'), (13, 'Dark Horse Comics'), (14, 'default1'), (15, 'Female'), (16, 'default2'), (17, 'Dark Horse Comics');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (0, 'Female');
INSERT INTO colour (id, colour) VALUES (0, NULL), (1, 'default1'), (2, NULL), (3, 'Female'), (4, 'default1'), (5, NULL), (6, 'Dark Horse Comics'), (7, 'Dark Horse Comics'), (8, 'Female'), (9, 'Dark Horse Comics'), (10, 'default1'), (11, 'Female'), (12, 'default1'), (13, 'default1'), (14, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'Dark Horse Comics'), (1, 'Female'), (2, 'Female'), (3, 'default2'), (4, 'Female'), (5, 'Female'), (6, 'Female'), (7, 'Female'), (8, 'default2'), (9, NULL), (10, 'Dark Horse Comics'), (11, 'Dark Horse Comics'), (12, 'Female');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 11, 10, NULL, 4, NULL, NULL, 5, 'default2', 'default1', 1, NULL), (0, 9, 4, 1, 14, 9, 2, 2, 'Female', 'Female', 0, NULL), (2, 9, 11, 0, 2, 6, 2, 8, NULL, NULL, 0, 1), (3, 0, 0, 0, 0, 9, 2, 0, 'Dark Horse Comics', 'Female', 0, 1), (4, 1, 4, 0, 8, 12, 0, 2, NULL, 'Dark Horse Comics', 0, NULL), (5, 5, 1, 1, NULL, 16, 0, 14, NULL, 'default2', 0, 0), (6, 5, 3, 1, 0, 10, NULL, 8, NULL, NULL, NULL, NULL), (7, 9, NULL, NULL, 2, 8, NULL, 4, NULL, 'Dark Horse Comics', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.eye_colour_id, T1.hair_colour_id, T1.skin_colour_id FROM superhero AS T1 INNER JOIN publisher AS T2 ON T2.id = T1.publisher_id INNER JOIN gender AS T3 ON T3.id = T1.gender_id WHERE T2.publisher_name = 'Dark Horse Comics' AND T3.gender = 'Female';

/*
Gold Result:
(11, 2, 8)
(4, 8, 2)
*/

-- Prediction Query
SELECT c1.colour AS eyes, c2.colour AS hair, c3.colour AS skin_colour FROM superhero AS h JOIN gender AS g ON h.gender_id = g.id JOIN publisher AS p ON h.publisher_id = p.id JOIN colour AS c1 ON h.eye_colour_id = c1.id JOIN colour AS c2 ON h.hair_colour_id = c2.id JOIN colour AS c3 ON h.skin_colour_id = c3.id WHERE g.gender = 'Female' AND p.publisher_name = 'Dark Horse Comics';

/*
Prediction Result:
('Female', None, 'Female')
('default1', 'Female', None)
*/