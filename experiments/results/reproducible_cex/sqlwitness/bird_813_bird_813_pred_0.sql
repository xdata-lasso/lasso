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
INSERT INTO race (id, race) VALUES (0, 'default1'), (1, 'default2'), (2, 'default1'), (3, NULL), (4, 'Neutral'), (5, NULL), (6, 'default2'), (7, 'Neutral'), (8, 'Neutral'), (9, 'Neutral'), (10, NULL), (11, 'default2'), (12, NULL), (13, 'default1'), (14, 'default1'), (15, 'Neutral'), (16, NULL), (17, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (0, 'Neutral'), (1, 'default1'), (2, 'Neutral'), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, 'Neutral'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, NULL), (11, NULL), (12, NULL), (13, 'Neutral'), (14, 'default1'), (15, 'Neutral'), (16, 'default2'), (17, 'default1'), (18, 'default1'), (19, 'default2');
INSERT INTO gender (id, gender) VALUES (0, NULL), (1, 'default1'), (2, 'default1'), (3, NULL), (4, 'Neutral'), (5, 'default2'), (6, 'Neutral'), (7, 'default2'), (8, 'Neutral'), (9, 'default2'), (10, NULL), (11, 'default1'), (12, 'default1'), (13, 'default2'), (14, 'default1'), (15, 'default2'), (16, 'default2'), (17, 'Neutral'), (18, 'Neutral'), (19, 'default1'), (20, 'default2'), (21, 'default2'), (22, 'default2');
INSERT INTO colour (id, colour) VALUES (1, 'default1'), (0, 'default2'), (2, 'default2'), (3, 'Neutral'), (4, NULL), (5, 'default1'), (6, 'default1'), (7, 'Neutral'), (8, 'default1'), (9, 'default2'), (10, 'Neutral'), (11, 'Neutral'), (12, 'default1'), (13, 'default2'), (14, 'default2'), (15, 'default1'), (16, 'default2'), (17, 'Neutral'), (18, NULL);
INSERT INTO attribute (id, attribute_name) VALUES (0, 'default1'), (1, 'default2'), (2, NULL), (3, 'default2'), (4, 'Neutral'), (5, 'Neutral'), (6, 'default2'), (7, 'default2'), (8, 'Neutral'), (9, NULL), (10, 'default1'), (11, 'Neutral'), (12, NULL), (13, 'Neutral'), (14, 'Neutral'), (15, NULL), (16, 'default2');
INSERT INTO alignment (id, alignment) VALUES (1, 'default1'), (0, 'default2'), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'Neutral'), (7, NULL), (8, 'default1'), (9, 'Neutral'), (10, NULL), (11, 'default1'), (12, 'default2'), (13, 'default2'), (14, 'default2'), (15, NULL), (16, 'default2'), (17, 'default2'), (18, 'default2'), (19, 'default1'), (20, 'default2'), (21, 'default2'), (22, NULL), (23, 'Neutral');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 15, 4, 16, 11, 11, 5, 3, 'Neutral', NULL, 0, 0), (0, 21, 0, 17, 11, 15, 12, 15, 'default1', 'default2', NULL, 0), (2, 11, NULL, 17, 8, 11, 2, 1, 'Neutral', 'Neutral', 1, 0), (3, 23, 9, 4, 4, 7, 6, 5, NULL, 'default2', 0, 0), (4, 6, 15, 14, 12, 0, 10, 4, 'Neutral', NULL, 1, 0), (5, 4, 3, 4, 11, 9, 5, 4, NULL, NULL, 1, NULL), (6, 0, 14, 13, 13, 7, 12, 16, NULL, 'default1', 0, NULL), (7, 2, 14, 3, 4, 3, 1, 13, 'default1', 'default1', 1, 1);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (5, 4, 1), (14, 3, 0), (5, 5, NULL), (13, 1, 1), (8, 3, 1), (3, 3, 0), (4, 2, 1), (0, 1, 1), (2, 0, 0), (4, 0, NULL), (6, 7, NULL), (10, 7, 0), (1, 3, 0), (5, 3, 1), (3, 0, 0), (1, 5, NULL), (9, 7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT AVG(attribute_value) FROM hero_attribute WHERE hero_id IN (SELECT id FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Neutral'));

/*
Prediction Result:
(1.0,)
*/