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
INSERT INTO superpower (id, power_name) VALUES (1, 'Blond'), (0, 'default1'), (2, 'Blue'), (3, 'default2'), (4, 'default1'), (5, 'Blue'), (6, 'default1'), (7, 'Blue'), (8, 'Blond'), (9, 'default1'), (10, NULL), (11, NULL), (12, NULL), (13, 'default2'), (14, 'Blond'), (15, 'default1'), (16, 'Agility'), (17, 'Blue'), (18, 'default2'), (19, 'Blue'), (20, 'default2'), (21, 'default1');
INSERT INTO race (id, race) VALUES (1, 'Blond'), (0, 'default1'), (2, 'Agility'), (3, 'default2'), (4, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Agility'), (1, 'Blond'), (2, 'Blue');
INSERT INTO gender (id, gender) VALUES (0, 'Agility'), (1, 'Agility'), (2, 'Blue'), (3, 'Blue');
INSERT INTO colour (id, colour) VALUES (1, 'Blue'), (0, 'Blond'), (2, 'Blue');
INSERT INTO alignment (id, alignment) VALUES (0, 'Blue'), (1, 'Blond'), (2, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 0, NULL, 0, NULL, 2, 0, 0, 'Blond', 'Blond', NULL, 0), (0, 1, 1, 0, 1, NULL, 2, 0, 'default1', 'default2', 1, 1), (2, 2, 2, 1, NULL, 0, 4, 0, 'Agility', 'Agility', NULL, 0), (3, 0, 2, 3, 1, NULL, 4, 1, 'Blue', 'default2', NULL, NULL), (4, 2, 1, 3, 2, 1, 3, 2, NULL, 'Blond', 0, 0), (5, NULL, 0, 3, 1, NULL, 1, 1, 'default2', 'default1', 0, NULL), (6, NULL, 1, 0, NULL, 1, 0, 0, NULL, 'default1', NULL, NULL), (7, 0, 2, 2, 1, NULL, 1, 2, 'Blond', 'Agility', 0, 0), (8, 1, 2, 1, 2, 2, 1, 2, 'Agility', 'Agility', 1, 0), (9, 2, 1, 1, NULL, 0, NULL, 0, NULL, 'Blue', NULL, NULL), (10, 1, 1, 3, 1, 2, 4, 0, 'Agility', NULL, 1, NULL), (11, NULL, 0, 2, 2, 2, 2, 0, 'Agility', 'Agility', 0, NULL), (12, 2, 0, 0, 1, NULL, 1, NULL, 'default1', 'default1', 1, 1), (13, 2, 2, 3, 1, NULL, NULL, 2, 'default2', 'Agility', 0, 1), (14, 2, 0, 2, 1, 1, 0, 2, 'default1', 'Blond', 1, 1), (15, 2, NULL, 0, 2, 0, 4, 1, 'Blond', 'default2', 1, 1), (16, 1, 1, NULL, 1, 2, 3, NULL, 'Blond', 'Blue', NULL, NULL), (17, NULL, 1, 1, NULL, 2, 2, 1, 'default1', 'Blue', 0, 1), (18, 2, 2, 2, 1, 2, 3, NULL, 'Blond', 'Blue', NULL, 1), (19, 2, 1, 0, NULL, 1, 4, NULL, NULL, NULL, NULL, 0), (20, 1, 0, 1, 2, 0, 4, 0, 'default2', 'Blue', 0, 0), (21, 0, 0, 3, NULL, NULL, 4, 0, NULL, 'Blond', NULL, 0), (22, 1, 2, 1, 2, 0, 0, 1, 'default1', 'default2', NULL, 1), (23, NULL, NULL, NULL, 0, 0, 4, 2, 'Blue', 'default1', 0, 0), (24, 2, 2, NULL, 2, 2, NULL, 0, 'Agility', 'default1', NULL, 1), (25, 2, 0, 0, 0, 1, 0, 0, NULL, 'Blond', 0, NULL), (26, NULL, 1, 3, 0, 1, 1, NULL, 'Blond', 'default1', NULL, NULL), (27, NULL, 1, 3, NULL, 2, 2, NULL, 'default2', 'Blue', NULL, 1), (28, NULL, 2, NULL, 1, NULL, 4, NULL, 'default1', 'Blue', 0, NULL), (29, 2, NULL, 2, NULL, 2, 4, NULL, 'default2', NULL, 1, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (22, 19), (3, 15), (27, 13), (16, 2), (13, 19), (26, 11), (17, 2), (14, 13), (2, 15), (28, 5), (13, 7), (11, 0), (22, 11), (21, 19), (9, 21), (NULL, 4), (6, 20), (29, 21), (26, NULL), (16, 21), (18, 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Blond';

/*
Gold Result:
('Blond',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN colour AS c1 ON s.eye_colour_id = c1.id INNER JOIN colour AS c2 ON s.hair_colour_id = c2.id INNER JOIN hero_power AS hp ON s.id = hp.hero_id INNER JOIN superpower AS sp ON hp.power_id = sp.id WHERE c1.colour = 'Blue' AND c2.colour = 'Blond' AND sp.power_name = 'Agility';

/*
Prediction Result:
*/