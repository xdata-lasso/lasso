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
INSERT INTO race (id, race) VALUES (0, NULL), (1, 'default2'), (2, NULL), (3, NULL), (4, NULL), (5, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (0, NULL), (2, NULL), (1, 'default2'), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default1'), (7, 'default2');
INSERT INTO gender (id, gender) VALUES (1, 'default2'), (2, 'default1'), (0, 'default1'), (3, NULL), (4, 'default1'), (5, NULL), (6, 'default1'), (7, 'default2'), (8, 'default1'), (9, 'default1'), (10, 'default2'), (11, 'default1');
INSERT INTO colour (id, colour) VALUES (2, NULL);
INSERT INTO alignment (id, alignment) VALUES (1, NULL), (2, 'default1'), (0, 'default1'), (3, 'default2'), (4, NULL);
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, NULL, 2, 3, 2, 2, NULL, NULL, NULL, NULL, NULL, 1), (1, 1, 2, 3, NULL, 7, 0, 2, 'default2', NULL, 2, 1), (0, NULL, 2, 9, 2, 5, 2, NULL, 'default2', 'default1', 0, 0), (3, 0, NULL, 10, NULL, 6, 2, 2, 'default2', 'default1', 1, 0), (4, 2, NULL, 1, NULL, 7, 2, NULL, NULL, NULL, 2, 1), (5, 2, 2, NULL, NULL, 2, 1, 2, 'default1', NULL, NULL, 2), (6, 2, NULL, 0, 2, 5, 1, 2, 'default1', 'default2', NULL, NULL), (7, 1, NULL, 2, 2, NULL, 1, 2, NULL, 'default2', 1, 0);
INSERT INTO hero_power (hero_id, power_id) VALUES (5, NULL), (0, NULL), (7, NULL), (0, NULL), (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.superhero_name ORDER BY COUNT(T2.hero_id) DESC, T1.superhero_name NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T2.superhero_name FROM hero_power AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id GROUP BY T2.superhero_name ORDER BY COUNT(T1.power_id) DESC, T2.superhero_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/