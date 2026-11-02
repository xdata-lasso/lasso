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
INSERT INTO race (id, race) VALUES (6, 'default2'), (4, 'Demi-God'), (5, 'default2'), (1, 'default2'), (0, 'Demi-God'), (2, 'Demi-God'), (3, 'Demi-God');
INSERT INTO publisher (id, publisher_name) VALUES (4, NULL), (6, NULL), (0, NULL), (5, 'default1'), (1, 'Demi-God'), (2, 'Demi-God'), (3, 'default2'), (7, 'default1'), (8, NULL), (9, 'default1');
INSERT INTO gender (id, gender) VALUES (4, 'default1'), (1, 'Demi-God'), (0, NULL), (5, NULL), (6, 'default2'), (2, NULL), (3, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (5, 'Demi-God'), (0, 'default2'), (6, 'default2'), (4, 'default1'), (2, 'default1'), (3, 'default2'), (7, 'default2'), (8, 'default1'), (9, NULL), (10, NULL), (11, 'default2'), (12, NULL), (13, 'Demi-God');
INSERT INTO alignment (id, alignment) VALUES (5, NULL), (1, 'default1'), (6, 'default2'), (4, NULL), (0, 'default2'), (2, 'Demi-God'), (3, 'default1'), (7, 'Demi-God'), (8, 'Demi-God'), (9, 'default2'), (10, NULL), (11, NULL), (12, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 9, 5, 0, 3, 0, NULL, 4, NULL, 'Demi-God', 6, NULL), (5, 8, 0, 3, 10, 0, 0, NULL, 'Demi-God', NULL, NULL, NULL), (4, 0, 0, 5, 3, 8, 3, 5, 'default1', 'default1', 6, NULL), (0, NULL, 3, 0, 3, NULL, 4, 10, 'Demi-God', 'default1', 5, 4), (6, 11, 3, 3, 12, 4, 5, NULL, NULL, 'default1', NULL, 5), (2, 4, 5, 4, 8, 2, NULL, 13, 'default1', 'default2', 6, 4), (3, 2, 0, 2, 12, 9, 2, 9, NULL, 'Demi-God', 4, 1), (7, 10, 8, NULL, 0, 0, 2, 9, 'Demi-God', 'default2', 6, 5), (8, 1, NULL, 1, 3, NULL, 3, 12, 'Demi-God', NULL, 6, NULL), (9, 8, 6, 1, 6, 4, 3, NULL, 'default1', 'default1', 4, NULL), (10, 8, 11, 5, 7, 1, 4, 3, 'default1', NULL, NULL, 5), (11, 1, 7, 3, 12, 6, NULL, 9, NULL, 'default2', 0, 6), (12, 8, 10, 6, NULL, 1, 5, 1, 'default2', NULL, 0, 0), (13, 0, 13, NULL, 12, 5, 1, 1, NULL, 'default2', 1, 5), (14, 8, 6, NULL, NULL, 3, 0, 11, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
('default1',)
('Demi-God',)
('default1',)
(None,)
('default2',)
(None,)
('default1',)
(None,)
(None,)
*/

-- Prediction Query
SELECT s.full_name FROM superhero AS s JOIN race AS r ON s.race_id = r.id WHERE r.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
('default1',)
('Demi-God',)
('default1',)
(None,)
('default2',)
*/