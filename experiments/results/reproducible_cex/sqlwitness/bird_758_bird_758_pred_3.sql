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
INSERT INTO race (id, race) VALUES (185, 'default1'), (0, 'default2'), (184, NULL), (1, 'Human'), (186, 'default1'), (2, 'default1'), (3, NULL), (4, 'default1'), (5, NULL), (6, 'default1'), (7, 'Human'), (8, 'Human'), (9, 'Human'), (10, 'default2'), (11, NULL), (12, NULL), (13, 'Human'), (14, 'Human'), (15, 'default2'), (16, 'Human'), (17, 'default2'), (18, 'default1'), (19, NULL), (20, 'default1'), (21, 'Human'), (22, 'Human'), (23, NULL), (24, 'Human'), (25, 'default2'), (26, 'default1'), (27, 'Human'), (28, 'Human'), (29, NULL), (30, 'default1'), (31, 'Human');
INSERT INTO publisher (id, publisher_name) VALUES (184, NULL), (1, 'Human'), (0, NULL), (186, 'Human'), (185, 'default2'), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, 'Human'), (7, 'default1'), (8, 'Human'), (9, NULL), (10, 'default2'), (11, 'default1'), (12, 'Human'), (13, 'Human'), (14, 'default1'), (15, NULL), (16, NULL), (17, NULL), (18, 'default2'), (19, 'default1'), (20, 'default1'), (21, 'default2'), (22, 'Human'), (23, 'Human'), (24, 'default2'), (25, 'default2'), (26, NULL), (27, 'Human');
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (185, 'default2'), (184, 'default1'), (1, NULL), (186, 'default2'), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1');
INSERT INTO colour (id, colour) VALUES (0, NULL), (185, 'default1'), (186, NULL), (184, 'default2'), (1, 'default1'), (2, 'default2'), (3, 'default2'), (4, 'Human'), (5, 'default1'), (6, 'default1'), (7, 'Human'), (8, 'default2');
INSERT INTO alignment (id, alignment) VALUES (185, NULL), (186, 'default1'), (1, 'default2'), (184, 'Human'), (0, 'default2'), (2, 'default1'), (3, NULL), (4, 'Human'), (5, 'default1'), (6, NULL), (7, 'Human'), (8, 'default1'), (9, 'Human'), (10, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 8, NULL, 186, 0, 7, 27, 8, 'default1', 'default1', 185, 1), (0, 186, 6, 0, 0, 0, 27, 185, 'default1', NULL, 185, 1), (184, 0, NULL, NULL, 2, 15, 18, 3, 'default1', 'default1', 185, NULL), (185, 186, 8, 5, 184, 20, 3, 1, 'default1', 'Human', 1, NULL), (186, 10, 8, 184, 2, 14, 27, 7, NULL, 'Human', 185, 186), (2, 6, 6, NULL, 3, 15, 5, 4, NULL, NULL, 185, 186), (3, 8, 7, 4, 4, 185, 13, 8, 'Human', 'default1', 0, 0), (4, 185, 7, 4, 185, 184, 9, 2, 'Human', 'default2', 0, 184), (5, 8, 0, NULL, 5, 8, 23, 1, NULL, 'Human', 185, 0), (6, 6, 2, 2, 0, 17, 2, 3, NULL, 'Human', NULL, 186), (7, 3, 0, 186, 2, 184, 6, 186, 'Human', NULL, 184, 185), (8, NULL, 2, 4, 3, NULL, 4, 6, NULL, 'Human', NULL, 0), (9, 6, 0, 3, 2, 23, 27, 4, 'default1', 'Human', 0, NULL), (10, 10, NULL, 1, 7, 184, 185, 186, 'Human', 'Human', 184, 0), (11, 5, 185, 0, 1, 22, 29, 5, 'default2', 'Human', 185, 185), (12, 10, NULL, 2, 0, 19, 5, NULL, NULL, 'default2', 186, 1), (13, NULL, 1, 3, 185, 10, 9, 5, NULL, NULL, 184, 186), (14, 186, 184, 184, 4, 5, 20, 186, 'default1', 'default2', 185, 186), (15, 1, 5, 3, 1, 14, 18, 2, 'default1', 'default2', NULL, 184), (16, 5, 7, 5, 5, 18, 12, 8, 'default1', 'default2', 185, 186), (17, 3, 7, 0, 3, 14, 184, 0, 'Human', 'default2', 1, 185), (18, NULL, 0, 0, 185, 11, 6, 185, NULL, 'default1', 185, 0), (19, 186, 1, 186, 5, 26, 22, 3, 'default1', 'default2', 186, 186), (20, 1, 1, 3, 5, 25, 31, 5, 'default1', 'default1', 184, NULL), (21, 6, 185, 5, 0, 6, 9, 0, 'default2', 'default2', 1, 184), (22, 4, 4, NULL, 5, 23, 27, 7, 'default2', 'default1', 0, 185), (23, 4, 8, 2, 2, 26, 23, 186, 'default2', NULL, 186, 184), (24, 0, 3, 2, 7, NULL, 30, 8, NULL, 'Human', 1, 184), (25, 8, 0, 185, 184, 23, 4, 4, NULL, 'default2', NULL, 0), (26, 185, 6, 5, 5, 10, 5, NULL, 'default2', 'default1', 185, 184), (27, 3, 8, 1, 7, 7, 9, 4, 'Human', 'default2', NULL, 0), (28, 4, 7, 4, NULL, 23, 186, 186, 'default2', NULL, 186, 184), (29, 5, 3, 4, 186, 1, 29, NULL, 'default2', NULL, 186, NULL), (30, 10, 3, 0, 4, 15, 14, 4, 'default2', 'default2', NULL, 186), (31, NULL, 184, 184, NULL, 1, 23, 5, NULL, 'Human', 1, 184), (32, 1, 2, 0, 1, 2, 3, 186, NULL, 'default1', 185, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Prediction Result:
(None,)
(None,)
('default2',)
*/