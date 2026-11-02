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
INSERT INTO superpower (id, power_name) VALUES (0, 'default2'), (2, NULL), (1, 'default1'), (3, NULL), (4, NULL), (5, 'default2'), (6, NULL), (7, 'default1'), (8, NULL), (9, 'default1'), (10, NULL), (11, 'default2'), (12, NULL), (13, 'default1'), (14, 'default1'), (15, 'default1');
INSERT INTO race (id, race) VALUES (1, 'default2'), (2, 'default2'), (0, 'default1'), (3, NULL), (4, 'default2'), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, NULL), (11, NULL), (12, 'default2'), (13, NULL), (14, NULL), (15, NULL), (16, NULL), (17, NULL), (18, NULL), (19, 'default2'), (20, 'default2'), (21, NULL), (22, NULL), (23, NULL), (24, 'default2'), (25, 'default1'), (26, 'default1'), (27, 'default2'), (28, 'default2'), (29, NULL), (30, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (1, NULL), (0, 'default2'), (2, NULL), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, NULL), (11, 'default2'), (12, 'default1'), (13, 'default2'), (14, 'default1'), (15, 'default1'), (16, 'default2'), (17, 'default1'), (18, 'default2'), (19, 'default2'), (20, NULL), (21, 'default2'), (22, 'default2'), (23, 'default2'), (24, 'default1'), (25, 'default2');
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (2, NULL), (1, 'default1'), (3, NULL), (4, NULL), (5, NULL), (6, NULL), (7, 'default1'), (8, 'default2'), (9, NULL), (10, NULL);
INSERT INTO colour (id, colour) VALUES (2, 'default2'), (0, NULL), (1, NULL), (3, NULL), (4, 'default2'), (5, NULL), (6, 'default2'), (7, NULL), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (2, 'default1'), (1, 'default1'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default1'), (8, 'default1'), (9, NULL), (10, 'default1'), (11, NULL), (12, 'default1'), (13, 'default1'), (14, 'default2'), (15, 'default1'), (16, 'default2'), (17, 'default2'), (18, NULL), (19, 'default1'), (20, 'default1'), (21, NULL), (22, NULL), (23, 'default1'), (24, NULL), (25, 'default2'), (26, 'default1'), (27, 'default1'), (28, NULL), (29, 'default2'), (30, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 3, 2, 6, 7, 0, 14, 4, 'default1', 'default1', 2, 2), (1, 2, 7, 3, 10, 5, 9, NULL, 'default2', 'default2', NULL, NULL), (0, 10, 2, 3, NULL, 12, 13, 8, NULL, 'default2', 2, NULL), (3, 27, 7, 4, 11, 13, 24, 3, 'default2', 'default1', 1, 0), (4, 27, 1, 0, 6, 14, 30, 4, NULL, 'default1', 1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, NULL), (2, 4), (2, 1), (NULL, 11), (1, 7), (NULL, 13), (0, NULL), (0, 2), (4, 7), (3, 14), (1, 13), (NULL, 9), (3, 0), (0, 5), (1, 9), (4, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT sp.power_name FROM hero_power AS hp JOIN superpower AS sp ON hp.power_id = sp.id WHERE hp.hero_id = 1;

/*
Prediction Result:
('default1',)
('default1',)
('default1',)
*/