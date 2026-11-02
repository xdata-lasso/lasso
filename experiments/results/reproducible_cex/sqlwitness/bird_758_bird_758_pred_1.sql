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
INSERT INTO race (id, race) VALUES (1, 'default1'), (186, 'default1'), (185, 'default1'), (184, 'default1'), (0, 'default2'), (2, 'default2'), (3, 'default2'), (4, 'Human'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, 'Human'), (9, 'Human'), (10, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (184, 'default1'), (186, 'default2'), (0, 'default2'), (185, NULL);
INSERT INTO gender (id, gender) VALUES (184, NULL), (1, 'default1'), (0, 'Human'), (185, NULL), (186, 'default1');
INSERT INTO colour (id, colour) VALUES (1, 'Human');
INSERT INTO alignment (id, alignment) VALUES (1, 'default1'), (186, NULL), (185, 'Human'), (0, 'default2'), (184, 'default2'), (2, 'default1'), (3, 'Human'), (4, 'default2'), (5, 'Human'), (6, 'default2'), (7, 'Human'), (8, 'Human'), (9, 'default2'), (10, 'Human'), (11, NULL), (12, 'default2'), (13, 'default1'), (14, NULL), (15, 'default1'), (16, NULL), (17, 'default2'), (18, 'Human');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (186, 5, NULL, 184, 1, 186, 3, NULL, 'default1', 'default2', 185, 0), (185, 186, 1, NULL, NULL, NULL, 4, NULL, 'default2', 'Human', 186, NULL), (0, 0, 1, 186, 1, 0, 10, 1, 'Human', NULL, NULL, NULL), (184, 1, NULL, 1, 1, NULL, 5, NULL, NULL, 'default2', 0, 186), (1, 0, 1, 1, 1, 186, 10, NULL, 'Human', 'Human', 0, 184), (2, 18, 1, 184, NULL, 184, NULL, 1, 'default1', NULL, 0, 184), (3, 7, NULL, 184, NULL, 184, 2, NULL, NULL, 'Human', 185, 186), (4, 16, NULL, 186, NULL, 184, 10, 1, 'default2', NULL, 184, NULL), (5, 186, NULL, NULL, 1, 185, 9, 1, NULL, 'default2', 185, NULL), (6, 4, NULL, 1, 1, NULL, 184, 1, 'default1', 'Human', 1, 185), (7, 186, 1, 186, 1, 0, 6, NULL, 'Human', 'Human', 1, NULL), (8, 0, NULL, 186, 1, 185, 7, NULL, NULL, NULL, 186, 1), (9, 6, NULL, 186, NULL, 0, 1, NULL, 'Human', NULL, 184, 0), (10, 10, 1, 184, NULL, NULL, 184, 1, 'Human', 'default2', 1, 0), (11, 16, NULL, 0, NULL, 186, 5, 1, 'default1', 'Human', 1, 186), (12, 9, NULL, 1, 1, 184, 3, NULL, 'Human', 'default1', 1, 186), (13, 16, NULL, 185, 1, 186, 8, 1, 'default2', 'Human', 185, 185);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('Human',)
*/

-- Prediction Query
SELECT colour.colour FROM superhero INNER JOIN race ON superhero.race_id = race.id INNER JOIN colour ON superhero.hair_colour_id = colour.id WHERE race.race = 'Human' AND superhero.height_cm = 185;

/*
Prediction Result:
('Human',)
('Human',)
*/