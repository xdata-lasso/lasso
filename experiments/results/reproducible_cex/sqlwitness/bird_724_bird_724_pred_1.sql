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
INSERT INTO race (id, race) VALUES (1, 'Blond'), (0, 'Blue'), (2, 'Blond');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (1, 'Blond'), (2, 'Blue'), (3, NULL), (4, 'Blond'), (5, 'default2'), (6, 'default1'), (7, 'Blue'), (8, 'default2'), (9, 'Blue'), (10, NULL), (11, NULL), (12, 'default2'), (13, 'default1'), (14, NULL), (15, 'default2'), (16, 'Blue'), (17, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (0, 'Blue'), (2, 'Blond'), (3, NULL), (4, 'Blue'), (5, NULL), (6, 'Blond'), (7, 'Blue'), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default2'), (12, NULL), (13, 'Blue');
INSERT INTO colour (id, colour) VALUES (1, NULL), (0, 'Blond'), (2, 'Blond'), (3, NULL), (4, 'Blond'), (5, 'Blue'), (6, 'Blond');
INSERT INTO alignment (id, alignment) VALUES (1, 'Blond'), (0, 'Blue'), (2, 'default1'), (3, 'Blond'), (4, 'Blue'), (5, 'Blue'), (6, 'Blue'), (7, 'default2'), (8, 'default2'), (9, 'Blond'), (10, 'Blue'), (11, 'default1'), (12, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 6, 3, 10, 5, 0, 1, 0, 'default1', 'Blue', 1, 1), (1, 0, 5, 3, 0, 5, 2, 2, 'Blond', NULL, 0, 0), (2, 11, 6, 5, 1, NULL, 2, 4, 'default1', 'default1', 1, 1), (3, 1, 2, 13, NULL, 9, 0, 4, NULL, 'Blue', NULL, 1), (4, 2, 1, 6, 2, 16, 0, 1, NULL, 'Blond', 1, 0), (5, 2, 2, 12, 4, 5, 0, 6, 'default1', 'default2', 1, 0), (6, 10, 2, 12, 0, 6, 1, 6, NULL, 'Blond', 1, 0), (7, 5, 2, 8, 5, 14, 2, 3, 'Blue', NULL, 1, 1), (8, 7, 3, 2, 4, 1, NULL, NULL, 'default2', 'default2', 0, 1), (9, 1, 6, 7, 6, NULL, 2, NULL, 'default1', NULL, NULL, 0), (10, 1, 6, 0, 1, 9, NULL, 2, 'default2', NULL, 1, NULL), (11, 6, 1, 5, 2, 12, 1, 3, 'default2', 'default1', 1, 1), (12, 6, 1, 2, NULL, 13, 1, 2, 'default1', NULL, NULL, 0), (13, 9, 6, 13, NULL, 0, 0, 2, 'default2', 'Blue', 1, NULL), (14, 9, 1, 13, 4, 6, 0, 6, 'default2', 'Blond', 1, 1), (15, 2, 3, 12, 1, 0, 2, 0, 'default2', NULL, 0, 1), (16, 10, 5, 8, 6, 2, 2, NULL, 'Blue', 'Blue', NULL, 0), (17, 10, 5, 12, 3, 9, 0, 2, 'Blue', 'default1', 0, NULL), (18, 6, 5, 6, 0, 16, NULL, 1, 'default1', 'default2', 1, NULL), (19, 8, 2, NULL, NULL, 9, 2, 2, 'default2', 'Blue', 1, 1), (20, 8, 5, 12, 0, 3, 0, 5, NULL, 'default2', 1, 0), (21, 5, 2, 11, 6, 5, 2, NULL, 'Blond', NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Blond';

/*
Gold Result:
('Blond',)
('Blue',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT superhero_name FROM superhero WHERE eye_colour_id = (SELECT id FROM colour WHERE colour = 'Blue') AND hair_colour_id = (SELECT id FROM colour WHERE colour = 'Blond');

/*
Prediction Result:
('Blond',)
('default1',)
(None,)
*/