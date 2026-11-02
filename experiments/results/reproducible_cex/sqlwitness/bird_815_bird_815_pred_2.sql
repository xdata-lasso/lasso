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
INSERT INTO race (id, race) VALUES (0, 'Good'), (1, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1');
INSERT INTO gender (id, gender) VALUES (1, 'Female'), (2, NULL), (3, 'default1'), (0, NULL);
INSERT INTO colour (id, colour) VALUES (3, 'Good'), (0, 'Good'), (2, 'Female'), (1, NULL), (4, 'Female');
INSERT INTO alignment (id, alignment) VALUES (3, 'default1'), (1, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (3, 3, 2, NULL, 4, 1, 1, 0, 'default2', 'Female', 0, 2), (0, NULL, 3, 0, 4, NULL, NULL, 1, 'default1', 'default2', NULL, 1), (1, 1, 1, NULL, 3, 1, 1, 0, 'Good', 'Female', 1, 1), (2, NULL, 1, NULL, NULL, 1, NULL, 4, 'default2', 'Good', 2, 3), (4, 1, 0, 2, 3, 1, NULL, 4, NULL, 'Female', 0, NULL), (5, NULL, 1, 3, 2, NULL, 1, 4, 'Good', 'Good', 3, 1), (6, NULL, 1, NULL, 0, NULL, 1, NULL, NULL, 'Female', 3, 1), (7, 3, 1, 1, 4, 1, 0, 4, 'default1', NULL, NULL, 2), (8, 1, 2, 3, 4, 1, 1, NULL, 'Female', 'Good', 1, 2), (9, 3, 4, 0, 2, 1, NULL, NULL, 'default1', NULL, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Good' AND T3.gender = 'Female';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.id = 1 AND T3.id = 2;

/*
Prediction Result:
(1,)
*/