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
INSERT INTO "alignment" ("id", "alignment") VALUES (20, 'Dark Horse Comics40');
INSERT INTO "alignment" ("id", "alignment") VALUES (39, 'Dark Horse Comics40');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (22, 'Dark Horse Comics40');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (21, 'Dark Horse Comics40');
INSERT INTO "colour" ("id", "colour") VALUES (40, 'Dark Horse Comics40');
INSERT INTO "colour" ("id", "colour") VALUES (43, 'Dark Horse Comics40');
INSERT INTO "gender" ("id", "gender") VALUES (23, 'Dark Horse Comics40');
INSERT INTO "gender" ("id", "gender") VALUES (41, 'Dark Horse Comics40');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (48, 'Dark Horse Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (24, 'Dark Horse Comics49');
INSERT INTO "race" ("id", "race") VALUES (25, 'Dark Horse Comics40');
INSERT INTO "race" ("id", "race") VALUES (42, 'Dark Horse Comics40');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (38, 39, 40, 41, 40, 48, 42, 43, 'Dark Horse Comics44', 'Dark Horse Comics45', 46, 47);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (26, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 26, 40);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 26, 40);
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Dark Horse Comics40');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (26, 33);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (26, 33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Dark Horse Comics';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS h JOIN publisher AS p ON h.publisher_id = p.id WHERE p.publisher_name = 'Dark Horse Comics';

/*
Prediction Result:
(1,)
*/