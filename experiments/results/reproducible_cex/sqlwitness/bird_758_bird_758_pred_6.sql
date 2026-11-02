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
INSERT INTO race (id, race) VALUES (186, 'default1'), (184, NULL), (185, NULL), (1, NULL), (0, NULL), (2, 'Human'), (3, NULL), (4, 'Human'), (5, 'default2'), (6, 'default1'), (7, 'Human'), (8, 'Human'), (9, 'Human');
INSERT INTO publisher (id, publisher_name) VALUES (185, 'default2'), (186, 'Human'), (0, 'default1'), (1, 'default1'), (184, 'default1'), (2, 'default2'), (3, NULL), (4, 'Human'), (5, 'default2'), (6, 'default2'), (7, 'default2'), (8, 'Human'), (9, NULL), (10, 'default2'), (11, 'default1'), (12, 'default1'), (13, NULL), (14, NULL), (15, 'Human'), (16, 'default2'), (17, 'default2'), (18, 'Human'), (19, 'default1'), (20, 'default2'), (21, 'Human'), (22, 'Human'), (23, 'default2'), (24, 'Human'), (25, 'default2'), (26, 'Human'), (27, 'default1'), (28, NULL), (29, 'default1'), (30, NULL), (31, 'Human'), (32, 'default2'), (33, 'default1'), (34, 'default1');
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (185, 'Human'), (184, 'default1'), (186, 'Human'), (1, NULL), (2, 'Human'), (3, 'Human'), (4, 'default2'), (5, 'default2'), (6, 'Human'), (7, 'default1'), (8, 'Human'), (9, 'default1'), (10, 'Human'), (11, 'default1'), (12, 'default1'), (13, 'default1'), (14, 'Human'), (15, 'default1'), (16, NULL), (17, 'Human'), (18, 'default2'), (19, 'default2'), (20, 'Human'), (21, 'default2'), (22, 'default1'), (23, 'default2'), (24, NULL), (25, 'Human'), (26, NULL), (27, NULL), (28, 'default2'), (29, 'default1'), (30, NULL), (31, NULL), (32, NULL), (33, NULL), (34, 'default1'), (35, 'default1'), (36, 'default1'), (37, 'default2'), (38, 'default2'), (39, NULL), (40, 'default2'), (41, NULL), (42, 'default2');
INSERT INTO colour (id, colour) VALUES (0, NULL), (1, 'default2'), (184, 'default2'), (185, 'default2'), (186, 'default2'), (2, 'Human'), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, 'default2'), (7, NULL), (8, 'Human'), (9, 'default2'), (10, NULL), (11, 'default2'), (12, 'default1'), (13, NULL), (14, 'default1'), (15, 'Human'), (16, NULL), (17, 'default1'), (18, 'Human'), (19, 'Human'), (20, 'default1'), (21, 'Human'), (22, 'default2'), (23, NULL), (24, NULL), (25, NULL), (26, NULL), (27, 'default2'), (28, 'Human'), (29, 'default1'), (30, 'Human'), (31, 'Human');
INSERT INTO alignment (id, alignment) VALUES (184, 'default2'), (0, 'default2'), (1, 'default2'), (186, NULL), (185, NULL), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, NULL), (6, 'default2'), (7, NULL), (8, 'default1'), (9, NULL), (10, 'Human'), (11, 'default2'), (12, 'default2'), (13, 'Human'), (14, 'default1'), (15, 'default1'), (16, NULL), (17, 'default2'), (18, 'default1'), (19, 'Human'), (20, NULL), (21, 'default2'), (22, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (184, 12, 5, 42, 7, 9, 4, 24, 'default2', 'Human', 186, 0), (185, 7, 23, 5, NULL, 14, NULL, 28, 'default2', NULL, 186, NULL), (1, 22, 18, 3, 24, 186, 6, 22, 'default2', 'default2', 0, 1), (186, 13, 6, 22, 13, 33, 4, 13, 'Human', 'Human', 0, 186), (0, 2, 10, 31, 12, 22, 7, 17, 'default1', NULL, NULL, NULL), (2, 2, 3, 15, 29, 34, 5, 15, 'default1', 'default2', 184, 184), (3, 6, 5, 184, 17, 14, 2, 10, 'default2', 'default2', 186, 184), (4, 17, 21, 38, 21, 21, 184, 28, NULL, NULL, 184, 185), (5, 184, 19, 21, 186, 16, NULL, 4, NULL, 'default1', 1, 186), (6, 21, 7, 26, 13, 10, 4, 1, 'default2', NULL, 186, 186), (7, 2, 14, 31, 27, 6, 1, NULL, 'default1', 'default1', 184, 1), (8, 18, 8, 26, 1, NULL, 7, 22, NULL, 'default1', 185, 184), (9, 22, 1, 19, 0, NULL, 1, 0, 'default1', 'Human', 184, 184), (10, 19, 10, NULL, 0, 9, 7, 6, 'Human', 'default1', 0, 0), (11, 19, 22, 5, 20, 1, NULL, 20, NULL, 'default2', 0, NULL), (12, 1, 186, 185, 1, 4, NULL, NULL, 'Human', 'default1', 0, 185), (13, 22, 16, 31, NULL, 20, 9, 23, 'default1', NULL, 1, 0), (14, 22, 15, 34, 0, 29, 5, 13, 'Human', 'default1', 0, 184), (15, 15, 22, 34, 8, 28, 8, 23, 'Human', 'Human', 0, 0), (16, 1, 185, 25, 31, 24, 3, 14, NULL, 'default2', 0, 1), (17, 0, 16, 10, 15, 20, 6, 25, 'Human', NULL, 186, 186), (18, 11, 3, 9, 10, 18, 1, 30, 'default1', 'default1', 0, 1), (19, 16, 1, 34, 18, 34, 3, 26, 'Human', 'Human', 0, 0), (20, 3, 2, 11, 0, 184, 185, 18, 'Human', 'default1', NULL, 186), (21, 17, 23, 8, 5, 8, 9, 9, NULL, 'default2', 185, 184), (22, NULL, 2, 10, 15, 28, 5, 22, 'default1', 'default2', 1, 0), (23, 21, 7, 9, 24, 6, 9, 14, 'default1', 'default1', 1, 184), (24, 9, 25, 1, 186, 9, 7, 29, 'default2', 'default2', 0, 185), (25, 20, 25, 33, 9, 5, 4, 5, NULL, NULL, NULL, 186), (26, 22, 27, 40, 13, 10, 1, 24, 'Human', 'default2', 0, 184), (27, 8, 2, 1, 31, 34, 9, 23, 'default1', 'default1', NULL, 1), (28, 13, 9, 6, 3, 10, 186, 11, 'default2', 'default1', 186, 1), (29, 20, 18, 23, 30, NULL, 5, 8, 'default2', NULL, 185, 0), (30, NULL, 15, 184, 14, 31, 7, 27, 'Human', NULL, 1, NULL), (31, 17, 184, 1, 0, 15, 186, 29, 'default1', 'default2', 185, 185), (32, 14, 26, 29, 185, 12, 1, 184, 'default2', 'default2', 186, 1), (33, 13, 30, 10, 19, 5, 2, 2, NULL, 'default1', 0, NULL), (34, 10, 13, 6, 0, NULL, 7, 22, NULL, 'default1', 186, 1), (35, 10, 22, 22, 19, 2, NULL, 20, 'Human', 'Human', 184, 1), (36, 184, 27, 9, 184, 16, 186, 29, NULL, NULL, 185, NULL), (37, 13, 17, 22, 22, 31, 1, 17, 'Human', 'Human', 1, 185), (38, 7, 7, 35, 7, 10, 6, 15, 'default2', 'default1', 1, 185), (39, 16, 185, 5, 6, NULL, 9, 17, 'default1', NULL, 184, 185), (40, 6, 0, 18, 28, 21, 7, 28, 'default2', 'default2', NULL, 186);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id WHERE T1.height_cm = 185 AND T3.race = 'Human';

/*
Prediction Result:
('default2',)
('default2',)
*/