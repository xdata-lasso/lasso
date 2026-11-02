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
INSERT INTO race (id, race) VALUES (3, 'Female'), (2, 'Female'), (0, 'Male'), (-1, 'default1'), (1, NULL), (4, 'default2'), (5, 'default2'), (6, 'Male'), (7, 'default2'), (8, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (3, 'default1'), (0, 'Female'), (1, NULL), (2, 'default2'), (-1, 'default2'), (4, NULL), (5, 'default2'), (6, 'Male'), (7, 'Female'), (8, 'default2'), (9, 'default1'), (10, NULL);
INSERT INTO gender (id, gender) VALUES (3, 'Female'), (-1, 'Male'), (0, 'Female'), (1, 'default2'), (2, 'Male'), (4, 'default2'), (5, 'Female'), (6, 'default1');
INSERT INTO colour (id, colour) VALUES (1, 'Female'), (-1, 'default2'), (3, 'Male'), (2, 'Female'), (0, NULL), (4, 'Female');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (-1, NULL, 3, 0, 0, 9, -1, 2, 'Male', 'Male', 3, 3), (2, NULL, NULL, 0, 2, 5, 4, 0, NULL, 'Female', 0, 0), (0, NULL, 0, 5, 3, 2, 7, 0, 'Male', 'default2', 2, -1), (1, NULL, 0, 6, 0, 9, 6, 2, 'default1', 'default1', 1, -1), (3, NULL, 3, 3, NULL, 1, -1, 1, 'Female', 'default2', 3, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.gender = 'Male' THEN T1.id ELSE NULL END) AS REAL) / COUNT(CASE WHEN T2.gender = 'Female' THEN T1.id ELSE NULL END) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN gender_id = 1 THEN 1 ELSE 0 END) * 1.0) / SUM(CASE WHEN gender_id = 2 THEN 1 ELSE 0 END) AS ratio FROM superhero;

/*
Prediction Result:
(None,)
*/