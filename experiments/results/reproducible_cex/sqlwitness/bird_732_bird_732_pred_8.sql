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
INSERT INTO race (id, race) VALUES (0, 'default2'), (2, NULL), (1, NULL), (3, NULL), (4, NULL), (5, 'default2'), (6, 'default1'), (7, 'Speed'), (8, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'default1'), (0, NULL), (1, NULL), (3, 'default2'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'Speed'), (8, 'default1'), (9, 'Speed'), (10, 'default1'), (11, NULL), (12, NULL), (13, 'default2'), (14, 'default2'), (15, NULL), (16, 'default1'), (17, 'default1'), (18, 'default2'), (19, 'default1'), (20, 'Speed');
INSERT INTO gender (id, gender) VALUES (1, 'Speed'), (2, 'default1'), (0, 'default2'), (3, 'default2'), (4, 'Speed'), (5, NULL), (6, 'default1'), (7, 'Speed'), (8, 'default1'), (9, 'default2'), (10, NULL), (11, NULL), (12, 'default2'), (13, 'default1'), (14, 'Speed'), (15, 'default1'), (16, NULL), (17, NULL), (18, NULL), (19, 'default1'), (20, 'default2'), (21, 'default2'), (22, 'default2'), (23, NULL), (24, 'default1'), (25, NULL), (26, 'Speed'), (27, 'default2'), (28, 'default2'), (29, 'default2'), (30, NULL), (31, 'Speed'), (32, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'Speed'), (1, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (2, 'default1'), (1, 'Speed'), (0, 'Speed');
INSERT INTO alignment (id, alignment) VALUES (1, 'Speed'), (2, NULL), (0, 'default1'), (3, 'Speed'), (4, 'Speed'), (5, 'Speed'), (6, NULL), (7, 'default1'), (8, 'Speed'), (9, NULL), (10, NULL), (11, 'default1'), (12, 'default2'), (13, 'default2'), (14, 'Speed'), (15, 'default1'), (16, 'default2'), (17, NULL), (18, NULL), (19, 'default2'), (20, 'default2'), (21, 'Speed'), (22, 'default2'), (23, NULL), (24, 'default2'), (25, 'Speed'), (26, NULL), (27, 'default1'), (28, NULL), (29, 'default2'), (30, NULL), (31, 'Speed'), (32, 'default1'), (33, 'default1'), (34, NULL), (35, 'default2'), (36, 'default1'), (37, 'Speed');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 28, 1, 1, 1, NULL, 1, 1, 'default1', 'default2', 0, NULL), (1, 0, 1, 17, 0, 20, 5, 1, 'Speed', NULL, 2, 1), (2, 29, NULL, 19, NULL, 19, 1, 1, 'default1', 'Speed', NULL, 1), (3, NULL, 0, 13, 0, 13, NULL, 1, 'default2', 'default2', 2, 1), (4, 6, 1, 22, NULL, 20, 7, 1, 'default1', NULL, NULL, 1), (5, 17, 0, 11, NULL, 15, 0, 1, 'Speed', 'default1', 2, 2), (6, 32, 0, 5, NULL, 9, 1, 1, 'Speed', 'default1', NULL, 1), (7, 5, 0, 26, 1, 10, 2, 1, 'default2', NULL, NULL, NULL), (8, 17, NULL, 23, 0, NULL, NULL, NULL, 'default2', 'default1', NULL, 2), (9, 31, NULL, 31, 0, 18, 5, 0, NULL, NULL, NULL, NULL), (10, 6, NULL, 10, 1, 16, 2, NULL, 'default2', 'default1', NULL, 1), (11, 24, NULL, 6, NULL, 8, 3, NULL, 'default2', 'default1', 1, 0), (12, 19, 1, 20, 1, 1, 5, 0, 'default2', 'default1', 1, 0), (13, 26, 1, 31, 0, 15, 0, 1, NULL, NULL, NULL, 0), (14, 32, 1, 26, 1, 4, 4, 1, 'default1', 'default2', NULL, NULL), (15, 5, NULL, 22, 0, 16, 4, NULL, 'Speed', 'default1', 2, NULL), (16, 3, 1, 29, NULL, 9, 6, 1, 'Speed', 'default2', 2, 2), (17, 14, 1, 10, 0, 1, NULL, 1, 'default2', NULL, 2, 0), (18, 31, 1, 32, 0, 19, 1, 0, NULL, NULL, 2, 1), (19, 15, NULL, 26, 1, 12, 7, 0, 'default2', 'Speed', 2, 0), (20, 20, 0, 3, 1, 4, 3, 0, 'default1', 'default1', 1, 1), (21, 21, 0, 12, 0, 5, 6, NULL, NULL, 'Speed', 0, 1), (22, 32, 1, 22, 1, 3, 7, 0, 'Speed', 'default2', NULL, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (0, 7, 2), (NULL, 19, 0), (1, 5, NULL), (0, 19, NULL), (1, 6, 0), (NULL, 19, 0), (0, 0, NULL), (0, 20, 2), (0, 22, 0), (NULL, 19, 1), (1, 13, 0), (2, 22, NULL), (1, 20, 0), (NULL, 15, 2), (NULL, 9, 0), (2, 18, 1), (0, 12, 1), (NULL, 6, 1), (1, 6, NULL), (0, 16, 2), (2, 20, NULL), (NULL, 21, 2), (2, 22, 0), (2, 9, NULL), (1, 15, 2), (1, 13, 2), (0, 12, 0), (NULL, 11, 0), (0, 1, 0), (1, 3, 1), (NULL, 16, 0), (0, 3, 0), (1, 1, 2), (NULL, 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id INNER JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Speed' ORDER BY T3.attribute_value, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.publisher_name FROM publisher AS T1 JOIN superhero AS T2 ON T1.id = T2.publisher_id JOIN hero_attribute AS T3 ON T2.id = T3.hero_id JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Speed' ORDER BY T3.attribute_value ASC, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Speed',)
*/