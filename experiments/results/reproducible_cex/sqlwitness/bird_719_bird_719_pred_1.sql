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
INSERT INTO superpower (id, power_name) VALUES (199, NULL), (0, 'default2'), (201, 'Super Strength'), (1, NULL), (200, 'default1'), (2, 'default1');
INSERT INTO race (id, race) VALUES (200, 'Super Strength');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default1'), (199, 'default2'), (1, 'default1'), (200, 'Super Strength'), (201, 'default2'), (2, 'Super Strength'), (3, 'default1'), (4, 'Super Strength'), (5, NULL), (6, 'default2'), (7, 'Super Strength'), (8, NULL), (9, 'Super Strength'), (10, 'default1'), (11, NULL), (12, 'Super Strength'), (13, 'default1'), (14, 'default1'), (15, 'default2'), (16, 'Super Strength'), (17, NULL);
INSERT INTO gender (id, gender) VALUES (200, 'default2'), (1, 'default2'), (201, NULL), (199, 'default2'), (0, 'default1'), (2, 'Super Strength'), (3, NULL), (4, 'Super Strength'), (5, 'default2'), (6, NULL), (7, 'Super Strength');
INSERT INTO colour (id, colour) VALUES (200, 'default2'), (201, NULL), (0, NULL), (1, NULL), (199, 'Super Strength'), (2, 'default1'), (3, 'Super Strength'), (4, 'default2'), (5, 'default2'), (6, NULL), (7, 'default1'), (8, 'default1'), (9, NULL), (10, 'default2'), (11, 'default2'), (12, 'Super Strength'), (13, 'default2'), (14, 'default1'), (15, 'default1'), (16, NULL), (17, 'Super Strength'), (18, 'default1'), (19, 'default1'), (20, 'Super Strength'), (21, 'Super Strength'), (22, 'default2'), (23, 'default1'), (24, 'Super Strength'), (25, NULL), (26, 'Super Strength'), (27, NULL), (28, 'Super Strength'), (29, 'Super Strength'), (30, 'default2'), (31, 'default1'), (32, 'Super Strength'), (33, NULL), (34, 'default1'), (35, NULL), (36, 'default2'), (37, NULL), (38, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'default2'), (199, 'default2'), (201, NULL), (1, 'default1'), (200, 'default1'), (2, 'Super Strength'), (3, 'default2'), (4, 'Super Strength'), (5, 'default1'), (6, 'default2'), (7, 'Super Strength'), (8, 'Super Strength'), (9, NULL), (10, NULL), (11, NULL), (12, 'default2'), (13, 'Super Strength'), (14, NULL), (15, 'default1'), (16, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 2, 18, 7, 20, 5, 200, 26, 'default2', 'default1', 201, NULL), (201, 12, 19, NULL, 32, 7, NULL, 20, 'default1', 'Super Strength', NULL, 0), (0, 1, 38, 4, 29, 0, NULL, 26, 'default1', NULL, 201, 199), (199, 9, 21, NULL, 29, 12, NULL, 18, 'Super Strength', 'default2', 200, 199), (200, 4, 13, 2, 16, 17, NULL, 13, 'Super Strength', 'Super Strength', NULL, 201), (2, 199, 1, 0, 5, 9, NULL, 15, 'default1', 'default1', 1, 201), (3, 199, 32, 4, 0, 199, 200, 3, 'default1', NULL, 200, 201), (4, NULL, 15, NULL, 27, 200, 200, 32, 'default2', 'Super Strength', 199, 200), (5, NULL, 29, NULL, 13, 14, NULL, 2, 'Super Strength', 'Super Strength', NULL, 0), (6, 16, 3, 4, 17, 5, NULL, 16, 'default2', NULL, 1, 201), (7, 14, 7, 2, 17, 9, 200, 2, 'default2', 'default2', 0, 1), (8, 199, 1, 200, 3, 1, NULL, 6, 'default1', 'default2', NULL, 1), (9, 10, NULL, 200, 5, 10, NULL, 13, 'default2', 'default2', 201, NULL), (10, NULL, 16, 2, 6, 6, NULL, 37, 'Super Strength', NULL, 201, 201), (11, 11, 12, 0, 21, 1, NULL, 24, 'default2', 'default1', 199, 201), (12, 15, 36, 200, 37, NULL, 200, 16, 'default2', 'default2', 201, 1), (13, 7, NULL, 3, 4, 1, 200, 33, NULL, 'default2', 201, 199), (14, 10, 36, 201, 29, 3, NULL, 34, NULL, 'default2', 200, 200), (15, NULL, 22, 1, 29, 5, 200, 3, 'default1', 'Super Strength', 1, NULL), (16, 15, NULL, 200, 9, 199, 200, 37, 'default2', 'default2', 0, 201), (17, 10, 34, 3, 19, 6, 200, 28, 'default1', 'Super Strength', NULL, 199), (18, 200, 23, 6, 33, 2, NULL, 28, 'Super Strength', NULL, 0, 200);
INSERT INTO hero_power (hero_id, power_id) VALUES (14, 1), (17, 1), (199, 201), (18, 1), (11, NULL), (199, 1), (15, 201), (201, 200), (16, 1), (8, 0), (1, 1), (12, 201), (0, 2), (12, 201), (4, 2), (14, 200), (5, 201), (9, 2), (8, NULL), (6, 2), (18, 200), (199, 2), (15, 1), (199, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T3.power_name = 'Super Strength' AND T1.height_cm > 200;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT hero_power.hero_id) AS tall_heroes_with_super_strength FROM superhero INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Super Strength' AND superhero.height_cm > 200;

/*
Prediction Result:
(1,)
*/