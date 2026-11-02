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
INSERT INTO race (id, race) VALUES (1, 'Black');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, NULL), (2, 'default1'), (3, NULL), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'default1'), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, 'default1'), (13, NULL);
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (0, 'default2'), (2, NULL), (3, NULL), (4, 'default1'), (5, 'Black'), (6, NULL), (7, 'default1'), (8, 'Black'), (9, 'Black'), (10, 'default1'), (11, NULL), (12, 'Black'), (13, 'default1'), (14, 'default2'), (15, 'Black'), (16, 'default2'), (17, 'default1'), (18, 'default2'), (19, 'default1'), (20, 'default1');
INSERT INTO colour (id, colour) VALUES (0, 'Black'), (1, 'default1'), (2, 'Black'), (3, NULL), (4, 'default1'), (5, 'Black'), (6, 'default1'), (7, 'Black'), (8, 'Black'), (9, 'Black'), (10, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, 'Black'), (0, NULL), (2, 'default2'), (3, NULL), (4, 'Black'), (5, 'default2'), (6, 'default1'), (7, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 3, 9, 7, 8, 8, 1, 0, 'Black', NULL, 0, 1), (1, 4, 9, NULL, 6, 2, NULL, 3, NULL, 'default1', 0, NULL), (2, 4, 5, 15, 6, 12, 1, 0, 'Black', 'Black', NULL, 0), (3, 6, 2, 17, 3, 10, NULL, 0, 'default2', 'default1', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id AND T1.hair_colour_id = T2.id WHERE T2.colour = 'Black';

/*
Gold Result:
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s JOIN colour AS c_eye ON s.eye_colour_id = c_eye.id JOIN colour AS c_hair ON s.hair_colour_id = c_hair.id WHERE c_eye.colour = 'Black' AND c_hair.colour = 'Black';

/*
Prediction Result:
('Black',)
*/