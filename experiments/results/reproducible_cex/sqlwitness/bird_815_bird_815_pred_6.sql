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
INSERT INTO race (id, race) VALUES (1, 'default2'), (0, 'Good'), (3, 'Female'), (2, 'default1'), (4, 'default1'), (5, 'Female'), (6, 'Female'), (7, 'default1'), (8, 'Female');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (2, 'Good'), (0, 'default2'), (3, 'Good'), (4, 'default1'), (5, 'Female'), (6, 'Female'), (7, 'default2'), (8, 'default2'), (9, NULL), (10, 'Female'), (11, 'Female'), (12, 'default2'), (13, 'Female'), (14, 'default1'), (15, 'Good'), (16, NULL), (17, 'Good');
INSERT INTO gender (id, gender) VALUES (3, 'Good'), (0, 'default2'), (2, 'Good'), (1, NULL), (4, 'default2'), (5, 'default1'), (6, 'Female'), (7, 'Female'), (8, 'default2'), (9, 'Good');
INSERT INTO colour (id, colour) VALUES (1, 'Female'), (2, 'default1'), (0, 'Female'), (3, 'default2'), (4, 'default1'), (5, 'Female'), (6, NULL), (7, 'Female'), (8, 'Good'), (9, 'Female'), (10, NULL), (11, 'Female'), (12, 'default1'), (13, 'Good'), (14, 'default1'), (15, 'Female'), (16, 'Female'), (17, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, 'default1'), (3, 'Good'), (0, 'default1'), (2, 'Good'), (4, NULL), (5, NULL), (6, 'default2'), (7, 'default1'), (8, 'Female');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (3, 8, NULL, 0, 1, 1, 1, 15, 'default2', 'default2', 0, 3), (1, 8, 2, 4, 17, 16, 3, 1, 'Good', NULL, NULL, 0), (0, NULL, 13, 0, 13, 11, 3, 10, 'default2', 'Good', 0, NULL), (2, 0, 6, 2, 7, NULL, 4, 6, 'Good', 'default1', 1, 2), (4, 1, 17, 5, 15, 17, 6, 15, 'default2', 'Good', 0, 1), (5, 3, 4, 8, 5, 10, 7, 14, NULL, 'default1', 3, 0), (6, NULL, 13, 0, 7, 9, 6, NULL, 'default1', 'Female', NULL, 0), (7, 3, NULL, 7, 4, 15, 7, 4, 'default1', NULL, 1, 0), (8, 8, 10, 6, 4, 13, 4, 17, 'default1', 'default1', 3, 1), (9, 2, 10, 1, 0, 8, 5, 2, 'default2', 'default2', 3, NULL), (10, 4, 6, NULL, 6, 16, 7, 8, 'Female', 'default1', 3, 1), (11, 4, 14, 7, 3, 8, 5, 11, 'Good', 'default2', 3, 3), (12, 6, 11, 4, 10, 12, 6, 10, NULL, 'default1', 3, 3), (13, 7, 14, 0, 3, 6, 2, 5, 'default1', 'Female', 2, 0), (14, 3, 2, 0, 11, 6, NULL, 1, NULL, 'default2', NULL, 2), (15, 8, 17, 0, 2, NULL, 5, 11, 'Good', 'default2', 3, NULL), (16, 1, 4, 0, 15, 9, 1, 4, NULL, 'Female', 2, 1), (17, 3, 5, 5, 13, 15, 7, 11, 'default2', 'default2', 0, 3), (18, 2, 2, 8, 14, NULL, 8, 11, 'default2', 'Good', 3, NULL), (19, NULL, 15, 6, 9, 3, 4, 16, 'Female', 'Good', 2, NULL), (20, 6, 6, 5, 14, 9, 1, 0, 'default2', 'Good', 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Good' AND T3.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id JOIN alignment AS a ON s.alignment_id = a.id WHERE g.id = 2 AND a.id = 1;

/*
Prediction Result:
(0,)
*/