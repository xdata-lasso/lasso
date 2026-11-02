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
INSERT INTO race (id, race) VALUES (4, 'default1'), (0, NULL), (1, 'Demi-God'), (5, 'Demi-God'), (6, NULL), (2, 'Demi-God');
INSERT INTO publisher (id, publisher_name) VALUES (6, 'Demi-God'), (0, 'Demi-God'), (4, 'default2'), (1, 'Demi-God'), (5, 'Demi-God'), (2, NULL), (3, 'default1'), (7, 'default2'), (8, NULL), (9, 'Demi-God'), (10, 'default1'), (11, 'default2'), (12, 'Demi-God'), (13, 'default1');
INSERT INTO gender (id, gender) VALUES (5, NULL), (6, 'default2'), (0, 'default2'), (4, 'default1'), (1, 'default1'), (2, 'default2'), (3, 'default1');
INSERT INTO colour (id, colour) VALUES (6, 'default1'), (4, 'default2'), (1, 'Demi-God'), (5, 'Demi-God'), (0, NULL), (2, 'default2'), (3, 'default1'), (7, 'default1'), (8, 'Demi-God'), (9, NULL);
INSERT INTO alignment (id, alignment) VALUES (5, 'default1'), (0, 'Demi-God'), (6, NULL), (4, 'default2'), (1, 'Demi-God'), (2, 'default1'), (3, NULL), (7, NULL), (8, 'Demi-God'), (9, 'Demi-God'), (10, NULL), (11, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (4, 8, 5, 1, 9, 0, 1, 2, 'default1', 'default2', NULL, NULL), (6, 10, 9, 4, 9, 5, 6, 3, NULL, NULL, 4, 0), (1, 7, 1, 5, NULL, 6, 4, 1, 'default1', 'default1', 6, 6), (5, 6, 1, NULL, 4, 2, 6, 8, 'default2', 'default2', 1, NULL), (0, 11, 9, 4, 3, 0, 5, 0, 'default2', 'Demi-God', 4, 4), (2, 4, 2, 0, NULL, 13, 4, 4, 'Demi-God', NULL, 5, 0), (3, 3, NULL, 1, 7, 9, 2, NULL, NULL, 'Demi-God', 1, NULL), (7, 4, NULL, 4, 3, 1, 5, 0, 'default2', 'default1', 1, 4), (8, 6, 9, 5, 7, 5, 2, 0, 'Demi-God', 'default1', 6, 0), (9, 11, NULL, 3, 0, 9, 6, 7, 'default2', NULL, 1, 6), (10, 11, 9, NULL, 9, NULL, 2, NULL, NULL, NULL, 4, 4), (11, 3, 5, 6, 7, 6, 1, 4, 'Demi-God', 'Demi-God', 0, 0), (12, 7, NULL, 2, 6, 2, 5, 7, 'default1', 'Demi-God', 4, 6), (13, NULL, NULL, 3, 1, 5, 4, 4, 'Demi-God', 'default2', 0, 6), (14, 11, 1, 6, 2, 2, 4, NULL, 'Demi-God', NULL, 6, 1), (15, 0, 9, 6, 3, 7, 6, 8, NULL, 'Demi-God', 6, 0), (16, 5, 0, 6, 7, 8, 2, 3, NULL, 'default1', 5, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
('Demi-God',)
('Demi-God',)
('default2',)
('default1',)
('default1',)
(None,)
('Demi-God',)
('Demi-God',)
('default1',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN race ON superhero.race_id = race.id WHERE race.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
('Demi-God',)
('Demi-God',)
('default2',)
('default1',)
('default1',)
*/