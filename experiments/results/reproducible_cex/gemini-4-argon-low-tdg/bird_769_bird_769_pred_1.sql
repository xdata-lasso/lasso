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
-- DATASET 2
INSERT INTO publisher (id, publisher_name) VALUES (10, 'Dark Horse Comics');
INSERT INTO attribute (id, attribute_name) VALUES (20, 'Durability');
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (5, 'Z_Hero', 'Full_Z', 10, 10, 10);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (15, 'A_Hero', 'Full_A', 10, 300, 300);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (5, 20, 90);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (15, 20, 90);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Z_Hero',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN publisher AS p ON s.publisher_id = p.id INNER JOIN hero_attribute AS ha ON s.id = ha.hero_id INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Durability' AND p.publisher_name = 'Dark Horse Comics' AND ha.attribute_value = (SELECT MAX(ha2.attribute_value) FROM superhero AS s2 INNER JOIN hero_attribute AS ha2 ON s2.id = ha2.hero_id INNER JOIN attribute AS a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'Durability' AND s2.publisher_id = p.id);

/*
Prediction Result:
('Z_Hero',)
('A_Hero',)
*/