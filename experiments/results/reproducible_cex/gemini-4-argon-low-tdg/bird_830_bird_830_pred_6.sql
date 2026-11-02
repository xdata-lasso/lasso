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
-- Tests tie-breaking on T1.id ASC when T2.attribute_value is tied across two 'Black Panther' entities.
-- Also tests swapped join conditions (e.g., T1.id = T2.attribute_id or T2.hero_id = T3.id).
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Combat');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Power');
INSERT INTO attribute (id, attribute_name) VALUES (10, 'DecoyAttr10');
INSERT INTO attribute (id, attribute_name) VALUES (20, 'DecoyAttr20');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (10, 'Black Panther', 'T''Chaka');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (20, 'Black Panther', 'T''Challa');
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (20, 1, 50);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (10, 2, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Power',)
*/

-- Prediction Query
SELECT a.attribute_name FROM attribute AS a INNER JOIN hero_attribute AS ha ON a.id = ha.attribute_id INNER JOIN superhero AS s ON ha.hero_id = s.id WHERE s.superhero_name = 'Black Panther' GROUP BY a.id ORDER BY MIN(ha.attribute_value) ASC, a.attribute_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Combat',)
*/