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
INSERT INTO race (id, race) VALUES (0, NULL), (2, 'default2');
INSERT INTO publisher (id, publisher_name) VALUES (1, NULL), (2, NULL), (0, NULL), (3, NULL);
INSERT INTO gender (id, gender) VALUES (1, 'default2'), (0, NULL), (2, NULL), (3, NULL), (4, NULL), (5, 'default2'), (6, 'default1'), (7, 'default1'), (8, 'default2'), (9, NULL);
INSERT INTO colour (id, colour) VALUES (0, 'default1'), (1, 'default1'), (2, NULL), (3, NULL), (4, 'default1');
INSERT INTO attribute (id, attribute_name) VALUES (2, NULL), (1, 'default1'), (0, 'default2'), (3, 'default2'), (4, NULL);
INSERT INTO alignment (id, alignment) VALUES (2, 'default1'), (1, 'default2'), (0, 'default1'), (3, 'default1'), (4, 'default2'), (5, 'default1');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (2, 0, 1, 3, 4, 0, 0, 1, NULL, 'default2', 2, 2), (1, 4, 0, 1, 1, 1, 2, 2, 'default2', NULL, 0, 0), (0, 2, 1, NULL, 2, 2, 0, 2, NULL, 'default1', 0, 1), (3, 0, NULL, 4, 2, 0, NULL, NULL, NULL, NULL, 0, 0), (4, 2, 3, 1, 0, 1, 2, 1, 'default1', NULL, 2, 2);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (NULL, 1, 0), (1, 3, NULL), (1, 2, 1), (NULL, NULL, 0), (3, 2, 2), (4, 4, 0), (3, 1, 2), (NULL, NULL, 2), (3, 2, NULL), (3, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN race AS T3 ON T1.race_id = T3.id ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT race.race FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN race ON superhero.race_id = race.id WHERE hero_attribute.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Prediction Result:
(None,)
('default2',)
*/