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
INSERT INTO race (id, race) VALUES (0, NULL), (1, 'Speed'), (2, 'default2'), (3, 'default1'), (4, NULL), (5, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Speed'), (1, 'default2'), (2, 'default2'), (3, NULL), (4, 'Speed'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, 'default2'), (9, 'Speed'), (10, NULL), (11, NULL), (12, 'default1'), (13, 'default2'), (14, 'default2'), (15, 'Speed'), (16, 'default1'), (17, 'Speed');
INSERT INTO gender (id, gender) VALUES (2, 'default2'), (0, NULL), (1, 'Speed'), (3, 'default2'), (4, NULL), (5, NULL), (6, NULL), (7, 'Speed'), (8, 'default2'), (9, 'Speed'), (10, 'Speed'), (11, 'Speed'), (12, 'default2'), (13, 'Speed'), (14, 'Speed');
INSERT INTO colour (id, colour) VALUES (2, 'default1'), (0, 'default1'), (1, 'Speed'), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default1'), (8, NULL), (9, 'default1'), (10, 'default1'), (11, 'Speed'), (12, NULL), (13, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (0, NULL), (2, 'Speed'), (1, NULL), (3, 'Speed'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, NULL), (8, 'default2'), (9, 'default1'), (10, 'default1'), (11, NULL), (12, 'default2'), (13, 'default2'), (14, 'Speed'), (15, NULL), (16, 'default2'), (17, 'default1');
INSERT INTO alignment (id, alignment) VALUES (1, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, NULL, 1, 13, 6, 6, 4, 13, 'default2', 'default1', 2, 0), (2, 1, 11, 2, 13, 6, 5, 1, 'default1', 'default1', 0, 1), (0, NULL, 11, 6, 1, 3, 0, 7, 'default1', 'default2', 2, 2), (3, 1, NULL, NULL, NULL, 0, NULL, 1, 'default1', 'default2', 1, 0), (4, NULL, 12, 7, 4, 1, 1, 9, 'Speed', 'default1', 2, 2), (5, NULL, 6, 0, 2, 3, 4, 8, NULL, NULL, 1, 1), (6, NULL, 13, 0, 8, 16, 2, 4, 'Speed', 'default2', NULL, 0), (7, 1, 0, 4, 13, 1, 4, 1, 'default2', NULL, 1, 2), (8, NULL, 9, 8, 8, 3, 5, 13, 'default2', 'Speed', 0, 2), (9, 1, 0, 11, NULL, 3, 1, 7, 'default2', 'default1', 1, 2), (10, 1, 13, 11, NULL, 6, 0, 0, NULL, 'Speed', NULL, 1), (11, NULL, 8, 7, 3, 8, NULL, NULL, NULL, 'default1', NULL, 1), (12, NULL, 13, 3, 2, 5, 2, 9, NULL, 'default1', NULL, 1), (13, NULL, 2, 11, 12, 16, 2, 6, 'default1', 'default1', 1, NULL), (14, NULL, 8, 14, 5, 3, NULL, 3, NULL, 'default2', NULL, NULL), (15, NULL, 0, 9, 0, 4, 0, 4, 'Speed', 'default2', 2, NULL), (16, NULL, 13, 7, 6, 5, 3, 9, NULL, 'default1', 2, 2);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (11, 7, 1), (3, 2, NULL), (15, 12, NULL), (9, 15, NULL), (12, 15, NULL), (0, 16, 2), (14, 10, 0), (6, 2, 1), (15, 15, NULL), (3, 11, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id INNER JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Speed' ORDER BY T3.attribute_value, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT p.publisher_name FROM publisher AS p INNER JOIN superhero AS s ON p.id = s.publisher_id INNER JOIN hero_attribute AS ha ON s.id = ha.hero_id INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Speed' AND ha.attribute_value = (SELECT MIN(ha2.attribute_value) FROM hero_attribute AS ha2 INNER JOIN attribute AS a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'Speed');

/*
Prediction Result:
('default2',)
('default2',)
*/