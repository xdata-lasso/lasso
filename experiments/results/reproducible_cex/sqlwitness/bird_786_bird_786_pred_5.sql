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
INSERT INTO race (id, race) VALUES (1, 'Strength'), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, NULL), (5, 'Strength'), (6, 'default1'), (7, 'default2'), (8, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Strength'), (0, 'Strength'), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, 'Strength'), (7, 'default1'), (8, 'Strength'), (9, NULL), (10, 'default1'), (11, 'Strength'), (12, 'default1'), (13, 'Strength'), (14, 'default2'), (15, 'default1'), (16, 'default1'), (17, 'default1'), (18, 'default1'), (19, NULL);
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (0, 'Strength'), (2, 'Strength'), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'default1'), (8, NULL), (9, 'Strength'), (10, NULL), (11, NULL), (12, 'default2'), (13, 'Strength'), (14, 'default2'), (15, 'default2'), (16, 'default2'), (17, NULL), (18, 'default1'), (19, 'default1'), (20, NULL), (21, 'default2'), (22, 'default2'), (23, NULL), (24, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default1'), (0, 'Strength'), (2, 'Strength'), (3, NULL), (4, 'Strength'), (5, 'Strength'), (6, 'default2'), (7, 'default1'), (8, 'default1'), (9, NULL), (10, 'default2'), (11, 'Strength'), (12, 'default2'), (13, 'default1'), (14, 'default2'), (15, 'default1'), (16, 'default1'), (17, 'default2'), (18, 'default1'), (19, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'default1'), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, 'default1'), (7, 'Strength');
INSERT INTO alignment (id, alignment) VALUES (0, 'default2'), (1, NULL), (2, 'default1'), (3, 'default1'), (4, NULL), (5, NULL), (6, NULL), (7, NULL), (8, 'Strength'), (9, NULL), (10, NULL), (11, 'default1'), (12, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 7, 4, 17, 6, 15, 5, 17, NULL, NULL, 0, NULL), (0, NULL, 16, 6, 19, 9, 2, 15, 'Strength', 'default1', 0, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (7, 1, NULL), (6, 0, 1), (7, NULL, 0), (0, 0, NULL), (7, 1, 1), (4, NULL, NULL), (2, 0, 1), (0, 0, 1), (6, 1, 0), (7, NULL, 1), (2, 0, 1), (3, 1, 0), (4, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM hero_attribute AS ha INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Strength' AND ha.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Prediction Result:
(2,)
*/