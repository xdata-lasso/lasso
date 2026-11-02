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
INSERT INTO race (id, race) VALUES (0, 'default1'), (1, 'Black'), (2, 'default1'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, NULL), (7, NULL), (8, 'default1'), (9, NULL), (10, NULL), (11, NULL), (12, 'default2'), (13, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, NULL), (0, 'default1'), (2, 'default2'), (3, 'Black'), (4, NULL), (5, NULL), (6, 'Black'), (7, 'default2'), (8, 'default1'), (9, 'default2'), (10, 'default2'), (11, 'Black'), (12, 'default1'), (13, 'Black'), (14, 'Black'), (15, 'Black');
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (1, 'default1'), (2, NULL), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'default1'), (8, 'Black'), (9, 'default1'), (10, NULL), (11, NULL), (12, 'default1'), (13, NULL), (14, 'default2');
INSERT INTO colour (id, colour) VALUES (1, NULL), (0, 'Black'), (2, 'default1'), (3, NULL), (4, 'default2'), (5, 'Black'), (6, 'default1'), (7, 'Black'), (8, NULL), (9, 'default1'), (10, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, 'Black'), (1, 'Black'), (2, 'default2'), (3, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, 0, 6, 7, 7, 10, 5, NULL, 'default2', 0, NULL), (1, 0, 9, 1, 1, 2, 13, 2, 'default1', 'Black', 1, 0), (2, 2, 0, 3, 10, 7, 2, 1, NULL, 'default2', NULL, NULL), (3, 1, 9, 6, 2, 1, 9, 8, 'default1', 'Black', 0, 1), (4, NULL, 0, 3, 6, 0, 6, 2, 'default2', 'default1', NULL, 1), (5, 1, NULL, 12, 9, 12, 5, 3, 'Black', 'default2', NULL, NULL), (6, 1, 7, 6, NULL, 5, 11, 5, 'default1', 'default1', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id AND T1.hair_colour_id = T2.id WHERE T2.colour = 'Black';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Black' AND T3.colour = 'Black';

/*
Prediction Result:
(None,)
*/