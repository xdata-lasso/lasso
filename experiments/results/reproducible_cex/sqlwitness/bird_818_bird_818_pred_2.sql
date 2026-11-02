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
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (0, 'Female'), (2, 'default2'), (3, 'default2'), (101, 'default1'), (100, 'default1'), (99, 'default1'), (4, 'Female'), (5, NULL), (6, 'Female'), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'Female');
INSERT INTO gender (id, gender) VALUES (2, 'Bad'), (100, 'default1'), (99, NULL), (1, 'default2'), (0, 'default2'), (3, NULL), (101, 'Bad');
INSERT INTO colour (id, colour) VALUES (99, NULL), (0, NULL), (1, NULL), (2, NULL), (3, 'default2');
INSERT INTO alignment (id, alignment) VALUES (3, 'default2'), (100, 'Bad'), (101, 'Female'), (99, NULL), (2, 'default2'), (0, 'Bad'), (1, 'Female'), (4, 'default1'), (5, NULL), (6, 'Bad'), (7, 'Bad'), (8, 'Bad'), (9, 'default1'), (10, 'default1'), (11, NULL), (12, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (100, NULL, 0, 100, 1, 5, NULL, NULL, 'Bad', 'default2', 0, 0), (2, 4, 3, NULL, 3, 6, NULL, 2, NULL, 'Bad', 100, 100), (101, NULL, NULL, 0, 99, 2, NULL, 2, 'default1', 'default2', 99, 2), (1, 9, 2, 101, 3, 0, NULL, 2, 'Female', 'default2', 3, 100), (99, 11, 2, NULL, 99, 11, NULL, 1, 'default2', 'Bad', 1, NULL), (3, 7, 99, 1, 99, 6, NULL, 0, 'Bad', 'default2', 3, 3), (0, 8, 1, 99, 0, 5, NULL, 99, 'Bad', 'Bad', 2, 101), (4, 9, 3, 2, 99, 11, NULL, 1, 'default2', 'Bad', 100, 99), (5, 100, 1, 99, 99, 100, NULL, 2, 'default2', NULL, 99, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Bad';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(gender_id = 2) AS REAL) * 100 / COUNT(alignment_id) FROM superhero WHERE alignment_id = 2;

/*
Prediction Result:
(None,)
*/