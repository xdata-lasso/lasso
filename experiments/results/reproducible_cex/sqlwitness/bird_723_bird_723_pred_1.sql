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
INSERT INTO superpower (id, power_name) VALUES (0, NULL), (1, 'Agility'), (2, 'Agility');
INSERT INTO race (id, race) VALUES (1, 'Blue'), (0, 'default2'), (2, NULL), (3, NULL), (4, 'Blue'), (5, 'Blue'), (6, 'default2'), (7, 'Agility'), (8, 'Blue'), (9, 'Agility'), (10, NULL), (11, 'Agility'), (12, 'default2'), (13, 'Agility');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default2'), (0, NULL), (2, 'default1'), (3, 'Agility'), (4, NULL), (5, 'default1'), (6, NULL), (7, NULL), (8, 'Agility'), (9, 'Agility'), (10, 'default2'), (11, NULL), (12, 'Agility'), (13, 'Blue'), (14, 'Blue'), (15, 'Agility'), (16, NULL), (17, 'Blue'), (18, 'Agility'), (19, 'default1'), (20, 'default1'), (21, NULL);
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, 'Blue'), (2, 'Blue'), (3, 'Blue'), (4, 'default1'), (5, 'Agility'), (6, 'Agility'), (7, 'Blue'), (8, 'Blue'), (9, 'Agility'), (10, 'default1'), (11, NULL), (12, 'default2'), (13, NULL), (14, NULL), (15, 'Agility'), (16, 'Agility'), (17, 'Blue'), (18, 'Blue'), (19, 'Blue'), (20, 'Blue');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, 'default1'), (2, NULL), (3, 'Blue'), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, NULL), (8, NULL), (9, NULL), (10, 'Blue'), (11, NULL), (12, 'Blue'), (13, 'Blue'), (14, 'default1'), (15, 'Agility'), (16, 'Blue'), (17, 'Agility');
INSERT INTO alignment (id, alignment) VALUES (0, 'default2'), (1, 'Blue'), (2, 'default1'), (3, 'Blue'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'default1'), (8, NULL), (9, NULL), (10, 'default1'), (11, 'default1'), (12, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, 9, 2, 13, 4, 11, 9, 'Agility', NULL, 1, NULL), (1, 0, 11, 4, 8, 17, 6, 4, 'default2', 'default2', 0, 1), (2, 3, 6, 17, 3, 16, 4, 16, 'Blue', 'default1', NULL, NULL), (3, 0, 15, 8, 17, 6, 6, 6, 'default1', 'default1', 1, 0), (4, 10, 8, 0, 13, NULL, 7, 0, 'default1', 'Agility', 1, 1), (5, NULL, 15, 7, 16, 18, 1, 11, 'default2', 'default1', 1, 1), (6, 5, 17, 18, 1, 17, 1, 0, 'default1', 'Blue', 0, NULL), (7, 5, 14, 13, 3, 10, 7, 0, 'Blue', 'default2', 0, 0), (8, 3, 8, 3, 16, 20, 9, 6, NULL, 'default1', NULL, 1), (9, 6, 10, 4, 7, 6, 8, 14, 'default2', 'default1', 1, NULL), (10, 12, 2, 13, 0, 3, 7, 3, 'Agility', 'Agility', 0, NULL), (11, 0, 11, 18, 5, 11, 12, 2, 'default1', 'default2', 1, NULL), (12, 6, 13, 1, 10, 6, 10, 16, NULL, NULL, 1, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, NULL), (9, 1), (12, 0), (4, NULL), (2, 2), (1, 1), (0, 1), (7, 2), (6, 2), (9, 1), (10, NULL), (2, 2), (11, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN colour AS T4 ON T1.eye_colour_id = T4.id WHERE T3.power_name = 'Agility' AND T4.colour = 'Blue';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) AS blueeyed_agility_heroes FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE colour.colour = 'Blue' AND superpower.power_name = 'Agility';

/*
Prediction Result:
(1,)
*/