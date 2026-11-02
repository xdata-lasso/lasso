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
INSERT INTO "alignment" ("id", "alignment") VALUES (37, 'Agility53');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (33, 'Agility53');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (32, 'Agility53');
INSERT INTO "colour" ("id", "colour") VALUES (53, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (34, 'Blond');
INSERT INTO "gender" ("id", "gender") VALUES (38, 'Agility53');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, 'Agility53');
INSERT INTO "race" ("id", "race") VALUES (41, 'Agility53');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (44, NULL, 53, NULL, 34, NULL, NULL, NULL, 'Agility59', NULL, NULL, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (36, 37, 34, 38, NULL, 40, 41, 53, 'Blond49', NULL, 51, 52);
INSERT INTO "superpower" ("id", "power_name") VALUES (43, 'Blond67');
INSERT INTO "superpower" ("id", "power_name") VALUES (42, 'Agility68');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (44, 43);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (44, 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Blond';

/*
Gold Result:
('Agility59',)
*/

-- Prediction Query
SELECT s.superhero_name FROM superhero AS s INNER JOIN colour AS c1 ON s.eye_colour_id = c1.id INNER JOIN colour AS c2 ON s.hair_colour_id = c2.id INNER JOIN hero_power AS hp ON s.id = hp.hero_id INNER JOIN superpower AS sp ON hp.power_id = sp.id WHERE c1.colour = 'Blue' AND c2.colour = 'Blond' AND sp.power_name = 'Agility';

/*
Prediction Result:
*/