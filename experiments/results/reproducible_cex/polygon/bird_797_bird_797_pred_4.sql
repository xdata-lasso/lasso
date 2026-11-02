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
INSERT INTO "alignment" ("id", "alignment") VALUES (35, 'Brown45');
INSERT INTO "alignment" ("id", "alignment") VALUES (44, 'Brown45');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Brown45');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, 'Brown45');
INSERT INTO "colour" ("id", "colour") VALUES (45, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (47, 'Brown');
INSERT INTO "gender" ("id", "gender") VALUES (36, 'Brown45');
INSERT INTO "gender" ("id", "gender") VALUES (46, 'Brown45');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (37, 'Brown45');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (48, 'Brown45');
INSERT INTO "race" ("id", "race") VALUES (38, 'Brown45');
INSERT INTO "race" ("id", "race") VALUES (49, 'Brown45');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (34, 35, 45, 36, 47, 37, 38, 47, 'Brown39', 'Blue40', 41, 42);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (43, 44, 45, 46, 47, 48, 49, 45, 'Brown39', 'Blue50', 51, 52);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 43, 45);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 34, 45);
INSERT INTO "superpower" ("id", "power_name") VALUES (29, 'Brown45');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (34, 29);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (43, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Brown';

/*
Gold Result:
('Brown39',)
('Brown39',)
*/

-- Prediction Query
SELECT DISTINCT T1.superhero_name FROM superhero AS T1 JOIN colour AS T2 ON T2.id = T1.eye_colour_id JOIN colour AS T3 ON T3.id = T1.hair_colour_id WHERE T2.colour = 'Blue' AND T3.colour = 'Brown';

/*
Prediction Result:
('Brown39',)
*/