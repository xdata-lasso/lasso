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
INSERT INTO publisher (id, publisher_name) VALUES (1, 'DC Comics');
INSERT INTO publisher (id, publisher_name) VALUES (2, 'Marvel Comics');
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (1, 'Batman', 'Bruce Wayne', 1, 500, 100);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (2, 'Iron Man', 'Tony Stark', 2, 185, 400);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (3, 'Thor', 'Thor Odinson', 2, 198, 290);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (4, 'Hulk', 'Bruce Banner', 2, 244, 63);
INSERT INTO superhero (id, superhero_name, full_name, publisher_id, height_cm, weight_kg) VALUES (5, 'Wolverine', 'Logan', 2, 160, 136);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Bruce Banner',)
*/

-- Prediction Query
SELECT superhero.superhero_name, superhero.height_cm FROM publisher INNER JOIN superhero ON publisher.id = superhero.publisher_id WHERE publisher.publisher_name = 'Marvel Comics' ORDER BY superhero.height_cm DESC, publisher.id NULLS LAST, superhero.id NULLS LAST;

/*
Prediction Result:
('Hulk', 244)
('Thor', 198)
('Iron Man', 185)
('Wolverine', 160)
*/