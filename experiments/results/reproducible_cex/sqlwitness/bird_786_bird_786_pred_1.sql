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
INSERT INTO race (id, race) VALUES (0, 'Strength'), (1, 'Strength'), (2, NULL), (3, NULL), (4, 'default1'), (5, 'default1'), (6, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (0, 'Strength'), (2, 'default2'), (3, 'Strength'), (4, 'Strength'), (5, NULL), (6, 'Strength'), (7, 'default2'), (8, 'Strength'), (9, 'Strength'), (10, 'default1'), (11, 'Strength'), (12, 'default2'), (13, 'default1'), (14, NULL), (15, NULL), (16, 'Strength'), (17, NULL), (18, 'Strength'), (19, 'default1'), (20, 'default1'), (21, 'Strength'), (22, 'default2'), (23, 'default2'), (24, 'Strength'), (25, NULL), (26, NULL), (27, 'default2'), (28, 'default1');
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, 'default2'), (2, 'Strength'), (3, 'default1'), (4, 'Strength'), (5, NULL), (6, 'Strength'), (7, 'default1'), (8, 'default2'), (9, 'default1'), (10, NULL), (11, NULL), (12, 'Strength'), (13, 'Strength'), (14, NULL), (15, 'default1'), (16, 'default1'), (17, 'default2'), (18, 'default1'), (19, 'default2'), (20, 'default2'), (21, NULL), (22, 'default2'), (23, 'default1'), (24, 'default2'), (25, 'default1'), (26, 'default2'), (27, NULL), (28, 'Strength'), (29, 'default2'), (30, NULL), (31, 'Strength');
INSERT INTO colour (id, colour) VALUES (1, 'Strength'), (0, 'default1'), (2, 'default2'), (3, NULL), (4, 'Strength'), (5, 'Strength'), (6, NULL), (7, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (0, 'default2'), (1, NULL), (2, 'Strength'), (3, 'default2'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, NULL), (9, 'default1'), (10, 'default2'), (11, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, 'Strength'), (2, NULL), (3, 'Strength'), (4, 'default2'), (5, NULL), (6, NULL), (7, NULL), (8, 'default2'), (9, 'Strength'), (10, 'default2'), (11, 'Strength'), (12, NULL), (13, 'Strength'), (14, 'default1'), (15, 'Strength'), (16, 'default2'), (17, NULL), (18, NULL), (19, 'Strength'), (20, 'Strength'), (21, 'Strength'), (22, 'default1'), (23, 'default2'), (24, 'Strength'), (25, NULL), (26, 'default1'), (27, NULL), (28, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 19, 6, 16, 2, 20, 4, 3, 'default2', 'default2', NULL, 1), (0, 13, 6, 10, 4, 18, 5, 1, NULL, NULL, 0, NULL), (2, 12, 0, 16, 1, 5, 2, 3, 'default2', NULL, NULL, 0), (3, 19, 0, 15, 5, 8, 2, 4, 'default2', 'default1', 0, 1), (4, 0, 7, 14, 5, 12, NULL, 2, NULL, 'Strength', 0, NULL), (5, 11, 5, 27, 0, 5, 5, 4, NULL, 'default2', 1, 0), (6, 26, 6, 22, 0, 0, NULL, 0, 'Strength', NULL, 0, 0), (7, 13, 1, 3, 3, 21, 3, 4, 'default2', 'default2', NULL, 0), (8, 1, 2, 25, 3, 6, 0, NULL, 'Strength', 'Strength', NULL, 1), (9, 1, 6, 26, 1, 8, 3, 6, NULL, 'default2', NULL, 1), (10, 28, 4, 18, 1, 0, 4, 4, 'Strength', 'default2', 0, NULL), (11, 27, 7, 15, 0, 26, 5, 5, 'default2', 'default1', 0, 0), (12, 27, 2, 13, 3, 4, 6, 3, 'Strength', 'Strength', NULL, 1), (13, 2, NULL, 21, 7, 27, 1, 4, 'default2', 'default2', 1, 1), (14, 19, 5, 15, 1, 9, 3, 7, 'default2', 'default2', NULL, NULL), (15, 13, 6, 27, 7, 27, 3, 0, NULL, NULL, NULL, 1), (16, 1, 6, 9, 0, 17, 2, 4, 'default2', 'default1', 1, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (9, 5, 1), (8, 4, 0), (7, 9, 1), (NULL, 1, 0), (11, 6, 0), (NULL, 8, 1), (11, 2, NULL), (5, 2, NULL), (2, 13, 0), (5, 16, 0), (NULL, 11, 0), (11, 6, NULL), (9, 16, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(hero_id) FROM hero_attribute AS ha INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Strength' AND ha.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute AS ha2 INNER JOIN attribute AS a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'Strength');

/*
Prediction Result:
(1,)
*/