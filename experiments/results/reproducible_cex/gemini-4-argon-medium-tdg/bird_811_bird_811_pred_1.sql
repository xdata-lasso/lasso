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
INSERT INTO superhero (id, superhero_name, full_name) VALUES (10, 'Atom IV', 'Ryan Choi');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (20, 'Atom', 'Atom IV');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (30, 'Atom III', 'Adam Cray');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (40, 'Atom IV ', 'Fake Atom');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (50, 'atom iv', 'Lower Atom');
INSERT INTO superhero (id, superhero_name, full_name) VALUES (60, NULL, 'Null Hero');
INSERT INTO superpower (id, power_name) VALUES (100, 'Size Changing');
INSERT INTO superpower (id, power_name) VALUES (200, 'Atomic Manipulation');
INSERT INTO superpower (id, power_name) VALUES (300, 'Flight');
INSERT INTO superpower (id, power_name) VALUES (400, 'Atom IV');
INSERT INTO superpower (id, power_name) VALUES (10, 'Wrong Join Power');
INSERT INTO hero_power (hero_id, power_id) VALUES (10, 100);
INSERT INTO hero_power (hero_id, power_id) VALUES (10, 200);
INSERT INTO hero_power (hero_id, power_id) VALUES (20, 300);
INSERT INTO hero_power (hero_id, power_id) VALUES (30, 400);
INSERT INTO hero_power (hero_id, power_id) VALUES (40, 300);
INSERT INTO hero_power (hero_id, power_id) VALUES (50, 300);
INSERT INTO hero_power (hero_id, power_id) VALUES (60, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T3.id = T2.power_id WHERE T1.superhero_name = 'Atom IV';

/*
Gold Result:
('Size Changing',)
('Atomic Manipulation',)
*/

-- Prediction Query
SELECT alignment.alignment, superpower.power_name FROM superhero INNER JOIN alignment ON superhero.alignment_id = alignment.id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.superhero_name = 'Atom IV';

/*
Prediction Result:
*/