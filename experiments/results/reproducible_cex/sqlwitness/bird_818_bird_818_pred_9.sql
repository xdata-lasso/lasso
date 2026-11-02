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
INSERT INTO race (id, race) VALUES (2, 'Bad'), (3, 'default2'), (99, NULL), (100, 'default1'), (101, 'Female'), (0, 'Bad'), (1, NULL), (4, NULL), (5, 'default1'), (6, 'Bad'), (7, 'Bad');
INSERT INTO publisher (id, publisher_name) VALUES (100, 'Bad'), (2, 'Female'), (99, 'default2'), (3, NULL), (1, 'default1'), (0, 'Bad');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (3, 'Bad'), (99, NULL), (101, 'default2'), (100, 'default1'), (0, 'Female'), (2, 'default1'), (4, 'default1');
INSERT INTO alignment (id, alignment) VALUES (2, 'default2'), (0, 'default1'), (99, 'default1'), (101, 'default1'), (1, 'Female'), (3, 'Female'), (100, 'default2'), (4, NULL), (5, NULL), (6, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, NULL, 99, NULL, 0, 101, NULL, 'Female', 'Bad', 1, 101), (2, 100, NULL, 1, NULL, 3, 2, NULL, 'Female', 'default2', 1, 101), (101, 2, NULL, 0, NULL, 3, 1, NULL, 'default1', 'default1', NULL, 2), (3, 3, NULL, 3, NULL, 2, 5, NULL, 'default2', 'Female', 99, NULL), (1, NULL, NULL, 3, NULL, 2, 0, NULL, 'default1', 'default1', 1, 0), (100, 5, NULL, 100, NULL, 0, 6, NULL, 'Bad', 'default2', 2, NULL), (99, NULL, NULL, 4, NULL, 1, NULL, NULL, 'Female', 'default1', 2, 101), (4, NULL, NULL, 0, NULL, 2, 5, NULL, 'default1', 'Female', 1, 1), (5, 6, NULL, 4, NULL, 3, 2, NULL, 'default1', 'default1', 3, 0), (6, 101, NULL, 3, NULL, 100, 0, NULL, 'default2', 'Bad', NULL, 99), (7, 3, NULL, 99, NULL, 99, 1, NULL, 'default2', NULL, 99, 1), (8, 5, NULL, 4, NULL, 3, 1, NULL, 'Bad', 'default2', 3, NULL), (9, 4, NULL, NULL, NULL, 0, 2, NULL, 'default1', 'Female', 101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Bad';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN T2.id = 2 THEN 1 END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN alignment AS T3 ON T1.alignment_id = T3.id WHERE T3.id = 2;

/*
Prediction Result:
(0.0,)
*/