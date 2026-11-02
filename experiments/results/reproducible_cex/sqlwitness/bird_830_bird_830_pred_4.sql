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
INSERT INTO race (id, race) VALUES (0, NULL), (2, 'default1'), (1, 'default2'), (3, 'Black Panther'), (4, 'default1'), (5, NULL), (6, 'default1'), (7, NULL), (8, NULL), (9, 'default2'), (10, NULL), (11, 'Black Panther'), (12, 'Black Panther'), (13, 'default1'), (14, NULL), (15, 'default2'), (16, 'default2'), (17, 'default1'), (18, 'Black Panther'), (19, 'default2'), (20, 'default1'), (21, 'default1'), (22, NULL), (23, NULL), (24, 'default1'), (25, 'default1'), (26, 'Black Panther'), (27, NULL), (28, NULL), (29, 'Black Panther'), (30, 'Black Panther'), (31, 'default2'), (32, 'Black Panther');
INSERT INTO publisher (id, publisher_name) VALUES (1, NULL), (0, 'default1'), (2, NULL), (3, 'default2'), (4, 'default1'), (5, 'Black Panther'), (6, 'Black Panther'), (7, 'default1'), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, 'default2'), (13, 'default1'), (14, NULL), (15, NULL), (16, NULL), (17, 'Black Panther');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (0, NULL);
INSERT INTO colour (id, colour) VALUES (2, NULL), (1, NULL), (0, 'default1'), (3, NULL), (4, 'default2'), (5, NULL), (6, 'Black Panther'), (7, 'default2'), (8, 'Black Panther'), (9, 'default1'), (10, 'default1'), (11, 'Black Panther'), (12, 'default2'), (13, 'default1'), (14, NULL), (15, 'default2'), (16, 'default2'), (17, 'default1'), (18, 'default1'), (19, NULL), (20, 'Black Panther'), (21, NULL), (22, 'Black Panther'), (23, 'Black Panther'), (24, NULL), (25, 'Black Panther');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'default2'), (1, 'default1'), (0, 'default2'), (3, 'Black Panther'), (4, 'Black Panther'), (5, NULL), (6, NULL), (7, 'default2'), (8, NULL), (9, 'Black Panther'), (10, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, NULL, 22, 2, 4, 4, 7, 0, 'Black Panther', 'default2', 0, 2), (1, NULL, 17, 0, 14, 5, 8, 25, 'Black Panther', 'default2', 2, 1), (0, NULL, 17, NULL, NULL, 3, 17, 9, 'default1', 'default2', 2, 2), (3, NULL, 23, NULL, NULL, NULL, 20, 3, NULL, NULL, 1, NULL), (4, NULL, 3, NULL, 11, 1, 29, 15, NULL, 'default2', NULL, 2), (5, NULL, 16, 2, 0, 14, 24, 1, 'Black Panther', 'Black Panther', 1, 0), (6, NULL, 12, 2, 4, 13, 29, 22, NULL, 'default2', 0, NULL), (7, NULL, 10, 0, 11, 9, 26, 3, 'default2', 'default2', 2, 1), (8, NULL, 15, 2, 8, 11, NULL, 19, NULL, 'default2', 2, NULL), (9, NULL, 23, 2, 0, 8, 4, 2, 'default1', 'Black Panther', 2, NULL), (10, NULL, 1, NULL, 19, 3, 31, 8, 'Black Panther', NULL, 1, NULL), (11, NULL, 16, 2, 10, 10, 6, 12, 'Black Panther', 'default1', 1, 2), (12, NULL, 20, NULL, 9, 17, 0, 22, 'Black Panther', 'default1', 0, NULL);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (NULL, 3, 1), (3, 10, 2), (NULL, 12, 2), (0, NULL, 0), (6, 2, NULL), (NULL, 3, 1), (2, 12, 0), (7, 5, NULL), (5, 10, 1), (2, 12, NULL), (7, 6, 1), (0, 11, 0), (1, 0, NULL), (7, 3, 1), (6, 7, 0), (1, 5, NULL), (10, 1, 2), (7, 11, NULL), (1, 10, 1), (0, 4, 2), (0, 0, 0), (9, 12, 0), (8, 4, 1), (6, 3, 2), (7, 2, NULL), (0, 5, 2), (6, 5, 1), (10, 9, 0), (6, 1, NULL), (9, 3, 1), (10, 3, 2), (3, 5, 1), (7, 10, 1), (6, 2, NULL), (4, 9, 1), (9, 0, NULL), (3, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.attribute_name FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id INNER JOIN superhero AS T3 ON T2.hero_id = T3.id WHERE T3.superhero_name = 'Black Panther' ORDER BY T2.attribute_value, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/