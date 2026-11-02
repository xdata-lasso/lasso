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
INSERT INTO publisher (id, publisher_name) VALUES (1, 'Pub1');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Pub2');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Speed');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Speed');
INSERT INTO superhero (id, superhero_name, publisher_id) VALUES (1, 'Hero1', 1);
INSERT INTO superhero (id, superhero_name, publisher_id) VALUES (2, 'Hero2', 2);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 2, 10);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id INNER JOIN attribute AS T4 ON T3.attribute_id = T4.id WHERE T4.attribute_name = 'Speed' ORDER BY T3.attribute_value, T1.id NULLS LAST, T2.id NULLS LAST, T3.hero_id NULLS LAST, T3.attribute_id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Pub1',)
*/

-- Prediction Query
SELECT T4.publisher_name FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id INNER JOIN superhero AS T3 ON T2.hero_id = T3.id INNER JOIN publisher AS T4 ON T3.publisher_id = T4.id WHERE T1.attribute_name = 'Speed' ORDER BY T2.attribute_value, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Pub2',)
*/