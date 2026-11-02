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
INSERT INTO race (id, race) VALUES (2, 'default1'), (0, 'default2'), (1, NULL), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, 'default1'), (8, 'default1'), (9, 'default2'), (10, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'default1'), (1, NULL), (0, 'default1'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default1'), (8, NULL);
INSERT INTO gender (id, gender) VALUES (0, NULL), (2, 'default1'), (1, NULL), (3, 'default2'), (4, NULL), (5, NULL), (6, NULL), (7, NULL), (8, 'default1'), (9, NULL), (10, 'default2'), (11, NULL), (12, NULL);
INSERT INTO colour (id, colour) VALUES (1, 'default2'), (2, 'default1'), (0, 'default2');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'default1'), (0, 'default2'), (1, NULL), (3, NULL), (4, NULL), (5, 'default1'), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, NULL);
INSERT INTO alignment (id, alignment) VALUES (2, 'default2'), (1, 'default1'), (0, 'default1'), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (0, 2, NULL, 8, 1, 3, 10, 1, 'default1', 'default1', 2, 2), (1, 10, 1, 3, 1, 5, 10, 1, 'default2', NULL, 0, NULL), (2, 2, 2, 12, 0, 7, 10, 2, NULL, 'default2', 2, 2), (3, 3, NULL, 10, 0, 4, 6, 0, 'default1', 'default1', 1, 2), (4, NULL, 2, 4, NULL, NULL, 2, 0, 'default1', 'default2', NULL, NULL), (5, 5, 1, 8, 0, 7, 7, 1, 'default1', NULL, 0, 1), (6, 4, 0, 4, 1, 7, 4, 0, NULL, 'default2', NULL, 0), (7, 9, 0, 3, 1, 1, 3, 0, 'default1', 'default2', 0, NULL), (8, 11, 2, 4, 2, 4, 1, NULL, 'default1', 'default1', NULL, NULL), (9, 9, NULL, 2, 0, 8, NULL, 0, NULL, NULL, 1, 1), (10, 0, 2, 10, NULL, NULL, 7, 0, NULL, NULL, 2, 1), (11, 5, 1, 6, NULL, 2, 3, 1, NULL, 'default1', NULL, NULL), (12, 4, 2, 1, 2, 7, 5, NULL, 'default1', NULL, 0, 0), (13, NULL, 1, 5, 2, 0, NULL, 0, NULL, 'default2', 2, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (7, 12, 2), (7, 10, 2), (2, NULL, 0), (4, 5, 2), (5, 9, 1), (2, 9, 2), (3, 3, 2), (1, 10, NULL), (6, 6, NULL), (3, 8, 0), (9, 4, NULL), (2, 11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN race AS T3 ON T1.race_id = T3.id ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.race FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id INNER JOIN hero_attribute AS T3 ON T2.id = T3.hero_id ORDER BY T3.attribute_value DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/