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
INSERT INTO superpower (id, power_name) VALUES (1, 'default1'), (0, 'Deathlok'), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'Deathlok'), (6, 'default2'), (7, NULL), (8, 'Deathlok'), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'Deathlok'), (13, NULL), (14, 'Deathlok'), (15, 'Deathlok'), (16, 'default2');
INSERT INTO race (id, race) VALUES (0, 'Deathlok'), (1, NULL), (2, 'Deathlok'), (3, 'default1'), (4, 'Deathlok'), (5, 'default2'), (6, 'Deathlok'), (7, 'Deathlok'), (8, 'Deathlok'), (9, NULL), (10, NULL), (11, 'Deathlok'), (12, NULL), (13, 'Deathlok'), (14, NULL), (15, 'default2'), (16, 'default1'), (17, 'Deathlok'), (18, NULL);
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (1, 'default2'), (2, 'default1'), (3, 'default1'), (4, 'Deathlok'), (5, NULL), (6, 'default1'), (7, 'Deathlok'), (8, 'default1'), (9, 'default1'), (10, 'default2');
INSERT INTO gender (id, gender) VALUES (1, NULL), (0, NULL), (2, 'default2'), (3, 'default1'), (4, NULL), (5, 'Deathlok'), (6, NULL), (7, 'Deathlok'), (8, NULL), (9, 'Deathlok'), (10, 'default1'), (11, 'default1'), (12, 'default1'), (13, 'default1');
INSERT INTO colour (id, colour) VALUES (1, 'Deathlok'), (0, 'Deathlok'), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, NULL), (6, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, NULL), (0, 'default2'), (2, NULL), (3, NULL), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, 'Deathlok'), (12, 'Deathlok');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 5, 4, 1, 6, 3, 5, NULL, NULL, 'default1', NULL, 0), (0, 7, 1, 13, 1, 7, 14, 3, 'default1', 'default2', NULL, NULL), (2, 1, 1, 8, NULL, 7, 7, 0, 'default2', 'default1', 0, 0), (3, 1, 4, 1, 1, 2, NULL, 6, 'default2', 'Deathlok', NULL, NULL), (4, 12, NULL, 8, 0, 8, 0, 1, 'default1', 'default2', 0, NULL), (5, 7, NULL, 13, 6, 9, 9, 3, 'Deathlok', 'default1', 1, NULL), (6, 4, 2, 8, 0, NULL, 6, NULL, NULL, 'Deathlok', 0, NULL), (7, 2, 2, 3, 5, 10, 16, 6, NULL, 'default1', NULL, 1), (8, 11, 6, 3, NULL, 7, NULL, 6, NULL, NULL, 0, 1), (9, 9, 3, 13, 2, 7, 10, 3, 'default1', 'Deathlok', 1, 0), (10, 2, 6, 4, 5, 3, NULL, NULL, 'default1', 'default2', 1, 1), (11, 9, 4, 8, 4, 6, 15, 2, 'Deathlok', 'default2', 1, 0), (12, NULL, 2, 11, 5, 4, 8, 3, 'default2', 'default1', NULL, 0), (13, 2, 6, 8, 3, 10, 5, 0, 'default1', 'Deathlok', NULL, 1), (14, 2, NULL, 0, 5, 7, 5, 3, 'Deathlok', 'default2', NULL, 0), (15, 5, NULL, 9, 0, 1, 16, 2, 'default2', 'default1', 1, 1), (16, NULL, 2, NULL, 1, 1, 18, 2, NULL, 'Deathlok', 1, 0), (17, 5, 5, 10, 0, 2, 8, 4, 'Deathlok', 'default2', NULL, NULL), (18, 6, 2, 12, 6, 5, 1, 1, 'default2', NULL, 0, NULL), (19, 2, 5, 13, NULL, 8, 15, NULL, 'Deathlok', 'default2', NULL, NULL), (20, 5, 4, 4, NULL, NULL, NULL, NULL, 'Deathlok', NULL, 0, NULL), (21, 9, 1, 2, 4, 7, 16, 2, 'default2', 'default1', 0, NULL);
INSERT INTO hero_power (hero_id, power_id) VALUES (4, 0), (9, 8), (NULL, 7), (15, 2), (16, 5), (9, 13), (16, 6), (19, 14), (17, 3), (9, 3), (19, 13), (10, 2), (13, 4), (17, 1), (5, 6), (0, 6), (21, 15), (5, 15), (17, 3), (8, 3), (5, 12), (3, 0), (2, 4), (8, 8), (NULL, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.superhero_name = 'Deathlok';

/*
Gold Result:
('Deathlok',)
('default2',)
(None,)
('default1',)
('default2',)
('Deathlok',)
('default2',)
('Deathlok',)
*/

-- Prediction Query
SELECT DISTINCT "superpower"."power_name" FROM "superhero" INNER JOIN "hero_power" ON "superhero"."id" = "hero_power"."hero_id" INNER JOIN "superpower" ON "hero_power"."power_id" = "superpower"."id" WHERE "superhero"."superhero_name" = 'Deathlok';

/*
Prediction Result:
('Deathlok',)
('default2',)
(None,)
('default1',)
*/