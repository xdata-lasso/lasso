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
INSERT INTO race (id, race) VALUES (0, 'default1'), (2, 'default2'), (1, 'Black Panther'), (3, 'Black Panther'), (4, NULL), (5, NULL), (6, 'Black Panther'), (7, NULL), (8, 'Black Panther'), (9, 'Black Panther'), (10, NULL), (11, 'default1'), (12, NULL), (13, NULL), (14, 'Black Panther'), (15, 'Black Panther'), (16, 'Black Panther');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Black Panther'), (0, 'Black Panther'), (1, NULL), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'Black Panther'), (8, 'default2'), (9, NULL), (10, 'Black Panther'), (11, NULL), (12, NULL), (13, 'default1'), (14, 'default1'), (15, 'default2'), (16, 'default2'), (17, NULL), (18, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default1'), (2, 'Black Panther'), (0, 'Black Panther'), (3, 'Black Panther'), (4, 'default1'), (5, NULL), (6, 'Black Panther'), (7, 'default1'), (8, 'default2'), (9, NULL), (10, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (0, 'Black Panther'), (1, 'Black Panther'), (2, 'Black Panther'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, 'default2'), (11, 'default2'), (12, NULL), (13, 'default2'), (14, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, NULL), (2, 'default1'), (3, 'default1'), (4, 'default2'), (5, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 5, 8, NULL, 2, 2, 14, 2, 'default1', 'default2', 0, 0), (1, 3, NULL, NULL, NULL, 8, 2, 8, 'Black Panther', 'Black Panther', NULL, 1), (0, 3, 4, NULL, 0, 0, 12, 4, 'default2', 'default1', NULL, 0), (3, 5, 10, NULL, 5, NULL, 13, 4, NULL, 'default1', 1, 0), (4, 1, 0, NULL, 6, 6, 7, 3, NULL, 'default2', 1, 0), (5, 2, 9, NULL, 5, 16, 5, 8, 'Black Panther', 'default1', 0, 1), (6, 3, 10, NULL, 4, 14, 5, 7, 'Black Panther', 'Black Panther', 2, 0), (7, 5, 3, NULL, NULL, 17, 2, NULL, 'default2', 'Black Panther', 1, 1), (8, 0, 7, NULL, 10, 4, 15, 0, 'default1', 'default1', 2, NULL);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (7, 3, 0), (NULL, 0, 1), (7, 0, 1), (14, 0, 1), (0, 6, 2), (0, 0, 0), (11, 5, 2), (2, 2, 1), (5, 3, NULL), (7, 0, 2), (NULL, NULL, 0), (11, NULL, 2), (1, 4, NULL), (3, 0, NULL), (NULL, 1, 2), (1, 7, NULL), (9, 1, 2), (7, 2, 1), (8, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T1.attribute_name FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id INNER JOIN superhero AS T3 ON T2.hero_id = T3.id WHERE T3.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.attribute_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Black Panther',)
*/