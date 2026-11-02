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
INSERT INTO superpower (id, power_name) VALUES (0, 'default2'), (16, 'default2'), (1, NULL), (14, 'default1'), (15, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, 'default1'), (9, 'default2'), (10, NULL), (11, 'default2'), (12, NULL), (13, 'default1'), (17, NULL), (18, 'default2'), (19, NULL), (20, 'default1'), (21, NULL), (22, NULL), (23, NULL), (24, NULL), (25, 'default2'), (26, 'default2'), (27, NULL), (28, 'default2'), (29, 'default2'), (30, 'default2'), (31, 'default1'), (32, 'default1'), (33, NULL), (34, 'default1'), (35, NULL);
INSERT INTO race (id, race) VALUES (16, 'default1'), (15, NULL), (1, NULL), (0, 'default1'), (14, NULL), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, NULL), (9, 'default1'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, 'default2'), (17, NULL), (18, 'default1'), (19, 'default2'), (20, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (15, NULL), (14, 'default1'), (16, 'default2'), (1, 'default2'), (0, 'default2'), (2, 'default1'), (3, 'default1'), (4, 'default2');
INSERT INTO gender (id, gender) VALUES (16, 'default2');
INSERT INTO colour (id, colour) VALUES (15, 'default1'), (16, 'default2'), (0, NULL), (14, 'default1');
INSERT INTO alignment (id, alignment) VALUES (16, 'default2'), (0, 'default2'), (15, NULL), (1, 'default1'), (14, NULL), (2, 'default2'), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'default1'), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'default2'), (13, 'default2'), (17, 'default2'), (18, 'default1'), (19, NULL), (20, NULL), (21, 'default1'), (22, 'default2'), (23, 'default2'), (24, 'default1'), (25, 'default1'), (26, 'default1'), (27, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (16, 10, 16, 16, 15, 1, 16, 15, 'default1', 'default1', 15, 16), (14, 16, 0, 16, 0, 1, 5, 15, NULL, 'default2', 14, 16), (0, 10, 15, 16, 14, 2, 15, NULL, 'default1', 'default2', 0, 15), (1, 3, 14, 16, 16, 1, 2, 16, 'default2', 'default2', 15, NULL), (15, 8, 0, NULL, 0, 15, 4, 15, NULL, 'default2', 16, 15), (2, 13, 15, NULL, 0, 14, 4, 16, 'default1', 'default2', 14, 15), (3, 5, 14, NULL, 16, 16, 6, 14, 'default2', 'default1', 16, 0), (4, 15, 15, 16, NULL, 0, 9, NULL, 'default1', 'default2', 14, 15), (5, 9, 14, 16, 0, 16, 20, 15, NULL, NULL, 1, NULL), (6, 15, 0, 16, NULL, 14, 6, 15, 'default2', NULL, 0, 16), (7, 6, 0, 16, 15, 3, 12, 14, 'default1', NULL, NULL, 0), (8, 17, 15, 16, 15, 4, 7, 15, 'default1', 'default2', 14, 14), (9, 26, NULL, NULL, 15, 15, 3, NULL, 'default1', 'default1', 15, 14), (10, 16, 14, 16, 0, NULL, 16, 0, 'default2', 'default2', NULL, 1), (11, 5, 14, 16, 16, 4, 9, 15, 'default2', 'default2', 15, 15), (12, 3, 14, 16, 15, 3, 9, 14, NULL, 'default1', 14, NULL), (13, 20, NULL, NULL, 0, 2, 8, 15, 'default2', 'default1', 14, 15), (17, 10, 0, NULL, 15, 4, 17, 0, 'default2', NULL, 15, 15), (18, 11, 16, NULL, 0, NULL, 18, 0, NULL, 'default1', 15, 0), (19, 26, 15, 16, 16, NULL, 12, 16, 'default1', NULL, 0, 16), (20, 19, 14, 16, 15, 4, 9, 0, NULL, NULL, 0, 0), (21, 4, 16, 16, 0, 16, 9, 14, NULL, NULL, 1, 16);
INSERT INTO hero_power (hero_id, power_id) VALUES (3, 5), (4, 34), (14, 25), (5, NULL), (10, NULL), (12, 4), (11, 4), (10, 34), (5, 20), (0, 6), (9, 21), (6, 3), (NULL, 17), (0, 5), (12, 14), (3, 8), (8, 19), (9, 2), (5, 34), (19, 16), (13, 25), (NULL, 23), (19, 26), (15, 10), (8, 30), (10, NULL), (4, 34), (11, 1), (NULL, 10), (10, 9), (5, 13), (10, 17), (0, 23), (2, 2), (8, 1), (2, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.full_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.full_name HAVING COUNT(T2.power_id) > 15;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN (SELECT hero_id FROM hero_power GROUP BY hero_id HAVING COUNT(DISTINCT power_id) > 15) AS power_count ON superhero.id = power_count.hero_id;

/*
Prediction Result:
*/