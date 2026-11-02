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
INSERT INTO race (id, race) VALUES (2, 'default2'), (0, 'Female'), (99, 'Female'), (1, 'Female'), (101, 'default1'), (-1, NULL), (100, 'Female'), (3, 'default2'), (4, 'George Lucas');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Female'), (99, NULL), (100, 'default1'), (1, 'default1'), (101, 'default2'), (-1, NULL), (0, 'Female'), (3, 'George Lucas');
INSERT INTO gender (id, gender) VALUES (99, 'Female'), (1, 'default1'), (2, NULL), (-1, 'Female'), (0, 'default1'), (101, 'default2'), (100, 'Female'), (3, 'default2');
INSERT INTO colour (id, colour) VALUES (-1, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, 'George Lucas'), (-1, 'George Lucas');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, -1, -1, -1, -1, 3, 99, NULL, NULL, 'George Lucas', NULL, NULL), (101, -1, NULL, 2, -1, -1, 0, -1, 'default1', NULL, 99, 101), (100, 1, -1, 2, -1, -1, 100, -1, 'Female', 'default1', 100, 99), (-1, NULL, -1, 0, NULL, 1, NULL, -1, 'default1', 'George Lucas', 100, -1), (99, NULL, NULL, 3, NULL, 100, 4, -1, 'default1', 'default2', 2, NULL), (2, 1, -1, 99, -1, 2, NULL, -1, 'default1', 'George Lucas', 99, 1), (1, -1, -1, 2, -1, 2, 101, NULL, 'default1', 'George Lucas', 1, 2), (3, NULL, NULL, -1, -1, 101, 101, NULL, 'Female', 'default2', -1, 99), (4, 1, NULL, -1, -1, 1, 0, -1, 'default2', 'Female', 1, 100), (5, 1, NULL, 2, -1, 101, 99, NULL, 'George Lucas', 'default1', 0, NULL), (6, -1, NULL, 99, -1, 3, 0, NULL, 'George Lucas', 'default1', 100, 1), (7, -1, NULL, 101, NULL, 101, 3, -1, 'default2', 'default2', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'George Lucas';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.gender = 'Female' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN publisher AS T3 ON T1.publisher_id = T3.id WHERE T3.publisher_name = 'George Lucas';

/*
Prediction Result:
(200.0,)
*/