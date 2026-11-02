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
INSERT INTO "alignment" ("id", "alignment") VALUES (21, '41');
INSERT INTO "alignment" ("id", "alignment") VALUES (31, '41');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (36, '41');
INSERT INTO "colour" ("id", "colour") VALUES (22, '41');
INSERT INTO "colour" ("id", "colour") VALUES (41, '41');
INSERT INTO "gender" ("id", "gender") VALUES (23, '41');
INSERT INTO "gender" ("id", "gender") VALUES (38, '41');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (39, '41');
INSERT INTO "race" ("id", "race") VALUES (32, '41');
INSERT INTO "race" ("id", "race") VALUES (40, '41');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (30, 31, 41, 38, 41, 39, 32, 41, '45', '33', 34, 35);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (37, 31, 41, 38, 41, 39, 40, 41, '45', '42', 43, 44);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (36, 30, 80);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (36, 37, 75);
INSERT INTO "superpower" ("id", "power_name") VALUES (25, '41');
INSERT INTO "superpower" ("id", "power_name") VALUES (24, '41');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (37, 25);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (37, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id WHERE T2.attribute_value BETWEEN 75 AND 80;

/*
Gold Result:
('45',)
('45',)
*/

-- Prediction Query
SELECT DISTINCT T2.superhero_name FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id WHERE T1.attribute_value BETWEEN 75 AND 80;

/*
Prediction Result:
('45',)
*/