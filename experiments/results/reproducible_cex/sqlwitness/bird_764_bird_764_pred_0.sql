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
INSERT INTO superpower (id, power_name) VALUES (0, 'default1'), (2, NULL), (1, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'default2'), (6, 'default1'), (7, 'default1'), (8, NULL), (9, 'default2'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, 'default1'), (14, 'default2'), (15, NULL), (16, 'default2'), (17, NULL), (18, NULL), (19, 'default1'), (20, 'default1'), (21, 'default1'), (22, 'default2'), (23, 'default2'), (24, 'default2'), (25, NULL), (26, 'default2'), (27, 'default1'), (28, 'default1'), (29, 'default1'), (30, 'default1'), (31, 'default2');
INSERT INTO race (id, race) VALUES (2, 'default2'), (1, 'default1'), (0, NULL), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, NULL), (8, 'default1'), (9, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (2, NULL), (1, 'default2'), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default2'), (11, 'default1'), (12, 'default1'), (13, NULL), (14, 'default2'), (15, 'default1');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (1, 'default2'), (0, 'default2'), (3, 'default1');
INSERT INTO colour (id, colour) VALUES (1, 'default1'), (2, 'default2'), (0, NULL), (3, 'default2'), (4, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, NULL), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default1'), (8, 'default1'), (9, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 1, NULL, 3, 3, 12, 6, 2, 'default2', 'default2', 2, 0), (0, 7, 2, NULL, 2, 4, 8, 1, 'default1', NULL, NULL, 2), (1, 0, 0, 0, NULL, 7, 1, 0, 'default2', NULL, 1, 2), (3, 8, 0, 3, NULL, 5, 0, 3, NULL, NULL, 2, 1), (4, 3, 1, 3, 1, 15, NULL, 2, NULL, 'default2', 1, 0);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 29), (4, 28), (3, NULL), (0, 26), (4, NULL), (3, 17), (2, 25), (4, 8), (1, 19), (NULL, 10), (3, 7), (3, 27), (NULL, 10), (0, 16), (4, 29), (NULL, 23), (1, 20), (2, 8), (2, 21), (4, 26), (NULL, 11), (0, 10), (0, 27), (NULL, 10), (3, 12), (4, 31), (NULL, 14), (NULL, NULL), (2, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Prediction Result:
('default1',)
('default1',)
*/