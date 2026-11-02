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
INSERT INTO superpower (id, power_name) VALUES (2, 'default2'), (0, 'default1'), (1, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'default1'), (8, NULL), (9, 'default1');
INSERT INTO race (id, race) VALUES (1, 'default2'), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, NULL), (10, 'default2'), (11, 'default1'), (12, NULL), (13, 'default1'), (14, 'default1'), (15, 'default1'), (16, NULL), (17, NULL), (18, NULL), (19, 'default2'), (20, 'default2'), (21, 'default1'), (22, NULL), (23, NULL), (24, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, 'default2'), (2, NULL), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, NULL), (8, 'default2'), (9, NULL), (10, 'default2'), (11, 'default2'), (12, NULL), (13, NULL), (14, 'default1'), (15, 'default1'), (16, NULL), (17, 'default1'), (18, NULL), (19, 'default1'), (20, 'default1'), (21, 'default2'), (22, NULL), (23, 'default2'), (24, 'default2');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (1, 'default1'), (0, 'default1'), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, 'default1'), (9, NULL), (10, 'default2'), (11, 'default2'), (12, 'default2'), (13, 'default1'), (14, 'default1'), (15, 'default1'), (16, 'default2'), (17, 'default2'), (18, 'default1'), (19, NULL);
INSERT INTO colour (id, colour) VALUES (2, NULL), (1, 'default1'), (0, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, 'default1'), (2, 'default2'), (0, 'default1'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, 'default1'), (7, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 6, 0, 12, NULL, 0, 13, 2, 'default1', NULL, 1, 1), (1, 4, 0, 6, 0, 9, 5, NULL, 'default2', 'default1', 0, NULL), (0, 7, 1, 9, 1, 17, 21, 2, 'default1', 'default1', 1, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (2, 3), (2, 5), (0, 7), (2, 3), (1, 7), (0, 1), (1, NULL), (1, NULL), (0, 6), (1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.power_name FROM superpower AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.power_id WHERE T2.hero_id = 1;

/*
Prediction Result:
('default1',)
('default1',)
*/