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
INSERT INTO race (id, race) VALUES (101, NULL), (2, NULL), (1, NULL), (100, 'default1'), (0, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'default2'), (101, 'Female'), (1, 'default1'), (100, 'default1'), (0, 'default1'), (-1, 'default1');
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (99, NULL), (1, 'Female'), (101, NULL), (-1, 'Blue'), (2, 'default2'), (100, 'Female');
INSERT INTO colour (id, colour) VALUES (0, NULL), (101, 'Blue');
INSERT INTO alignment (id, alignment) VALUES (100, NULL), (2, 'Female'), (-1, 'default2'), (101, NULL), (1, 'default2'), (0, 'Female'), (99, 'Blue'), (3, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (100, 1, 101, 0, NULL, NULL, 101, 101, 'default2', 'Blue', 1, 101), (99, 99, 101, 1, 0, NULL, 0, NULL, 'default1', NULL, 1, NULL), (0, 100, NULL, 1, 0, NULL, 2, 0, 'Female', 'Female', -1, 101), (-1, 3, 0, 99, NULL, NULL, 101, 0, 'Blue', 'Female', 100, 101), (1, 3, 101, 99, 101, 1, 2, 0, NULL, 'Blue', NULL, 100), (2, 3, NULL, 0, NULL, 2, 0, NULL, 'Female', 'default1', 101, 2), (101, 2, 101, 99, 101, 0, 2, 101, 'default2', 'default2', 100, -1), (3, 101, NULL, NULL, 101, 101, 100, 101, 'Blue', 'default1', 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.colour = 'Blue' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T2.gender = 'Female';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T3.colour = 'Blue' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.gender) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id WHERE T2.gender = 'Female';

/*
Prediction Result:
(100.0,)
*/