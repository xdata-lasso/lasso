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
INSERT INTO "alignment" ("id", "alignment") VALUES (50, 'Blue36');
INSERT INTO "alignment" ("id", "alignment") VALUES (58, 'Blue36');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (34, 'Blue36');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (33, 'Blue36');
INSERT INTO "colour" ("id", "colour") VALUES (36, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (35, 'Blue');
INSERT INTO "gender" ("id", "gender") VALUES (56, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (64, 'Male');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (51, 'Blue36');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (59, 'Blue36');
INSERT INTO "race" ("id", "race") VALUES (38, 'Male65');
INSERT INTO "race" ("id", "race") VALUES (37, 'Male65');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (49, 50, 35, 56, 36, 51, 38, 36, 'Blue52', 'Male53', 54, 55);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (57, 58, 36, 64, 35, 59, 37, 35, 'Blue60', 'Male61', 62, 63);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (33, 57, 36);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (34, 57, 36);
INSERT INTO "superpower" ("id", "power_name") VALUES (40, 'Blue36');
INSERT INTO "superpower" ("id", "power_name") VALUES (39, 'Blue36');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (57, 39);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (57, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
('Male65',)
('Male65',)
*/

-- Prediction Query
SELECT DISTINCT r.race FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id JOIN colour AS c ON s.hair_colour_id = c.id JOIN race AS r ON s.race_id = r.id WHERE g.gender = 'Male' AND c.colour = 'Blue';

/*
Prediction Result:
('Male65',)
*/