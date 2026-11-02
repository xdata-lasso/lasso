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
INSERT INTO race (id, race) VALUES (2, 'Intelligence'), (0, 'default1'), (1, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'Intelligence'), (6, NULL), (7, NULL), (8, 'Intelligence'), (9, NULL), (10, 'Intelligence');
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Intelligence'), (2, 'default2'), (0, NULL), (3, NULL), (4, 'Intelligence'), (5, 'default2'), (6, 'Intelligence'), (7, NULL), (8, NULL), (9, NULL), (10, 'default2'), (11, 'default2'), (12, 'default2'), (13, 'Intelligence'), (14, 'default1'), (15, 'Intelligence'), (16, 'default1'), (17, 'default1');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (0, 'Intelligence'), (1, 'Intelligence'), (3, 'default1'), (4, NULL), (5, NULL), (6, 'default1'), (7, 'default1'), (8, 'default2'), (9, 'default2'), (10, 'Intelligence');
INSERT INTO colour (id, colour) VALUES (0, 'Intelligence'), (1, 'default1'), (2, 'default1'), (3, 'default1'), (4, NULL), (5, 'Intelligence'), (6, 'default2'), (7, 'Intelligence'), (8, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (1, NULL), (0, NULL), (2, 'default2'), (3, 'default1'), (4, 'Intelligence'), (5, 'Intelligence'), (6, 'default1'), (7, 'Intelligence'), (8, NULL), (9, 'default2'), (10, 'default2'), (11, 'Intelligence'), (12, 'default1');
INSERT INTO alignment (id, alignment) VALUES (1, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 1, 7, 1, NULL, 10, 1, 0, NULL, 'default2', NULL, 0), (1, NULL, 0, 9, 2, 12, NULL, NULL, 'Intelligence', 'Intelligence', 0, 1), (0, NULL, 2, 1, 3, 2, 2, 3, 'default1', 'default2', NULL, NULL), (3, 1, 0, 5, NULL, 17, 0, 7, 'default2', 'Intelligence', 0, 2), (4, NULL, 6, NULL, 0, 16, 2, 5, 'default1', 'default2', NULL, 0), (5, NULL, 4, 6, 7, 12, 6, 3, 'Intelligence', NULL, NULL, NULL), (6, NULL, 8, 10, 2, 8, 3, 5, 'default1', 'Intelligence', NULL, NULL), (7, NULL, 6, 3, 3, 8, 9, 0, NULL, NULL, NULL, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (2, NULL, 0), (NULL, NULL, 0), (2, 1, 1), (12, 1, 1), (7, 5, NULL), (8, 0, 1), (2, NULL, 1), (7, 2, 2), (10, NULL, 0), (2, 7, 1), (1, 0, NULL), (1, 6, 1), (11, NULL, 1), (1, 3, 2), (4, 2, NULL), (11, 5, NULL), (6, 6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T3.attribute_name = 'Intelligence' ORDER BY T2.attribute_value, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN hero_attribute AS ha ON s.id = ha.hero_id INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Intelligence' AND ha.attribute_value = (SELECT MIN(attribute_value) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Intelligence'));

/*
Prediction Result:
*/