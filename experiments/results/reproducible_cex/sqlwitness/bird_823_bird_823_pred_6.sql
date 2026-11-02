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
INSERT INTO race (id, race) VALUES (1, 'default1'), (0, 'Female'), (2, 'Marvel Comics'), (3, 'default1'), (4, 'Female'), (5, 'Marvel Comics'), (6, NULL), (7, 'default1'), (8, 'Female'), (9, 'Female'), (10, NULL), (11, 'default1'), (12, 'Marvel Comics'), (13, NULL), (14, 'default2'), (15, 'Female'), (16, NULL), (17, 'default1'), (18, 'Marvel Comics'), (19, NULL), (20, NULL), (21, 'default1'), (22, 'Marvel Comics'), (23, 'default1'), (24, NULL), (25, 'Female'), (26, 'Marvel Comics'), (27, 'default1'), (28, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Female'), (0, 'Marvel Comics'), (2, 'default1'), (3, 'default2'), (4, 'Marvel Comics'), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, 'Female'), (11, 'Female'), (12, 'default2'), (13, NULL), (14, 'Marvel Comics'), (15, 'Marvel Comics'), (16, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'default2'), (0, 'Marvel Comics'), (2, 'default2'), (3, 'Marvel Comics'), (4, 'default1'), (5, NULL), (6, 'Marvel Comics'), (7, 'Marvel Comics'), (8, 'default2'), (9, 'Marvel Comics'), (10, 'Marvel Comics'), (11, NULL), (12, 'default1'), (13, 'default1'), (14, 'Marvel Comics'), (15, 'default1'), (16, NULL), (17, 'Marvel Comics'), (18, 'Female'), (19, NULL), (20, NULL), (21, 'default2'), (22, 'default1'), (23, NULL), (24, 'default1'), (25, 'Marvel Comics'), (26, 'Female'), (27, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, 'default1'), (2, 'Female'), (3, 'Marvel Comics');
INSERT INTO alignment (id, alignment) VALUES (0, 'Marvel Comics'), (1, 'Marvel Comics'), (2, 'Marvel Comics'), (3, NULL), (4, NULL), (5, 'default1'), (6, 'Female'), (7, 'Marvel Comics');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, 3, 12, NULL, 14, 16, 0, 'default1', 'default1', 0, 0), (1, 5, 0, 11, 2, 7, 1, 3, NULL, 'Marvel Comics', 0, 0), (2, 3, 0, 27, 3, 6, 8, 0, 'default2', 'default2', NULL, NULL), (3, NULL, 2, 19, 0, 0, 19, 0, 'default1', 'default1', NULL, NULL), (4, 2, 1, 11, NULL, 12, 12, 2, 'default1', 'Marvel Comics', 1, NULL), (5, 7, 3, 4, 3, 13, 2, 3, 'Female', 'Female', 1, NULL), (6, 2, 3, 24, 1, 7, 22, 0, 'default2', NULL, 0, 0), (7, 5, 2, 17, 2, 4, 22, NULL, 'Marvel Comics', 'default1', NULL, 0), (8, NULL, NULL, 24, 0, 6, 19, 3, 'Marvel Comics', 'default2', NULL, NULL), (9, 2, 3, 0, 2, 11, 23, 2, 'default2', NULL, 0, 0), (10, 2, 2, 6, 3, 10, 13, 3, 'default2', 'default1', 0, NULL), (11, 4, 3, 26, 0, 0, 1, 1, NULL, 'default2', NULL, 0), (12, 3, NULL, 17, 0, 11, 5, 0, 'Marvel Comics', 'Female', NULL, NULL), (13, 6, 3, 12, 3, 2, NULL, NULL, 'Marvel Comics', 'default1', NULL, 0), (14, 1, 2, 20, 2, 14, 3, NULL, NULL, NULL, 1, 0), (15, 2, 2, 21, NULL, 3, 25, NULL, 'default2', 'default1', 1, 1), (16, 7, 0, 5, NULL, 1, 5, 3, 'default1', 'Marvel Comics', 1, 1), (17, 0, NULL, 11, 3, 8, 8, 3, 'default1', 'default1', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 JOIN gender AS T2 ON T1.gender_id = T2.id JOIN publisher AS T3 ON T1.publisher_id = T3.id WHERE T2.gender = 'Female' AND T3.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(0,)
*/