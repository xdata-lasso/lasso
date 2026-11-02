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
INSERT INTO race (id, race) VALUES (1, 'Durability'), (0, 'default1'), (2, NULL), (3, 'Durability'), (4, 'default2'), (5, 'Durability'), (6, 'default1'), (7, 'Dark Horse Comics'), (8, 'Durability'), (9, 'default1'), (10, 'Dark Horse Comics'), (11, 'default2'), (12, 'Dark Horse Comics'), (13, 'Durability'), (14, 'default1'), (15, 'default2'), (16, 'default2'), (17, 'default2'), (18, 'default2'), (19, 'default2'), (20, 'Durability'), (21, 'default1'), (22, 'default1'), (23, NULL), (24, NULL), (25, 'default1'), (26, 'Dark Horse Comics'), (27, 'Durability');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'default1'), (2, NULL), (0, 'Durability'), (3, 'Durability'), (4, 'Durability'), (5, 'default2'), (6, 'default2'), (7, NULL), (8, 'default2'), (9, 'default2'), (10, 'Dark Horse Comics'), (11, 'default1'), (12, 'Dark Horse Comics'), (13, 'Durability'), (14, 'Dark Horse Comics'), (15, 'Durability'), (16, 'default2'), (17, 'Dark Horse Comics'), (18, 'default2'), (19, 'Durability'), (20, NULL), (21, 'default1'), (22, 'default2'), (23, 'default2'), (24, NULL), (25, 'Durability'), (26, 'Dark Horse Comics'), (27, 'default1'), (28, 'default1'), (29, 'default1'), (30, 'Durability'), (31, 'Durability'), (32, 'Dark Horse Comics');
INSERT INTO gender (id, gender) VALUES (1, NULL);
INSERT INTO colour (id, colour) VALUES (1, NULL), (0, NULL), (2, 'default1'), (3, 'Durability'), (4, 'Dark Horse Comics'), (5, 'default2'), (6, 'Durability'), (7, NULL), (8, NULL), (9, NULL), (10, 'default2'), (11, 'Dark Horse Comics'), (12, 'Durability'), (13, 'Durability'), (14, 'Dark Horse Comics'), (15, 'Durability'), (16, 'Dark Horse Comics'), (17, NULL), (18, 'default2'), (19, 'Durability'), (20, 'Dark Horse Comics'), (21, 'Dark Horse Comics'), (22, 'default1'), (23, 'default1'), (24, 'default2'), (25, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (1, 'default1'), (2, 'Dark Horse Comics'), (0, NULL), (3, 'default1'), (4, 'Dark Horse Comics'), (5, NULL), (6, 'Durability'), (7, 'Durability'), (8, 'Dark Horse Comics'), (9, NULL), (10, 'default1'), (11, 'default2'), (12, NULL), (13, NULL), (14, 'default1');
INSERT INTO alignment (id, alignment) VALUES (1, 'Durability'), (2, 'default2'), (0, 'default2'), (3, NULL), (4, NULL), (5, NULL), (6, 'default2'), (7, 'Durability'), (8, 'Dark Horse Comics'), (9, 'Dark Horse Comics'), (10, 'default1'), (11, 'default2'), (12, 'default1'), (13, 'Dark Horse Comics'), (14, 'default1'), (15, NULL), (16, 'Durability'), (17, 'default2'), (18, 'default2'), (19, 'default1'), (20, 'Durability'), (21, 'default2'), (22, NULL), (23, 'default2'), (24, 'Durability'), (25, 'default1'), (26, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 22, 20, 1, 23, NULL, 27, 9, 'default2', 'default1', NULL, NULL), (1, 7, 1, NULL, NULL, 24, 24, 15, 'Durability', 'default1', NULL, 0), (0, 26, 22, NULL, 20, 15, 4, 21, 'default1', NULL, 2, 1), (3, NULL, 16, 1, 6, 31, 6, 7, 'default2', 'Dark Horse Comics', NULL, 1), (4, 22, 24, 1, 24, 17, 13, 17, 'default1', NULL, 2, 0), (5, 5, 14, 1, 3, 1, 12, 15, 'Durability', 'Durability', 0, 2), (6, 21, 23, NULL, 23, 12, 18, 15, NULL, 'Dark Horse Comics', 2, NULL), (7, 12, 23, NULL, 3, 26, 9, 12, 'default1', NULL, NULL, 1), (8, 0, 21, NULL, 2, 11, 18, 24, 'Dark Horse Comics', 'default1', 2, 0), (9, 11, 18, NULL, 13, 22, 27, 0, 'Durability', 'default2', 2, 0), (10, 15, 21, NULL, 13, 22, 11, 0, 'Dark Horse Comics', 'default2', 1, 2), (11, 25, 3, 1, 18, 15, 16, 2, 'default2', NULL, NULL, 2), (12, 17, 11, 1, 2, 20, 9, 21, 'Durability', NULL, 1, NULL), (13, 7, 5, 1, 2, 19, 8, 1, 'Durability', 'default1', 0, 0), (14, 19, 20, NULL, 19, 31, 11, 17, 'Dark Horse Comics', 'default2', 2, 1), (15, 23, 8, NULL, 8, 26, 5, 23, NULL, 'default1', 2, 0), (16, 16, 5, NULL, 18, 0, 18, 13, 'Durability', 'Dark Horse Comics', 0, 2), (17, 20, 24, NULL, 3, 5, 26, 19, 'Durability', 'Durability', 1, 0), (18, 10, 15, NULL, 13, 10, 25, 4, 'default2', 'Dark Horse Comics', 2, 0), (19, 10, 5, 1, 23, 6, 21, 1, 'default1', 'Durability', 1, 0), (20, 20, 16, NULL, 22, 6, 7, 18, 'Durability', 'Durability', NULL, 1), (21, 19, 13, 1, 12, 16, 19, 12, 'Durability', 'default2', 0, NULL), (22, 2, 16, NULL, 24, 30, 19, 9, NULL, NULL, 2, 0), (23, 14, 6, 1, 0, 18, 11, 24, 'Dark Horse Comics', 'Dark Horse Comics', 1, 2), (24, NULL, 15, NULL, 25, 26, 8, 19, 'default1', 'default1', 1, 1), (25, 0, 5, 1, 10, 30, 5, 16, 'Dark Horse Comics', 'Dark Horse Comics', 0, 2), (26, 23, 13, 1, 7, 14, 10, 10, 'default1', NULL, 2, NULL), (27, 4, 9, NULL, 15, 24, 20, NULL, 'Dark Horse Comics', 'default2', 1, 2);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (0, 1, NULL), (3, 19, NULL), (13, 23, 2), (6, 7, NULL), (3, 17, 0), (6, 20, 2), (4, 19, 2), (13, 10, NULL), (4, 11, 1), (0, 18, 2), (0, 3, NULL), (10, 22, 1), (2, 23, NULL), (7, 22, 1), (13, 4, NULL), (0, 19, 1), (11, 17, 2), (12, 22, NULL), (4, 17, NULL), (0, 5, NULL), (8, 21, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN publisher AS p ON s.publisher_id = p.id INNER JOIN hero_attribute AS ha ON s.id = ha.hero_id INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Durability' AND p.publisher_name = 'Dark Horse Comics' AND ha.attribute_value = (SELECT MAX(ha2.attribute_value) FROM superhero AS s2 INNER JOIN hero_attribute AS ha2 ON s2.id = ha2.hero_id INNER JOIN attribute AS a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'Durability' AND s2.publisher_id = p.id);

/*
Prediction Result:
*/