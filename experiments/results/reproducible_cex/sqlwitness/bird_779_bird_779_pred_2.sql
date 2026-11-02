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
INSERT INTO superpower (id, power_name) VALUES (0, 'Amazo'), (1, 'default2'), (2, NULL), (3, 'default1'), (4, 'default2'), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'default2'), (9, 'default2'), (10, 'Amazo'), (11, 'default1'), (12, 'default2'), (13, NULL), (14, 'default1'), (15, 'default2');
INSERT INTO race (id, race) VALUES (1, 'Amazo'), (0, 'default2'), (2, 'default1'), (3, 'Amazo'), (4, 'default1'), (5, NULL), (6, 'default1'), (7, NULL), (8, 'Amazo'), (9, 'default2'), (10, 'Amazo'), (11, 'default1'), (12, 'default1'), (13, 'default2'), (14, 'Amazo'), (15, NULL), (16, 'default1'), (17, 'default1'), (18, 'Amazo'), (19, NULL), (20, 'Amazo');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'default1'), (1, 'Amazo'), (2, 'default1'), (3, 'Amazo'), (4, 'default2'), (5, 'default2'), (6, NULL), (7, 'default2'), (8, 'default1'), (9, 'default2'), (10, 'Amazo'), (11, 'Amazo'), (12, NULL), (13, 'Amazo'), (14, NULL), (15, NULL), (16, 'Amazo'), (17, 'default2'), (18, 'Amazo');
INSERT INTO gender (id, gender) VALUES (0, 'default1'), (1, 'default2'), (2, 'default2'), (3, NULL), (4, 'default1'), (5, NULL), (6, NULL), (7, 'default2'), (8, 'Amazo'), (9, 'default2'), (10, 'default2'), (11, 'default2'), (12, 'Amazo'), (13, 'default2'), (14, 'default1'), (15, 'default1'), (16, 'default1'), (17, NULL), (18, 'default1'), (19, NULL), (20, 'default1'), (21, 'default2'), (22, 'default2'), (23, 'default1'), (24, 'default2'), (25, NULL), (26, 'Amazo'), (27, 'Amazo'), (28, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (0, 'default2'), (2, 'default1'), (3, NULL);
INSERT INTO alignment (id, alignment) VALUES (0, NULL), (1, 'Amazo'), (2, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, NULL, 15, 2, 2, 18, 0, 'default2', 'default2', 0, 1), (1, 0, 2, NULL, 1, 9, 13, 2, 'Amazo', 'default2', NULL, 0), (2, 2, 3, 15, 1, 4, 2, NULL, 'default2', 'default1', NULL, 0);
INSERT INTO hero_power (hero_id, power_id) VALUES (0, 10), (0, NULL), (NULL, 14), (0, 6), (NULL, 1), (1, 11), (0, 0), (2, 2), (2, 13), (2, 6), (0, 12), (0, 6), (1, 15), (1, 8), (NULL, 3), (1, 15), (NULL, 12), (NULL, 5), (1, NULL), (2, 15), (1, 1), (0, 3), (2, 0), (0, 9), (NULL, 9), (NULL, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.power_id) FROM hero_power AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id WHERE T2.superhero_name = 'Amazo';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM "superhero" AS T1 INNER JOIN "hero_power" AS T2 ON T1."id" = T2."hero_id" WHERE T1."superhero_name" = 'Amazo';

/*
Prediction Result:
(6,)
*/