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
INSERT INTO superpower (id, power_name) VALUES (1, 'default1'), (14, 'default2'), (15, 'default1'), (0, 'default1'), (16, 'default1'), (2, 'default2'), (3, 'default1'), (4, NULL), (5, NULL), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, NULL), (10, 'default2'), (11, NULL), (12, NULL), (13, 'default2');
INSERT INTO race (id, race) VALUES (1, 'default2'), (0, 'default2'), (16, NULL), (15, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (14, NULL), (16, NULL), (0, NULL), (1, NULL), (15, 'default1'), (2, NULL), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, NULL), (13, NULL), (17, 'default2'), (18, NULL), (19, 'default2'), (20, NULL);
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (14, NULL), (15, 'default2'), (0, 'default2'), (16, 'default1'), (2, 'default1'), (3, 'default2'), (4, NULL), (5, NULL), (6, NULL), (7, 'default2'), (8, 'default2'), (9, 'default1');
INSERT INTO colour (id, colour) VALUES (14, 'default1'), (15, 'default1'), (1, 'default2'), (16, 'default2'), (0, 'default2'), (2, 'default2'), (3, 'default1'), (4, NULL), (5, NULL), (6, NULL), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, NULL), (11, 'default1'), (12, 'default2'), (13, 'default2'), (17, 'default2'), (18, NULL), (19, 'default1'), (20, 'default2'), (21, 'default1'), (22, 'default1'), (23, 'default1'), (24, NULL), (25, 'default2'), (26, NULL), (27, 'default1'), (28, 'default2'), (29, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, 'default2'), (16, 'default2'), (15, 'default2'), (14, 'default2'), (2, NULL), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default2'), (8, NULL), (9, 'default2'), (10, NULL), (11, 'default1'), (12, 'default1'), (13, 'default1'), (17, 'default1'), (18, 'default1'), (19, NULL), (20, NULL), (21, NULL), (22, NULL), (23, 'default2'), (24, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (14, 6, 15, 2, 26, 11, 1, 1, 'default2', NULL, 16, NULL), (16, 0, 19, 16, 9, 8, 0, 22, 'default1', NULL, 14, 16), (15, 24, 4, 8, 2, 11, 16, 4, 'default2', NULL, 0, 14), (0, 0, 28, 14, 25, 4, 1, 26, NULL, 'default2', 15, 15), (1, 17, 17, 8, 21, 0, NULL, 4, 'default2', NULL, 14, 16);
INSERT INTO hero_power (hero_id, power_id) VALUES (14, 4), (14, 4), (NULL, 2), (15, 1), (15, 2), (0, 9), (0, 5), (14, 6), (NULL, 7), (16, NULL), (16, 1), (1, 3), (1, 1), (0, 6), (1, 15), (14, 16), (14, 8), (15, 7), (NULL, 12), (0, 5), (16, 4), (0, 9), (16, 8), (0, 16), (16, 8), (0, 9), (0, 1), (14, 3), (15, 9), (NULL, 9), (15, 1), (16, NULL), (14, 13), (1, 3), (0, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T2.power_id) > 15;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT s.full_name FROM superhero AS s JOIN hero_power AS hp ON s.id = hp.hero_id GROUP BY s.id HAVING COUNT(hp.power_id) > 15;

/*
Prediction Result:
*/