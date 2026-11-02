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
INSERT INTO race (id, race) VALUES (0, 'default1'), (1, 'Dark Horse Comics'), (2, 'Dark Horse Comics'), (3, 'default2'), (4, 'durability'), (5, 'Durability'), (6, 'Durability'), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, 'default2'), (11, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Dark Horse Comics'), (0, 'Dark Horse Comics'), (2, NULL), (3, 'Durability'), (4, 'durability'), (5, 'default2'), (6, 'Durability'), (7, 'Dark Horse Comics'), (8, 'Dark Horse Comics'), (9, 'Dark Horse Comics'), (10, 'durability'), (11, 'default1'), (12, 'durability'), (13, 'default1'), (14, 'durability'), (15, NULL), (16, 'default2'), (17, 'durability'), (18, NULL), (19, 'default2'), (20, 'default1'), (21, 'durability'), (22, 'default1');
INSERT INTO gender (id, gender) VALUES (1, 'default1'), (2, 'durability'), (0, 'default2'), (3, NULL), (4, 'durability'), (5, 'durability'), (6, 'Dark Horse Comics'), (7, 'default1'), (8, 'default1'), (9, 'Dark Horse Comics'), (10, 'default1'), (11, NULL), (12, NULL), (13, 'Durability'), (14, 'Dark Horse Comics'), (15, 'default2'), (16, 'default1'), (17, 'Durability'), (18, 'default2'), (19, 'default2');
INSERT INTO colour (id, colour) VALUES (0, 'Dark Horse Comics'), (1, 'Dark Horse Comics'), (2, 'Dark Horse Comics'), (3, 'default1'), (4, NULL), (5, 'durability'), (6, 'Dark Horse Comics');
INSERT INTO attribute (id, attribute_name) VALUES (0, 'Durability'), (1, 'Dark Horse Comics'), (2, 'Durability'), (3, 'default1'), (4, 'Durability'), (5, 'Dark Horse Comics');
INSERT INTO alignment (id, alignment) VALUES (1, 'Dark Horse Comics'), (2, 'durability'), (0, NULL), (3, 'default2'), (4, 'default1'), (5, 'Dark Horse Comics'), (6, 'default2'), (7, 'Durability'), (8, 'durability'), (9, 'default2'), (10, 'durability'), (11, 'durability'), (12, 'default2'), (13, 'default2'), (14, NULL), (15, 'Durability'), (16, 'default2');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 2, 1, 9, 6, 18, 7, 1, 'default2', 'durability', 1, 2), (1, 14, 5, 8, 4, 22, 9, 4, 'default1', 'durability', 2, 0), (0, 16, 5, 7, 1, 8, 2, 6, 'durability', 'Dark Horse Comics', NULL, 2), (3, 0, 0, 18, 1, 18, 11, 6, NULL, 'Dark Horse Comics', 0, 2), (4, 7, 6, 0, 4, 5, 10, 6, 'default2', 'default1', 2, 0), (5, 8, 4, 16, 1, 12, 10, 3, 'Durability', 'durability', 0, 2), (6, 3, 3, 7, 3, 22, NULL, 5, NULL, 'default1', 0, NULL), (7, 0, 4, 4, 0, 13, 9, 6, 'default2', 'default2', NULL, 1), (8, 12, NULL, 17, 0, 21, 9, 2, NULL, 'Durability', NULL, 0), (9, 0, 4, 3, 0, 18, 9, 4, 'Durability', 'Durability', NULL, 2), (10, 9, NULL, 9, 0, 19, 8, 5, 'durability', NULL, 1, 2), (11, 0, 1, 14, NULL, 5, 8, 0, NULL, 'Dark Horse Comics', 2, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (1, 3, 2), (4, 0, NULL), (3, 4, 1), (3, 0, 1), (1, 6, 1), (1, NULL, NULL), (1, 8, 1), (1, NULL, 2), (4, 5, NULL), (1, 11, 2), (0, 8, 1), (4, 3, NULL), (5, 5, 1), (4, 0, NULL), (3, 11, 0), (1, 5, 0), (1, 2, 0), (0, 11, 0), (5, 2, 1), (2, 5, NULL), (2, 2, 0), (NULL, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('durability',)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T3.attribute_name = 'durability' AND T4.publisher_name = 'Dark Horse Comics' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/