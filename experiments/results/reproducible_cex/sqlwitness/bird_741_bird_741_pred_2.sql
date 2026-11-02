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
INSERT INTO superpower (id, power_name) VALUES (2, 'default2'), (0, 'default1'), (1, NULL), (3, 'default2'), (4, 'default2'), (5, 'default2'), (6, NULL), (7, NULL), (8, NULL), (9, 'default2'), (10, NULL), (11, 'default1'), (12, 'default1'), (13, NULL), (14, 'default2'), (15, 'default2'), (16, 'default1'), (17, NULL), (18, NULL), (19, NULL), (20, 'default1'), (21, NULL), (22, 'default1');
INSERT INTO race (id, race) VALUES (1, 'default1'), (0, NULL), (2, 'default1'), (3, NULL), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'default2'), (8, NULL), (9, NULL), (10, NULL), (11, NULL), (12, 'default1'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, NULL), (17, NULL), (18, NULL), (19, NULL), (20, 'default2'), (21, NULL), (22, 'default1'), (23, 'default2'), (24, 'default2'), (25, 'default2'), (26, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'default2'), (1, NULL), (0, NULL), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, 'default1'), (10, NULL), (11, 'default2');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (0, 'default2'), (1, NULL), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, NULL), (11, 'default2');
INSERT INTO colour (id, colour) VALUES (2, NULL), (0, 'default2'), (1, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'default2'), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, 'default1'), (13, 'default2'), (14, 'default2'), (15, NULL), (16, 'default2'), (17, 'default2'), (18, 'default2'), (19, 'default1'), (20, NULL), (21, 'default2'), (22, 'default1'), (23, 'default1');
INSERT INTO alignment (id, alignment) VALUES (0, 'default1'), (2, 'default1'), (1, NULL), (3, 'default2'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'default2'), (8, NULL), (9, NULL), (10, 'default2'), (11, 'default1'), (12, 'default2'), (13, 'default1'), (14, 'default1'), (15, 'default2'), (16, 'default1'), (17, 'default1'), (18, NULL), (19, 'default2'), (20, 'default2'), (21, NULL), (22, 'default2'), (23, 'default1'), (24, 'default1'), (25, 'default1'), (26, NULL), (27, 'default1'), (28, 'default2'), (29, NULL), (30, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 18, 9, 5, 0, 6, 18, 13, 'default1', NULL, 1, NULL), (1, 0, 7, 4, 19, 9, 15, 17, NULL, NULL, 1, 0), (0, 23, 13, NULL, 11, 3, 23, 6, NULL, 'default2', 1, 1), (3, 7, 11, 0, 4, 0, 19, 7, 'default1', 'default2', 1, 0), (4, 12, 4, NULL, 4, 3, 15, 8, NULL, 'default1', 2, NULL), (5, 5, 15, NULL, 18, 7, 20, 22, NULL, 'default1', 2, NULL), (6, 23, 18, 11, 0, 5, 5, 21, 'default1', 'default2', 1, 0), (7, 25, 0, 10, 18, 11, 0, 10, 'default1', 'default1', 0, 1), (8, 9, 12, NULL, 1, 10, 24, 9, NULL, 'default1', 1, 2), (9, 16, NULL, 8, 20, NULL, 7, 9, 'default2', NULL, 0, 0), (10, 26, 13, 10, NULL, 8, 26, 6, 'default2', NULL, 2, 1), (11, 5, 20, 7, 6, 6, 8, 3, NULL, 'default2', 2, 1), (12, 4, 9, 6, 0, 6, 4, NULL, NULL, 'default2', 2, 2), (13, 25, 11, 8, 21, 9, 11, 4, 'default2', 'default1', NULL, 0), (14, 11, 3, 5, 6, 4, 15, 22, 'default2', NULL, 0, NULL), (15, 1, 13, 7, 7, 3, 12, 19, NULL, 'default2', NULL, 2), (16, 26, NULL, 8, 22, 0, 17, 6, 'default1', NULL, 0, NULL), (17, 10, 9, 3, 19, 2, 22, 5, 'default1', 'default2', NULL, 1), (18, 7, 3, 9, 21, 10, 23, 8, 'default1', 'default2', 0, 0), (19, 24, 8, 2, 22, 1, 1, 0, NULL, 'default1', NULL, 1), (20, 19, 5, NULL, 1, 0, 12, 8, 'default2', 'default2', 1, 2), (21, 21, 12, 11, 23, 3, 20, 0, NULL, 'default2', 2, NULL), (22, 26, 12, 6, 0, NULL, 14, 23, 'default2', 'default1', 1, 0), (23, 1, 3, 3, 13, 7, 0, 19, 'default2', NULL, 0, 0), (24, 28, 12, 5, 19, 4, 5, 3, NULL, NULL, 1, 2), (25, 21, NULL, 0, 23, 7, 7, 17, 'default2', 'default1', 0, 1), (26, 12, 22, 9, 12, 3, 1, 23, 'default1', 'default2', 0, 0), (27, 22, 20, 9, 17, 10, 1, 12, 'default2', NULL, 2, NULL), (28, 28, 21, 4, 19, 5, 11, 6, 'default1', NULL, NULL, NULL), (29, 20, 19, 8, 13, 5, 0, 10, 'default2', NULL, 0, 2), (30, 0, 6, 3, 20, 2, 12, 4, 'default1', NULL, 0, 1), (31, 5, 2, 5, 20, 10, 20, 6, 'default1', 'default1', 0, 0);
INSERT INTO hero_power (hero_id, power_id) VALUES (19, 3), (12, 18), (13, 2), (11, 14), (30, 7), (9, 11), (19, 22), (0, 22), (14, 0), (29, NULL), (10, 7), (0, 13), (10, 8), (18, 8), (20, 1), (18, 18), (13, 0), (1, 16), (1, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.superhero_name ORDER BY COUNT(T2.hero_id) DESC, T1.superhero_name NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT "superhero"."superhero_name" FROM "superhero" INNER JOIN "hero_power" ON "superhero"."id" = "hero_power"."hero_id" GROUP BY "superhero"."superhero_name" ORDER BY COUNT("hero_power"."power_id") DESC, "superhero"."superhero_name" NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/