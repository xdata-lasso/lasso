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
INSERT INTO race (id, race) VALUES (1, 'default1'), (6, NULL), (4, NULL), (5, 'Demi-God'), (0, 'Demi-God'), (2, 'Demi-God'), (3, 'default1'), (7, 'Demi-God'), (8, 'Demi-God'), (9, 'Demi-God');
INSERT INTO publisher (id, publisher_name) VALUES (4, 'Demi-God'), (5, NULL), (0, NULL);
INSERT INTO gender (id, gender) VALUES (6, 'default2'), (4, NULL), (5, 'Demi-God'), (0, 'default2'), (1, 'default1');
INSERT INTO colour (id, colour) VALUES (4, 'default2'), (5, 'Demi-God'), (0, NULL), (6, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'Demi-God'), (4, 'default2'), (1, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, NULL, 0, 5, 4, 5, 7, 4, 'default1', NULL, 6, 0), (0, 4, 6, 1, 5, 0, 1, 5, 'Demi-God', 'Demi-God', NULL, NULL), (5, NULL, 4, 6, 6, 0, 5, 5, 'Demi-God', 'default1', 5, NULL), (4, 4, 5, NULL, 0, 4, 3, 5, NULL, 'default2', 1, 4), (6, NULL, 4, 5, NULL, 0, 7, 6, 'Demi-God', NULL, 0, NULL), (2, 0, NULL, 5, 0, 0, NULL, 0, 'Demi-God', 'default2', NULL, 6), (3, NULL, 5, 1, 0, 4, 7, 6, 'Demi-God', 'default2', 1, NULL), (7, 0, 5, 0, NULL, 4, 9, 4, NULL, 'default2', 0, 5), (8, 1, 5, 0, NULL, 0, 7, NULL, 'Demi-God', NULL, 6, 1), (9, 4, 0, 0, NULL, 0, 8, NULL, 'default1', 'Demi-God', 0, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
(None,)
('default2',)
('default1',)
(None,)
('default2',)
(None,)
('Demi-God',)
*/

-- Prediction Query
SELECT full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
(None,)
('default2',)
('default1',)
(None,)
('default2',)
*/