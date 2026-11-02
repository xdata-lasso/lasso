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
INSERT INTO race (id, race) VALUES (1, 'default1'), (2, NULL), (0, NULL), (3, 'default2'), (4, 'default1'), (5, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (2, 'default1'), (1, 'default2'), (3, 'default1'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'default2'), (9, NULL), (10, 'default1'), (11, NULL), (12, 'default2'), (13, NULL), (14, 'default2');
INSERT INTO gender (id, gender) VALUES (0, NULL), (2, 'default1'), (1, NULL), (3, NULL), (4, 'default2');
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, NULL), (2, 'default2'), (3, NULL), (4, NULL), (5, 'default2'), (6, NULL), (7, 'default2'), (8, 'default2'), (9, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (2, NULL), (1, 'default1'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, 'default1'), (10, NULL), (11, 'default1'), (12, 'default2'), (13, 'default1'), (14, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 4, 0, 4, 2, 4, 5, 2, 'default2', 'default1', 0, NULL), (2, 5, 8, 3, 7, 13, 5, 5, 'default1', 'default2', 2, 2), (0, NULL, 7, 4, NULL, 4, 4, 2, 'default2', NULL, 0, 2), (3, 12, 9, 1, 8, 4, 0, 7, 'default1', 'default2', 2, NULL), (4, 11, 1, 1, 7, 11, 5, 2, 'default1', 'default2', 0, 1), (5, 14, 9, 4, 3, 7, 3, 2, 'default1', NULL, 1, 0), (6, 8, 0, 2, 9, 0, 3, 5, 'default1', NULL, NULL, NULL), (7, 14, NULL, 4, 5, 2, 5, 0, NULL, 'default2', NULL, 0), (8, 7, 0, 0, NULL, 7, 4, 7, 'default1', 'default2', 1, 2), (9, 12, 3, 0, 5, 10, 0, 3, NULL, 'default1', 1, NULL), (10, 3, 0, 4, 8, 12, 2, NULL, 'default2', 'default2', 2, 2), (11, 14, 7, 1, 1, NULL, 5, NULL, NULL, 'default2', 2, 1), (12, 2, 2, 3, 1, 8, 0, 7, 'default1', 'default1', NULL, 2), (13, 9, 4, 3, 0, 7, 1, 3, 'default2', NULL, 0, 2), (14, 12, 3, 2, 8, 7, 4, 5, 'default1', 'default2', NULL, NULL), (15, 9, 2, 1, 8, 1, 5, 4, 'default2', 'default1', NULL, 1), (16, 12, NULL, 1, 5, 9, 3, 2, NULL, 'default1', 1, 1), (17, 1, 7, 4, 0, 2, 5, 1, NULL, NULL, 1, 0), (18, 1, 5, 4, 3, NULL, NULL, 6, 'default2', NULL, 0, 1), (19, 11, 6, NULL, 8, 5, NULL, 4, NULL, NULL, 1, NULL), (20, 8, 3, NULL, 6, 0, 2, 5, 'default1', NULL, 0, 0), (21, 14, 6, NULL, 4, 11, 2, 7, 'default1', NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.colour FROM colour AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.eye_colour_id ORDER BY T2.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/