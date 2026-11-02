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
INSERT INTO race (id, race) VALUES (1, 'default1'), (0, 'Female'), (2, NULL), (3, 'default1'), (4, 'Marvel Comics'), (5, NULL), (6, NULL), (7, 'Female'), (8, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (0, 'default1'), (2, 'Female'), (3, 'default1'), (4, 'Female'), (5, NULL), (6, 'Female'), (7, 'Marvel Comics'), (8, 'Marvel Comics'), (9, 'default1'), (10, 'default1'), (11, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'Female'), (0, 'default1'), (2, 'default2'), (3, 'Female'), (4, 'default1'), (5, NULL), (6, 'default2'), (7, NULL), (8, 'default1'), (9, NULL), (10, 'default2'), (11, 'default2'), (12, 'Female'), (13, 'Female');
INSERT INTO colour (id, colour) VALUES (1, 'Female'), (0, 'Marvel Comics'), (2, NULL), (3, 'Female'), (4, 'default2'), (5, 'default1'), (6, 'Marvel Comics'), (7, 'Marvel Comics'), (8, 'default2'), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'default1');
INSERT INTO alignment (id, alignment) VALUES (1, 'default1'), (0, 'default2'), (2, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 1, NULL, 12, 0, 11, NULL, NULL, 'Marvel Comics', 'default1', 0, 1), (1, NULL, 7, 9, 0, 3, 4, 0, 'default1', 'default2', NULL, 0), (2, 2, 3, 0, 8, 11, 2, 11, 'Marvel Comics', 'Female', 0, NULL), (3, NULL, 1, 13, NULL, 4, 0, 9, 'Marvel Comics', 'default1', 1, 0), (4, 2, 2, 13, 7, 4, 5, 8, 'default2', 'Female', NULL, 1), (5, 1, 10, NULL, 9, 9, 0, 5, 'default2', 'default2', NULL, NULL), (6, 2, 8, 1, 5, 9, 1, 4, 'default1', 'Female', NULL, 0), (7, 0, 4, 8, NULL, 10, 1, 3, 'default1', 'default2', 0, NULL), (8, 1, 0, 1, 7, 0, 7, 2, 'default1', 'Marvel Comics', 0, NULL), (9, 1, 9, 10, 5, 2, 6, 5, 'default2', NULL, 0, 0), (10, 2, 0, 7, 0, 6, 1, 3, NULL, NULL, 0, 0), (11, 0, 0, 8, 3, 1, 6, 3, NULL, 'default2', 0, 1), (12, 1, 8, 11, 11, 9, 3, 2, 'default1', 'default1', NULL, 1), (13, NULL, 10, NULL, 11, NULL, 6, 7, NULL, 'Marvel Comics', 0, 0), (14, 2, 4, 7, 10, NULL, 5, 2, 'default1', 'default2', 1, 1), (15, 2, 8, 11, 6, 4, 8, NULL, NULL, 'Female', NULL, NULL), (16, 1, 12, 3, 4, 7, 0, 4, 'Marvel Comics', 'default1', NULL, 0), (17, 0, 8, 4, 4, 0, 7, 4, 'default1', 'Female', 0, 0), (18, 1, 4, 5, 1, 2, 3, 1, 'Marvel Comics', NULL, NULL, 0), (19, 0, NULL, 5, 4, 2, 8, 3, 'default1', 'Female', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS s JOIN publisher AS p ON s.publisher_id = p.id WHERE s.gender_id = (SELECT id FROM gender WHERE gender = 'Female') AND p.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(0,)
*/