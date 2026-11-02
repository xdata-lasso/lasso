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
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (0, 'default1'), (2, 'default2'), (3, 'default1'), (4, 'Bad'), (5, NULL), (6, 'Bad'), (7, 'Bad');
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, 'default1'), (2, 'Bad'), (3, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'Bad'), (0, 'default1'), (2, 'Bad'), (3, 'default1'), (4, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'Bad'), (2, 'default2'), (3, NULL), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 1, 1, 3, NULL, 7, NULL, NULL, NULL, NULL, NULL, 0), (0, 7, 2, 1, NULL, 7, NULL, NULL, 'default1', 'default2', NULL, 1), (2, 4, 0, 2, 3, 0, NULL, 3, 'default2', 'default1', 1, NULL), (3, 6, 2, 1, 1, 1, NULL, 3, 'default1', 'default2', 1, NULL), (4, 7, 1, 0, NULL, 1, NULL, 1, NULL, 'Bad', 1, NULL), (5, 6, 3, 1, 3, 4, NULL, 0, 'default1', NULL, 0, 1), (6, 2, 3, NULL, NULL, 1, NULL, 2, 'default2', 'default1', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id WHERE T2.alignment = 'Bad';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(superhero_name) FROM superhero AS T2 INNER JOIN alignment AS T1 ON T2.alignment_id = T1.id WHERE T1.alignment = 'Bad';

/*
Prediction Result:
(0,)
*/