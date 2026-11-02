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
INSERT INTO race (id, race) VALUES (2, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (3, 'default1'), (1, 'Female'), (2, NULL), (0, 'Good'), (4, 'Female'), (5, NULL);
INSERT INTO gender (id, gender) VALUES (2, 'Good'), (1, 'default2');
INSERT INTO colour (id, colour) VALUES (2, 'Good'), (1, 'default2'), (0, 'Good'), (3, 'Good'), (4, 'default1'), (5, 'Female'), (6, 'default2'), (7, 'default1'), (8, 'Good'), (9, 'Female');
INSERT INTO alignment (id, alignment) VALUES (0, 'Good'), (2, NULL), (1, 'Good'), (3, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, 4, 1, 0, 4, NULL, NULL, 'default1', 'Female', 3, NULL), (2, 1, 8, NULL, 4, 4, 2, 4, 'default2', 'Good', 0, 2), (3, 2, 1, 1, 8, 1, NULL, 9, 'Good', 'default2', 3, 1), (1, 0, NULL, 1, 6, 1, NULL, 7, 'default1', 'default1', 1, 2), (4, 3, 1, NULL, 2, 4, NULL, 6, 'default2', 'Good', 1, NULL), (5, 3, 1, NULL, 0, 5, NULL, NULL, 'default1', 'default1', 0, 0), (6, 3, 0, 1, 5, 2, NULL, 4, 'Good', 'default2', 1, 0), (7, 0, 8, 1, 5, 0, NULL, NULL, 'Female', 'default2', 2, 3), (8, 1, NULL, 2, 1, 2, 2, 2, 'Female', 'default1', 1, NULL), (9, 0, 9, 2, NULL, 4, NULL, 0, 'Female', 'default1', 2, NULL), (10, 3, 7, NULL, 5, NULL, 2, NULL, 'Good', 'Good', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.alignment = 'Good' AND T3.gender = 'Female';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero WHERE alignment_id = 1 AND gender_id = 2;

/*
Prediction Result:
(1,)
*/