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
INSERT INTO "alignment" ("id", "alignment") VALUES (19, 'Speedy32');
INSERT INTO "alignment" ("id", "alignment") VALUES (39, 'Speedy32');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (21, 'Speedy32');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (20, 'Speedy32');
INSERT INTO "colour" ("id", "colour") VALUES (31, 'Speedy32');
INSERT INTO "colour" ("id", "colour") VALUES (32, 'Speedy32');
INSERT INTO "gender" ("id", "gender") VALUES (40, 'Speedy32');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (37, 'Hawkman45');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (44, 'Hawkman45');
INSERT INTO "race" ("id", "race") VALUES (22, 'Speedy32');
INSERT INTO "race" ("id", "race") VALUES (33, 'Speedy32');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (29, NULL, 31, 40, 32, 37, 33, 32, 'Speedy', 'Karate Kid34', 35, 36);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (38, 39, 32, 40, 31, 44, 33, 32, 'Speedy', 'Speedy41', 42, 43);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 38, 32);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (20, 38, 32);
INSERT INTO "superpower" ("id", "power_name") VALUES (24, 'Speedy32');
INSERT INTO "superpower" ("id", "power_name") VALUES (23, 'Speedy32');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.publisher_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');

/*
Gold Result:
('Hawkman45',)
('Hawkman45',)
*/

-- Prediction Query
SELECT DISTINCT publisher.publisher_name FROM superhero INNER JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');

/*
Prediction Result:
('Hawkman45',)
*/