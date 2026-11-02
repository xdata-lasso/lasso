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
INSERT INTO race (id, race) VALUES (0, 'default1'), (2, 'default1'), (1, NULL), (3, 'default1'), (4, NULL), (5, 'Black Panther'), (6, 'Black Panther'), (7, 'Black Panther'), (8, NULL), (9, 'Black Panther'), (10, 'default1'), (11, 'default2'), (12, 'default2'), (13, 'Black Panther'), (14, NULL), (15, 'Black Panther');
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (2, 'default2'), (1, 'default1'), (3, 'default1'), (4, 'default1');
INSERT INTO gender (id, gender) VALUES (1, NULL), (2, NULL), (0, 'default2'), (3, NULL), (4, 'Black Panther'), (5, 'default1');
INSERT INTO colour (id, colour) VALUES (2, 'default2'), (0, 'default2'), (1, NULL), (3, 'default2'), (4, 'Black Panther'), (5, 'Black Panther'), (6, 'default2'), (7, 'Black Panther'), (8, 'Black Panther'), (9, 'Black Panther');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Black Panther'), (0, 'default1'), (1, 'default2'), (3, 'default1'), (4, NULL), (5, 'default1'), (6, NULL), (7, NULL), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, 'default2'), (12, 'default2'), (13, 'default1'), (14, 'default2'), (15, 'default1'), (16, 'Black Panther'), (17, 'Black Panther'), (18, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'Black Panther');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, NULL, 4, NULL, 4, 3, 15, 7, 'Black Panther', NULL, 1, NULL), (1, NULL, 9, 2, NULL, 4, NULL, 3, 'default2', 'default2', 2, 1), (2, 0, 7, NULL, 8, 4, 7, 5, 'default2', 'Black Panther', 0, 1), (3, NULL, 7, 1, 5, 0, 8, 6, 'Black Panther', 'default2', 0, 2), (4, NULL, 1, 4, 0, 2, 13, 2, 'Black Panther', 'default2', 0, 1), (5, NULL, 8, 0, NULL, 2, 12, 6, 'Black Panther', 'default1', 1, NULL), (6, 0, NULL, NULL, 4, 4, 5, 4, 'Black Panther', 'default2', NULL, NULL), (7, 0, NULL, 1, 0, NULL, 10, 1, 'default1', 'default2', 2, 2), (8, 0, 8, 4, 9, 0, NULL, 3, 'default2', NULL, 1, 0), (9, 0, 6, NULL, 0, NULL, 11, 2, 'default1', 'Black Panther', 2, 0), (10, NULL, 4, 0, 2, 2, 6, 4, 'Black Panther', 'Black Panther', 2, 1), (11, 0, 3, 0, 5, 0, 3, 7, 'default1', 'default1', 1, NULL), (12, NULL, 9, 2, 1, 4, 1, 8, 'Black Panther', 'default1', 1, 1), (13, NULL, 4, 0, 2, 0, 1, 5, NULL, NULL, 1, 2), (14, NULL, 0, 1, 6, 2, 9, 8, 'Black Panther', NULL, 2, 0), (15, 0, 6, 5, 7, 2, 15, 2, 'default1', 'default2', 0, NULL), (16, NULL, 1, 5, 5, 1, 5, 9, 'default2', 'default2', 0, 2), (17, NULL, 5, 2, 5, 2, 9, 6, 'default1', 'Black Panther', 0, NULL), (18, 0, 8, 0, 5, 3, 14, 2, 'Black Panther', 'default1', 0, 0), (19, 0, 4, NULL, 4, NULL, 10, 2, 'Black Panther', NULL, 0, 2), (20, 0, 2, 4, 6, NULL, 10, 2, NULL, 'default2', 0, NULL), (21, 0, 9, 1, NULL, 3, 11, 4, 'Black Panther', NULL, 1, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (5, 10, NULL), (10, 7, 1), (6, 2, 2), (12, 9, 1), (0, 17, 2), (0, 9, NULL), (17, 7, NULL), (1, 7, 1), (2, 5, 0), (7, 0, 0), (6, 13, 1), (11, 1, 1), (4, 1, NULL), (16, 10, 1), (13, 2, 0), (NULL, 8, 0), (15, 17, 0), (14, 15, 1), (5, 4, NULL), (14, 20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT a.attribute_name FROM hero_attribute AS ha INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE ha.hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Black Panther') ORDER BY ha.attribute_value ASC, ha.hero_id NULLS LAST, ha.attribute_id NULLS LAST, a.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/