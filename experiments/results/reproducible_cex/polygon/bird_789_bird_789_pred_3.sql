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
INSERT INTO "alignment" ("id", "alignment") VALUES (37, 'Alien51');
INSERT INTO "alignment" ("id", "alignment") VALUES (44, 'Alien51');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (19, 'Alien51');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (18, 'Alien51');
INSERT INTO "colour" ("id", "colour") VALUES (47, 'Alien51');
INSERT INTO "colour" ("id", "colour") VALUES (38, 'Alien51');
INSERT INTO "gender" ("id", "gender") VALUES (20, 'Alien51');
INSERT INTO "gender" ("id", "gender") VALUES (45, 'Alien51');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (46, 'Alien51');
INSERT INTO "race" ("id", "race") VALUES (51, 'Alien');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (36, 37, 47, 45, 38, 46, 51, 38, 'Alien39', 'Alien40', 41, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (43, 44, 38, 45, 47, 46, 51, 47, 'Alien48', 'Alien49', 50, 10091);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (18, 43, 51);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (18, 43, 51);
INSERT INTO "superpower" ("id", "power_name") VALUES (22, 'Alien51');
INSERT INTO "superpower" ("id", "power_name") VALUES (21, 'Alien51');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (36, 22);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (43, 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.weight_kg) AS REAL) / COUNT(T1.id) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Alien';

/*
Gold Result:
(5045.5,)
*/

-- Prediction Query
SELECT AVG(superhero.weight_kg) AS average_weight FROM superhero INNER JOIN race ON superhero.race_id = race.id WHERE race.race = 'Alien';

/*
Prediction Result:
(10091.0,)
*/