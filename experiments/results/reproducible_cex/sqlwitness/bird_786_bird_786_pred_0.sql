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
INSERT INTO race (id, race) VALUES (1, NULL), (0, NULL), (2, 'Strength'), (3, NULL), (4, 'Strength'), (5, 'default1'), (6, 'default1'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, 'default1'), (11, NULL), (12, 'default1'), (13, NULL), (14, NULL), (15, NULL), (16, 'Strength'), (17, 'Strength'), (18, NULL), (19, 'default1'), (20, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default1'), (1, 'Strength'), (2, 'default2'), (3, 'default2'), (4, 'Strength'), (5, 'Strength'), (6, NULL), (7, 'default1'), (8, NULL), (9, NULL), (10, NULL), (11, 'Strength'), (12, 'default1'), (13, 'default2'), (14, 'default1'), (15, 'default2'), (16, NULL), (17, 'Strength'), (18, 'Strength'), (19, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'Strength');
INSERT INTO colour (id, colour) VALUES (0, 'default2'), (1, 'default2'), (2, 'Strength'), (3, 'default1'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, 'default2'), (8, 'default2'), (9, 'Strength'), (10, 'default1'), (11, NULL), (12, 'Strength'), (13, NULL), (14, 'Strength'), (15, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (0, 'Strength'), (1, 'default2'), (2, 'Strength'), (3, 'default2'), (4, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, 'Strength'), (2, 'default1'), (3, 'Strength'), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, 'Strength'), (11, NULL), (12, 'default2'), (13, 'default2'), (14, 'default1'), (15, 'default2'), (16, 'Strength'), (17, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 14, 13, NULL, 11, 16, 3, 10, NULL, NULL, NULL, NULL), (1, 11, 2, 1, 0, 14, 19, 12, 'Strength', 'default1', 0, 0), (2, 3, 3, NULL, 10, 9, 16, 6, 'Strength', 'default2', 0, NULL), (3, 11, 15, 1, 15, 18, 3, 15, 'Strength', 'default1', 1, NULL), (4, 11, 2, 1, 15, 14, 4, 9, 'default1', 'Strength', NULL, NULL), (5, 5, 7, 1, 15, 15, 1, 13, 'default2', 'Strength', 0, 1), (6, 14, 0, 1, 6, NULL, 17, 15, 'Strength', 'default2', 0, 0), (7, 8, 2, 1, 12, 1, 5, 7, 'default1', 'default1', 0, NULL), (8, 4, NULL, 1, 9, 18, 19, 13, 'default2', 'Strength', 1, 0), (9, 17, 1, NULL, 9, 15, 18, NULL, 'default2', 'default1', NULL, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (4, 6, 1), (NULL, 9, NULL), (3, 1, 0), (NULL, 3, 1), (NULL, 3, NULL), (0, NULL, NULL), (4, 6, 0), (1, 4, NULL), (2, 9, 0), (4, 6, 0), (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength'));

/*
Prediction Result:
(0,)
*/