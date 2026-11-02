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
INSERT INTO race (id, race) VALUES (101, NULL), (99, NULL), (100, 'default1'), (1, 'default2'), (0, 'default1'), (2, NULL), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'default1'), (8, NULL), (9, NULL), (10, 'default2'), (11, 'default1'), (12, NULL), (13, NULL), (14, 'default2'), (15, 'default1'), (16, 'default2'), (17, NULL), (18, NULL), (19, 'default2'), (20, 'default1'), (21, NULL), (22, NULL), (23, 'default1'), (24, 'default1'), (25, 'default1'), (26, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (100, 'default1'), (1, 'default2'), (101, NULL), (0, 'default2'), (99, 'default1'), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, NULL), (10, NULL), (11, 'default1');
INSERT INTO gender (id, gender) VALUES (101, 'default1');
INSERT INTO colour (id, colour) VALUES (100, 'default1'), (0, 'default1'), (1, 'default2'), (99, NULL), (101, NULL), (2, NULL), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, 'default1'), (8, 'default2'), (9, 'default1'), (10, 'default1'), (11, 'default2'), (12, 'default2'), (13, 'default1'), (14, 'default2'), (15, 'default1'), (16, 'default2'), (17, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (99, 'default2'), (101, NULL), (0, NULL), (1, NULL), (100, NULL), (2, NULL), (3, 'default2'), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, NULL);
INSERT INTO alignment (id, alignment) VALUES (101, NULL), (0, 'default2'), (1, 'default2'), (99, 'default1'), (100, 'default2'), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'default2'), (8, NULL), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'default2'), (13, 'default2'), (14, 'default1'), (15, 'default2'), (16, 'default2'), (17, 'default1'), (18, 'default1'), (19, 'default1'), (20, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (101, 0, 3, NULL, 8, 3, 3, 15, 'default1', 'default1', NULL, NULL), (99, 15, 14, 101, 13, 8, NULL, 2, 'default2', 'default1', NULL, 0), (1, 15, 7, 101, 1, 7, 7, 100, 'default2', 'default1', 99, 100), (0, 19, 4, NULL, 99, 99, 26, 5, NULL, 'default1', 101, 99), (100, 3, 12, 101, 4, 6, NULL, 10, 'default1', 'default1', 101, 99), (2, 4, 1, NULL, 1, 2, 13, 10, 'default1', 'default2', 101, 99), (3, 7, 9, 101, 6, 3, 19, 15, 'default1', NULL, 1, 101);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (5, NULL, 99), (7, 101, 0), (9, 100, 1), (NULL, 2, NULL), (5, 1, 101), (NULL, 99, 101), (100, 100, 101), (NULL, 2, 1), (7, 1, 0), (100, 2, 99), (100, 101, 0), (100, 1, NULL), (101, 101, NULL), (4, 100, 100), (3, NULL, 100), (4, 101, 1), (2, 1, 100), (100, 100, 101), (8, 1, NULL), (7, NULL, NULL), (7, 1, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT "colour"."colour" FROM "superhero" INNER JOIN "hero_attribute" ON "superhero"."id" = "hero_attribute"."hero_id" INNER JOIN "colour" ON "superhero"."skin_colour_id" = "colour"."id" WHERE "hero_attribute"."attribute_value" = 100;

/*
Prediction Result:
('default1',)
('default1',)
*/