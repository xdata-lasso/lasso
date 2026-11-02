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
INSERT INTO race (id, race) VALUES (1, NULL), (0, 'default2'), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (2, NULL), (0, 'default2'), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'Black Panther'), (9, 'default2'), (10, 'default1'), (11, 'Black Panther'), (12, 'default1'), (13, 'Black Panther'), (14, NULL), (15, 'Black Panther'), (16, 'default2'), (17, NULL), (18, 'default1');
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, 'default2'), (2, 'Black Panther'), (3, 'default1'), (4, 'default2'), (5, 'default1');
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (2, 'default2'), (0, 'default1'), (3, NULL), (4, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (0, 'default1'), (2, 'default2'), (1, 'default1'), (3, 'default2'), (4, 'default2'), (5, 'Black Panther'), (6, 'Black Panther'), (7, 'default1'), (8, NULL), (9, 'Black Panther'), (10, NULL), (11, 'default2'), (12, 'default1'), (13, 'default2'), (14, 'Black Panther'), (15, 'Black Panther'), (16, 'default1'), (17, 'Black Panther'), (18, NULL), (19, 'Black Panther'), (20, 'default2'), (21, 'Black Panther'), (22, 'default1'), (23, 'Black Panther'), (24, 'Black Panther'), (25, 'default1'), (26, 'default1'), (27, NULL), (28, 'default2'), (29, 'Black Panther'), (30, 'default2'), (31, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, 'default1'), (2, 'Black Panther'), (0, NULL), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'default1'), (8, NULL), (9, NULL), (10, 'Black Panther');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 5, 4, 3, NULL, 0, 2, 0, 'Black Panther', NULL, NULL, 0), (1, 6, 1, 0, 2, 4, 5, 0, 'Black Panther', 'Black Panther', NULL, 2), (0, 3, 0, 0, 3, 2, 3, NULL, 'default1', 'Black Panther', 2, 0), (3, 6, 2, 4, 2, 17, NULL, 3, 'default1', NULL, NULL, 0), (4, NULL, 3, 4, 0, 12, 1, 1, 'Black Panther', 'default1', 2, 0), (5, 8, 3, 1, 1, 3, 1, 3, 'Black Panther', 'Black Panther', NULL, 2), (6, 0, 4, 5, 1, 0, 0, 2, 'default2', 'default1', 0, 1), (7, 1, NULL, 4, NULL, 2, 0, 3, 'default2', 'default1', 2, 1), (8, 9, 4, 5, 4, 14, 3, 4, 'Black Panther', NULL, 1, NULL), (9, 10, 4, 3, 1, 3, 5, 1, 'default2', 'default1', 1, 2), (10, 7, NULL, NULL, 3, 18, NULL, 1, 'default2', 'default2', 0, 1), (11, 0, 3, 3, 4, 0, 2, 3, 'default1', 'default1', 0, 2), (12, 5, 2, 3, 4, 1, 4, 4, 'default2', 'default1', 2, 2), (13, 0, NULL, 3, 1, 3, 0, NULL, 'Black Panther', NULL, 1, 1), (14, 4, 1, 2, 4, 5, NULL, 4, NULL, NULL, 0, 2), (15, 5, 2, NULL, 4, 11, 3, 4, 'default1', 'Black Panther', 1, 2), (16, 5, 4, 2, 4, 14, NULL, 1, 'Black Panther', 'default2', 0, NULL), (17, 3, NULL, 1, 2, 15, 4, NULL, 'default1', 'Black Panther', 0, 0), (18, 9, 2, 0, 1, 3, 3, 3, 'default1', 'default1', 0, 1), (19, 2, 4, 2, NULL, 12, 4, NULL, 'default2', NULL, 0, 1), (20, 7, NULL, 4, 4, 18, 5, 2, NULL, 'default1', NULL, 1), (21, 0, 4, 4, 2, 18, 3, 1, 'Black Panther', NULL, 2, 2), (22, 9, 0, 1, 1, 0, 1, 2, 'Black Panther', 'Black Panther', 2, 1), (23, 8, 1, 0, 0, 11, NULL, 3, NULL, 'default1', 0, 2);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (26, 11, NULL), (0, 21, NULL), (14, 11, NULL), (7, 19, NULL), (16, 18, 0), (7, 13, 2), (26, 13, 2), (26, 11, NULL), (2, 15, 1), (15, 21, 0), (28, 14, NULL), (10, 0, 0), (9, 14, NULL), (0, 9, 0), (9, 1, 0), (22, 12, 1), (11, 7, 1), (15, 15, 2), (31, 6, 1), (18, 10, NULL), (5, 13, NULL), (13, 5, 1), (23, 10, NULL), (22, NULL, 0), (27, 8, 1), (10, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Black Panther',)
*/

-- Prediction Query
SELECT a.attribute_name FROM attribute AS a JOIN hero_attribute AS ha ON a.id = ha.attribute_id JOIN superhero AS s ON ha.hero_id = s.id WHERE s.superhero_name = 'Black Panther' ORDER BY ha.attribute_value ASC, a.id NULLS LAST, ha.hero_id NULLS LAST, ha.attribute_id NULLS LAST, s.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/