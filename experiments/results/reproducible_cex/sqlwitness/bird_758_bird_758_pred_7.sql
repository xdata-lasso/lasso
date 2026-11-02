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
INSERT INTO race (id, race) VALUES (0, 'Human'), (184, 'default1'), (186, 'default1'), (185, 'Human'), (1, NULL), (2, 'default1'), (3, NULL), (4, NULL), (5, 'Human'), (6, 'Human'), (7, NULL), (8, 'default2'), (9, 'default1'), (10, 'Human'), (11, NULL), (12, 'default1'), (13, 'Human'), (14, 'default1'), (15, 'default2'), (16, NULL), (17, 'default2'), (18, 'default1'), (19, 'default1'), (20, 'Human');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default2'), (185, 'default2'), (186, 'default1'), (1, NULL), (184, NULL), (2, 'default2'), (3, 'Human'), (4, 'Human'), (5, 'default1'), (6, 'default1'), (7, 'Human'), (8, 'default1'), (9, 'default1'), (10, NULL), (11, 'default1'), (12, NULL), (13, NULL);
INSERT INTO gender (id, gender) VALUES (0, 'default2'), (186, 'default2'), (1, 'default1'), (185, 'Human'), (184, 'default1'), (2, NULL), (3, 'default1'), (4, 'Human'), (5, 'default1'), (6, 'default2'), (7, NULL), (8, 'Human'), (9, NULL), (10, 'default1'), (11, NULL), (12, NULL), (13, 'default1'), (14, NULL), (15, NULL), (16, 'default1'), (17, 'default1'), (18, NULL), (19, 'default2'), (20, 'default1'), (21, 'default2'), (22, NULL), (23, NULL), (24, 'default1');
INSERT INTO colour (id, colour) VALUES (186, NULL), (0, 'Human'), (1, 'default1'), (184, NULL), (185, NULL), (2, NULL), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'Human'), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default2'), (11, 'default1'), (12, NULL), (13, 'Human'), (14, 'default2'), (15, NULL), (16, 'Human');
INSERT INTO alignment (id, alignment) VALUES (0, 'Human'), (184, 'Human'), (1, NULL), (186, 'default1'), (185, NULL), (2, 'Human'), (3, NULL), (4, 'default2'), (5, 'Human'), (6, NULL), (7, NULL), (8, 'default2'), (9, 'Human'), (10, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 2, 4, 0, 9, 8, 11, 8, NULL, 'default1', 186, NULL), (186, 184, 13, 3, 14, 9, 0, NULL, 'default2', 'default2', 186, 1), (184, 185, 11, 24, 3, 12, 11, 186, 'default1', NULL, 1, 184), (185, NULL, 13, 16, 14, 12, 4, 11, NULL, 'default1', 185, 186), (0, 185, 186, 14, 185, 10, 4, 6, 'default2', 'default1', 0, 184), (2, 4, 8, 14, 16, 185, 8, 5, 'default2', 'default2', NULL, 1), (3, 185, 8, 6, 0, 2, 185, 0, NULL, NULL, 1, 0), (4, 10, 12, 3, 7, 13, 11, 15, 'default2', 'default2', 185, 0), (5, 2, NULL, 13, 15, 184, 185, 9, NULL, 'default2', 186, 184), (6, 3, 15, 11, 3, 4, 184, 3, 'default1', 'default2', 185, 0), (7, 4, 1, 4, 13, 8, 10, 1, 'default2', 'default1', 185, 1), (8, 2, 184, 16, 7, 184, 16, 3, 'default1', 'default2', 186, 0), (9, 10, 11, 21, 186, 11, 18, 1, NULL, 'Human', NULL, 186), (10, 10, 186, 8, 186, 8, 17, 15, 'default1', 'Human', 186, 0), (11, NULL, 16, 185, 16, 12, 11, 5, 'default2', NULL, 184, 186), (12, 185, 2, 15, 10, 13, 10, NULL, 'default1', NULL, 185, 186), (13, 10, 8, 18, 1, 184, NULL, 10, 'Human', 'Human', 186, 184), (14, 2, 7, 1, 12, 7, 0, NULL, 'Human', 'Human', NULL, 0), (15, 4, 16, 22, 13, 2, 20, 185, NULL, NULL, 185, 186), (16, 7, 14, 6, 14, 1, 12, 3, 'default1', 'Human', 184, NULL), (17, 4, 13, NULL, 0, 3, 1, 15, NULL, 'default1', NULL, 0), (18, 8, 15, 13, 186, NULL, 15, 15, 'Human', 'default2', 184, 185), (19, 0, 16, 13, 7, 10, 10, 16, 'Human', 'default1', 1, 1), (20, 186, 10, 9, 1, 7, 184, 13, NULL, 'default2', 185, 184), (21, 184, 12, 5, 186, 13, 8, 7, 'Human', 'default1', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('Human',)
('default2',)
*/

-- Prediction Query
SELECT c.colour FROM superhero AS s JOIN colour AS c ON s.hair_colour_id = c.id JOIN race AS r ON s.race_id = r.id WHERE s.height_cm = 185 AND r.race = 'Human';

/*
Prediction Result:
('Human',)
('default2',)
('Human',)
*/