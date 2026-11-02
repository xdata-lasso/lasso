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
INSERT INTO race (id, race) VALUES (186, 'default2'), (0, NULL), (185, 'Human'), (184, NULL), (1, 'default2'), (2, 'default1'), (3, NULL), (4, 'default2'), (5, 'Human'), (6, 'Human'), (7, NULL), (8, NULL), (9, 'default1'), (10, 'default2'), (11, 'default2'), (12, 'Human'), (13, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Human'), (186, NULL), (0, NULL), (185, 'Human'), (184, 'default2'), (2, 'default1'), (3, 'Human'), (4, 'Human'), (5, NULL), (6, NULL), (7, NULL), (8, 'default2'), (9, NULL), (10, 'default2'), (11, NULL), (12, 'Human'), (13, NULL), (14, 'Human'), (15, 'default2'), (16, 'default2');
INSERT INTO gender (id, gender) VALUES (185, 'default1'), (1, 'default2'), (186, 'default1'), (184, NULL), (0, 'Human'), (2, 'default1'), (3, 'default2'), (4, 'Human'), (5, 'Human'), (6, 'default2'), (7, NULL), (8, 'default2'), (9, NULL), (10, 'Human'), (11, 'Human');
INSERT INTO colour (id, colour) VALUES (0, NULL);
INSERT INTO alignment (id, alignment) VALUES (186, NULL), (185, NULL), (0, 'default1'), (1, 'default2'), (184, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (185, 184, 0, 1, 0, 5, 10, 0, 'default2', 'default1', 186, 186), (0, NULL, 0, 7, 0, 14, 7, 0, 'default1', NULL, 1, 1), (184, 185, 0, 5, 0, 10, NULL, NULL, NULL, NULL, 185, 185), (186, NULL, NULL, 10, 0, NULL, 2, 0, 'default2', 'default1', 184, 186), (1, 0, 0, 6, NULL, 8, 2, 0, 'default1', NULL, NULL, 0), (2, 186, NULL, 5, 0, 1, 1, NULL, 'default2', NULL, 0, 185), (3, 184, NULL, 185, 0, 3, 2, 0, 'default1', NULL, 0, 0), (4, NULL, NULL, NULL, 0, 10, 10, NULL, 'default2', NULL, NULL, NULL), (5, 0, NULL, 10, 0, NULL, 4, NULL, 'default2', NULL, NULL, 1), (6, 185, 0, 8, NULL, 186, 11, 0, NULL, 'Human', 185, NULL), (7, 0, NULL, 2, NULL, NULL, 7, 0, NULL, NULL, 0, NULL), (8, 184, 0, 8, NULL, 3, 11, NULL, 'default2', 'default2', NULL, 1), (9, 186, NULL, NULL, NULL, 3, 186, 0, 'Human', NULL, 185, 1), (10, 185, 0, 186, NULL, 186, 12, 0, 'default2', 'Human', 185, 0), (11, 1, NULL, 3, NULL, 13, 10, NULL, NULL, 'default2', 184, 184), (12, 1, 0, 9, NULL, 12, 3, NULL, 'default1', 'default2', 1, 186);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.colour FROM superhero AS T1 LEFT JOIN race AS T2 ON T1.race_id = T2.id LEFT JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Prediction Result:
(None,)
*/