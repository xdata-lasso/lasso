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
INSERT INTO race (id, race) VALUES (6, 'default2'), (0, 'Demi-God');
INSERT INTO publisher (id, publisher_name) VALUES (6, 'Demi-God'), (1, 'Demi-God'), (0, 'default2'), (4, 'Demi-God'), (5, 'default1'), (2, 'default2');
INSERT INTO gender (id, gender) VALUES (4, 'Demi-God'), (6, NULL), (0, 'Demi-God'), (5, NULL), (1, 'default1'), (2, 'default2'), (3, 'Demi-God'), (7, 'default1'), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, 'Demi-God'), (13, 'Demi-God'), (14, 'default1'), (15, 'default2'), (16, 'Demi-God'), (17, 'Demi-God'), (18, 'Demi-God');
INSERT INTO colour (id, colour) VALUES (0, 'Demi-God'), (5, 'default1'), (6, 'default2'), (1, NULL), (4, 'default2'), (2, 'default1'), (3, NULL), (7, NULL), (8, 'default2'), (9, 'default1'), (10, 'Demi-God'), (11, 'default1'), (12, NULL), (13, 'default2'), (14, NULL), (15, NULL), (16, NULL), (17, 'Demi-God'), (18, 'default1');
INSERT INTO alignment (id, alignment) VALUES (5, 'Demi-God'), (6, NULL), (4, NULL), (1, 'default2'), (0, 'default1'), (2, 'Demi-God'), (3, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (4, NULL, 4, 3, 3, 6, 6, 13, NULL, 'Demi-God', 4, 1), (1, 4, 3, 8, 5, 0, 0, 2, 'default1', 'Demi-God', NULL, 1), (6, 1, 18, 1, 1, 5, NULL, 16, 'default2', NULL, 0, 6), (0, NULL, 4, 9, 7, 4, 6, 3, 'default1', 'default1', 5, 6), (5, 2, 1, 17, 1, 2, 0, 6, 'default2', 'Demi-God', 1, 5), (2, 5, 6, 6, 9, NULL, NULL, 10, 'default1', 'Demi-God', 6, 0), (3, 2, 16, 9, 3, 4, 6, 3, 'Demi-God', 'default1', 0, 5), (7, 6, 1, 18, 10, NULL, 6, 6, 'default2', 'default2', 6, 1), (8, 2, 18, 1, 15, 4, 0, 17, 'default1', 'default2', 1, 4), (9, 2, 6, 0, 0, 5, 0, 2, 'default2', 'default2', 0, 5), (10, 5, 4, 17, 16, 1, 0, 7, 'default2', 'default1', 6, 0), (11, 1, 14, 2, NULL, 0, 6, 0, 'default2', 'default1', NULL, 5), (12, NULL, 16, 1, 5, 6, 6, 11, 'Demi-God', 'default2', 0, 5), (13, 3, 8, 6, 17, 1, 6, 4, 'Demi-God', 'Demi-God', 0, NULL), (14, NULL, 15, 11, 4, 1, 0, 0, 'Demi-God', NULL, 6, NULL), (15, 0, 3, 1, 5, 1, 0, 0, NULL, 'default2', NULL, 5), (16, 0, 8, 1, 11, 2, 0, 10, 'default1', 'Demi-God', 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
('Demi-God',)
('Demi-God',)
('default2',)
('default2',)
('default1',)
(None,)
('default2',)
('Demi-God',)
*/

-- Prediction Query
SELECT sh.full_name FROM superhero AS sh JOIN race AS r ON sh.race_id = r.id WHERE r.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
('Demi-God',)
('Demi-God',)
('default2',)
('default2',)
('default1',)
*/