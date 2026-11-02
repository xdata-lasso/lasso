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
INSERT INTO colour (id, colour) VALUES (1, 'Green');
INSERT INTO colour (id, colour) VALUES (2, 'Blue');
INSERT INTO attribute (id, attribute_name) VALUES (1, 'Intelligence');
INSERT INTO attribute (id, attribute_name) VALUES (2, 'Strength');
INSERT INTO superhero (id, superhero_name, skin_colour_id) VALUES (1, 'HeroA', 1);
INSERT INTO superhero (id, superhero_name, skin_colour_id) VALUES (2, 'HeroB', 1);
INSERT INTO superhero (id, superhero_name, skin_colour_id) VALUES (3, 'HeroC', 2);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 1, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (1, 2, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (2, 1, 100);
INSERT INTO hero_attribute (hero_id, attribute_id, attribute_value) VALUES (3, 2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id INNER JOIN hero_attribute AS T3 ON T1.id = T3.hero_id WHERE T3.attribute_value = 100;

/*
Gold Result:
('Green',)
('Blue',)
*/

-- Prediction Query
SELECT "colour"."colour" FROM "superhero" INNER JOIN "hero_attribute" ON "superhero"."id" = "hero_attribute"."hero_id" INNER JOIN "colour" ON "superhero"."skin_colour_id" = "colour"."id" WHERE "hero_attribute"."attribute_value" = 100;

/*
Prediction Result:
('Green',)
('Green',)
('Green',)
('Blue',)
*/