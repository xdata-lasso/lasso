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
INSERT INTO "alignment" ("id", "alignment") VALUES (37, 'Black44');
INSERT INTO "alignment" ("id", "alignment") VALUES (26, 'Black44');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (23, 'Black44');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (22, 'Black44');
INSERT INTO "colour" ("id", "colour") VALUES (44, 'Black');
INSERT INTO "colour" ("id", "colour") VALUES (24, 'Black');
INSERT INTO "gender" ("id", "gender") VALUES (27, 'Black44');
INSERT INTO "gender" ("id", "gender") VALUES (38, 'Black44');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (39, 'Black44');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (28, 'Black44');
INSERT INTO "race" ("id", "race") VALUES (40, 'Black44');
INSERT INTO "race" ("id", "race") VALUES (29, 'Black44');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (36, 37, 44, 38, 44, 39, 40, 44, NULL, 'Black41', 42, 43);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (25, 26, 24, 27, 44, 28, 29, 24, NULL, 'Black46', 47, 48);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (22, 25, 44);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (22, 25, 44);
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'Black44');
INSERT INTO "superpower" ("id", "power_name") VALUES (30, 'Black44');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (25, 30);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (25, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id AND T1.hair_colour_id = T2.id WHERE T2.colour = 'Black';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT superhero.superhero_name FROM superhero JOIN colour AS eye_colour ON superhero.eye_colour_id = eye_colour.id JOIN colour AS hair_colour ON superhero.hair_colour_id = hair_colour.id WHERE eye_colour.colour = 'Black' AND hair_colour.colour = 'Black';

/*
Prediction Result:
(None,)
(None,)
*/