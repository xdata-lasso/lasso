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
-- Tests basic positive match, join column confusion (eye vs hair vs skin colour), and column confusion (height_cm vs weight_kg vs id).
INSERT INTO colour (id, colour) VALUES (1, 'Amber');
INSERT INTO colour (id, colour) VALUES (2, 'Blue');
INSERT INTO colour (id, colour) VALUES (3, 'Green');
-- Hero 1: Eye colour is Amber (Target match)
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (10, 'HeroEyeAmber', 1, 2, 3, 185, 80);
-- Hero 2: Hair colour is Amber, Eye colour is Blue (Catches join on hair_colour_id)
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (20, 'HeroHairAmber', 2, 1, 3, 175, 70);
-- Hero 3: Skin colour is Amber, Eye colour is Green (Catches join on skin_colour_id)
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (30, 'HeroSkinAmber', 3, 2, 1, 165, 60);
-- Hero 4: Eye colour is NULL (Catches LEFT/RIGHT JOIN or IS NULL mutations)
INSERT INTO superhero (id, superhero_name, eye_colour_id, hair_colour_id, skin_colour_id, height_cm, weight_kg) VALUES (40, 'HeroNoEye', NULL, 1, 1, 195, 90);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.height_cm FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T2.colour = 'Amber';

/*
Gold Result:
(185,)
*/

-- Prediction Query
SELECT superhero.superhero_name, superhero.height_cm FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Amber';

/*
Prediction Result:
('HeroEyeAmber', 185)
*/