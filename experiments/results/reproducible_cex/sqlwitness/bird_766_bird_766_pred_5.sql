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
INSERT INTO race (id, race) VALUES (0, NULL), (2, NULL), (1, 'default1'), (3, NULL), (4, NULL), (5, 'default1'), (6, NULL), (7, 'default1');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'default1'), (1, 'Strength'), (0, 'default1'), (3, 'Strength'), (4, 'default2');
INSERT INTO gender (id, gender) VALUES (2, 'default1'), (1, NULL);
INSERT INTO colour (id, colour) VALUES (1, NULL), (2, 'Strength'), (0, NULL), (3, 'default1'), (4, 'Strength'), (5, 'Strength'), (6, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (0, 'Strength'), (2, 'default1'), (1, 'Strength'), (3, 'default2'), (4, 'Strength'), (5, 'Strength'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, NULL), (10, 'default2'), (11, 'default1'), (12, 'default2'), (13, 'default2'), (14, NULL), (15, 'default2'), (16, 'default1'), (17, 'default2');
INSERT INTO alignment (id, alignment) VALUES (0, 'Strength'), (1, NULL), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'Strength'), (6, 'default2'), (7, 'Strength'), (8, 'default1'), (9, NULL), (10, NULL), (11, 'default1'), (12, 'default2'), (13, 'Strength'), (14, 'default1'), (15, 'Strength');
INSERT INTO superhero (id, alignment_id, eye_colour_id, gender_id, hair_colour_id, publisher_id, race_id, skin_colour_id, superhero_name, full_name, height_cm, weight_kg) VALUES (1, 12, 2, 1, 3, 2, 4, 2, 'default2', 'Strength', 2, NULL), (2, 2, 6, 2, 6, 3, 6, 3, NULL, 'Strength', 1, 1), (0, 14, 0, NULL, NULL, 2, 4, 3, 'Strength', 'default2', 0, 0), (3, 12, 0, NULL, 3, 3, 0, 0, 'default2', 'default1', 2, 0);
INSERT INTO hero_attribute (attribute_id, hero_id, attribute_value) VALUES (9, 3, 1), (13, 1, 0), (12, 2, NULL), (1, 3, 2), (NULL, 3, 1), (11, 2, 0), (12, 3, 0), (6, NULL, 0), (5, 1, NULL), (5, 2, 2), (15, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T3.attribute_name = 'Strength' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Strength',)
*/

-- Prediction Query
SELECT superhero.full_name FROM superhero INNER JOIN hero_attribute ON superhero.id = hero_attribute.hero_id INNER JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Strength' AND hero_attribute.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute INNER JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Strength');

/*
Prediction Result:
('default1',)
('Strength',)
*/