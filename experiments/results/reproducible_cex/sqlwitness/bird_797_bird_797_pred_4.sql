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
INSERT INTO race (id, race) VALUES (1, 'default2'), (0, 'default2'), (2, 'Brown'), (3, NULL), (4, 'default1'), (5, 'Blue');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Blue'), (0, NULL), (2, 'default1'), (3, 'Brown'), (4, 'Brown'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, 'default2'), (9, NULL), (10, NULL), (11, 'default2'), (12, 'Blue');
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, NULL), (2, NULL), (3, NULL), (4, 'Brown'), (5, NULL), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, 'default2'), (10, 'Blue'), (11, 'Blue'), (12, NULL), (13, 'Blue'), (14, 'Blue'), (15, NULL), (16, 'Brown'), (17, 'Brown'), (18, NULL), (19, NULL);
INSERT INTO colour (id, colour) VALUES (1, NULL), (0, 'Blue'), (2, 'Blue'), (3, 'default1'), (4, NULL), (5, 'Blue'), (6, NULL), (7, 'default1'), (8, 'default1'), (9, 'Blue'), (10, 'Blue'), (11, 'default2'), (12, NULL), (13, 'Brown'), (14, 'Blue'), (15, 'Blue'), (16, 'Blue'), (17, 'default2'), (18, 'default1'), (19, 'default2'), (20, 'Blue'), (21, 'default1'), (22, 'Brown'), (23, 'Blue'), (24, 'Blue'), (25, 'Blue'), (26, 'default1'), (27, 'default1'), (28, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (1, 'Blue'), (2, NULL), (3, NULL), (4, 'default1'), (5, NULL), (6, 'default2'), (7, 'Blue'), (8, 'default1'), (9, 'Brown'), (10, NULL), (11, NULL), (12, NULL), (13, 'default1'), (14, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 9, 20, 10, 28, 3, 3, 24, 'Blue', NULL, 0, 1), (0, 13, 0, 10, 4, 7, 4, 8, 'Brown', 'default1', NULL, 0), (2, 14, 19, 0, 4, 3, NULL, 10, NULL, 'Brown', 1, NULL), (3, 2, 16, 14, 0, 4, 5, 7, 'default2', 'default1', NULL, NULL), (4, 14, 17, 2, 1, 7, 3, 16, 'default1', 'default1', NULL, 0), (5, 9, 3, 12, 1, 5, NULL, 3, 'Brown', NULL, NULL, 0), (6, 8, 26, 17, 10, NULL, 1, 2, 'Blue', 'default2', NULL, NULL), (7, 3, 4, 11, 18, 11, 2, 6, 'default2', 'Brown', 0, 0), (8, 3, 28, 11, 8, NULL, 5, 12, NULL, NULL, 0, 1), (9, 2, 9, 7, 15, 1, 3, 26, 'default2', 'Brown', 1, NULL), (10, 5, 21, 11, 12, 0, NULL, 10, NULL, 'Blue', 0, 0), (11, 14, 24, 18, 24, 5, 2, 15, 'default2', NULL, 0, 1), (12, 6, 10, 7, 19, 7, 1, 0, NULL, 'default2', NULL, NULL), (13, 1, 12, 4, 7, 8, 4, 12, 'default1', NULL, 1, 1), (14, 9, 5, 10, 22, 3, 5, 13, 'Blue', 'default2', 1, NULL), (15, 7, 17, 0, 15, 12, 5, 17, 'default2', 'default2', 0, NULL), (16, 0, 11, 19, 7, 6, 2, 17, 'Brown', NULL, 1, 0), (17, 0, 4, 15, 2, NULL, 3, 23, 'Blue', 'Brown', NULL, 1), (18, 10, 9, 0, 22, 1, 1, 9, 'Blue', NULL, 1, NULL), (19, 3, 9, 13, 28, 12, 1, NULL, 'default2', 'Brown', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Brown';

/*
Gold Result:
('Blue',)
('Blue',)
*/

-- Prediction Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 JOIN colour AS T2 ON T2.id = T1.eye_colour_id JOIN colour AS T3 ON T3.id = T1.hair_colour_id WHERE T2.colour = 'Blue' AND T3.colour = 'Brown';

/*
Prediction Result:
('Blue',)
*/