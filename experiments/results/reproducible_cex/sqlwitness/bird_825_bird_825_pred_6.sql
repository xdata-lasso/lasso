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
INSERT INTO superpower (id, power_name) VALUES (0, 'default2'), (1, 'default1'), (2, 'default1'), (3, NULL), (4, 'default1'), (5, 'default1'), (6, 'Phoenix Force'), (7, 'Phoenix Force'), (8, 'Phoenix Force'), (9, 'default1'), (10, 'Phoenix Force'), (11, 'default1'), (12, 'Phoenix Force'), (13, 'default1'), (14, NULL), (15, NULL);
INSERT INTO race (id, race) VALUES (1, NULL), (0, 'default2'), (2, 'Phoenix Force'), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'Phoenix Force'), (8, 'Phoenix Force'), (9, 'default1'), (10, NULL);
INSERT INTO gender (id, gender) VALUES (0, 'Phoenix Force'), (1, 'default2'), (2, 'default1'), (3, NULL), (4, 'Phoenix Force'), (5, 'Phoenix Force'), (6, 'default1'), (7, 'Phoenix Force'), (8, 'default1'), (9, 'Phoenix Force');
INSERT INTO colour (id, colour) VALUES (0, NULL), (1, 'default1'), (2, 'default2'), (3, 'Phoenix Force'), (4, 'default2'), (5, 'default1'), (6, 'Phoenix Force'), (7, 'Phoenix Force'), (8, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, 'Phoenix Force'), (1, 'Phoenix Force'), (2, 'Phoenix Force'), (3, 'default1'), (4, 'Phoenix Force'), (5, 'Phoenix Force'), (6, 'default1'), (7, NULL), (8, 'Phoenix Force'), (9, NULL), (10, NULL), (11, 'default1'), (12, NULL), (13, 'default2'), (14, 'default2'), (15, 'default1'), (16, 'default2'), (17, 'Phoenix Force');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 12, 5, 1, 1, NULL, 7, 6, 'default1', 'default2', NULL, 0), (1, 0, 2, 7, 0, NULL, 5, 1, 'Phoenix Force', 'default2', 0, NULL), (2, 8, 3, 7, 6, NULL, 1, 7, NULL, 'Phoenix Force', 1, 1), (3, 13, 3, 1, 6, NULL, 1, 3, 'default1', NULL, 1, 0), (4, 11, 4, 5, 1, NULL, NULL, 5, 'Phoenix Force', 'default1', 0, NULL), (5, 3, 0, 8, 1, NULL, 8, 2, 'Phoenix Force', 'Phoenix Force', 0, NULL), (6, 10, 0, 8, 3, NULL, 0, 3, NULL, 'Phoenix Force', 0, 1), (7, 3, 1, 9, 4, NULL, 4, NULL, NULL, NULL, 1, NULL), (8, NULL, 2, 5, NULL, NULL, 1, 4, 'Phoenix Force', 'default2', NULL, 0), (9, NULL, 4, 9, 4, NULL, 8, NULL, 'Phoenix Force', 'Phoenix Force', NULL, 1), (10, 2, 1, 7, 6, NULL, 10, 6, 'default1', 'Phoenix Force', 0, 1), (11, 2, 6, 0, 4, NULL, 1, 1, 'Phoenix Force', 'default2', NULL, 1), (12, 15, 6, NULL, 0, NULL, 7, 0, NULL, 'default1', NULL, 1), (13, 11, 0, 0, 0, NULL, 1, NULL, 'default1', 'default2', 0, 1), (14, 12, 2, 5, NULL, NULL, 4, 4, 'default2', 'default1', NULL, 1);
INSERT INTO hero_power (hero_id, power_id) VALUES (6, 10), (4, 15), (1, 2), (9, 1), (12, 14), (6, 7), (NULL, 10), (9, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.gender FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T3.power_name = 'Phoenix Force';

/*
Gold Result:
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT gender.gender FROM gender INNER JOIN superhero ON gender.id = superhero.gender_id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Phoenix Force';

/*
Prediction Result:
('default1',)
*/