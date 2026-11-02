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
INSERT INTO alignment (id, alignment) VALUES (1, 'Good');
INSERT INTO alignment (id, alignment) VALUES (2, 'Bad');
INSERT INTO colour (id, colour) VALUES (1, 'Red');
INSERT INTO colour (id, colour) VALUES (2, 'Blue');
INSERT INTO gender (id, gender) VALUES (1, 'Male');
INSERT INTO gender (id, gender) VALUES (2, 'Female');
INSERT INTO race (id, race) VALUES (1, 'Demon');
INSERT INTO race (id, race) VALUES (2, 'Human');
INSERT INTO publisher (id, publisher_name) VALUES (10, 'Marvel Comics');
INSERT INTO publisher (id, publisher_name) VALUES (20, 'Dark Horse Comics');
INSERT INTO publisher (id, publisher_name) VALUES (30, 'DC Comics');
INSERT INTO attribute (id, attribute_name) VALUES (100, 'Strength');
INSERT INTO attribute (id, attribute_name) VALUES (200, 'Durability');
INSERT INTO attribute (id, attribute_name) VALUES (300, 'Intelligence');
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (1, 'Hellboy', 'Anung Un Rama', 1, 1, 1, 1, 1, 20, 1, 205, 158);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (2, 'Concrete', ' Ronald Lithgow', 1, 2, 2, 2, 2, 20, 1, 180, 90);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (3, 'Abe Sapien', 'Langdon Everett Caul', 1, 2, 1, 2, 2, 20, 1, 191, 85);
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg) VALUES (4, 'Thor', 'Thor Odinson', 1, 2, 1, 2, 2, 10, 1, 198, 290);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 200, 60);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 100, 99);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 200, 85);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 100, 40);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 200, 30);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (4, 200, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Concrete',)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T3.attribute_name = 'durability' AND T4.publisher_name = 'Dark Horse Comics' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/