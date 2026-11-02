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
-- DATASET 1
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (3, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (4, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (5, 'speed');
INSERT INTO attribute (id, attribute_name) VALUES (6, 'Speed ');
INSERT INTO superhero (id, superhero_name, full_name, height_cm, weight_kg) VALUES (10, 'Quicksilver', 'Pietro Maximoff', 180, 79);
INSERT INTO superhero (id, superhero_name, full_name, height_cm, weight_kg) VALUES (20, 'Flash', 'Barry Allen', 183, 88);
INSERT INTO superhero (id, superhero_name, full_name, height_cm, weight_kg) VALUES (30, 'Hulk', 'Bruce Banner', 244, 635);
INSERT INTO superhero (id, superhero_name, full_name, height_cm, weight_kg) VALUES (40, 'Sonic', 'Sonic Hedgehog', 100, 35);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (30, 1, 999);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, 2, 85);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (20, 2, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (40, 2, 95);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, 5, 500);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, 6, 600);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (NULL, 2, 800);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, NULL, 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T3.attribute_name = 'Speed' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Flash',)
*/

-- Prediction Query
SELECT superhero.superhero_name FROM superhero INNER JOIN hero_attribute ON superhero.id = hero_attribute.hero_id INNER JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Speed' AND hero_attribute.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Speed'));

/*
Prediction Result:
*/