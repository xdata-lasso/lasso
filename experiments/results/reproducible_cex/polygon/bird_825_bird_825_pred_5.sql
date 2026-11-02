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
INSERT INTO "alignment" ("id", "alignment") VALUES (43, 'Phoenix Force53');
INSERT INTO "alignment" ("id", "alignment") VALUES (52, 'Phoenix Force53');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Phoenix Force53');
INSERT INTO "colour" ("id", "colour") VALUES (46, 'Phoenix Force53');
INSERT INTO "colour" ("id", "colour") VALUES (56, 'Phoenix Force53');
INSERT INTO "gender" ("id", "gender") VALUES (53, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Phoenix Force53');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (44, 'Phoenix Force53');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (54, 'Phoenix Force53');
INSERT INTO "race" ("id", "race") VALUES (45, 'Phoenix Force53');
INSERT INTO "race" ("id", "race") VALUES (55, 'Phoenix Force53');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, 43, 46, 53, 46, 44, 45, 46, 'Phoenix Force47', 'Phoenix Force48', 49, 50);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (34, 52, 56, 53, 56, 54, 55, 56, 'Phoenix Force57', 'Phoenix Force58', 59, 60);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, 34, 53);
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'Phoenix Force');
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'Phoenix Force53');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (33, 32);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (34, 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.gender FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T3.power_name = 'Phoenix Force';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT gender.gender FROM gender INNER JOIN superhero ON gender.id = superhero.gender_id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Phoenix Force';

/*
Prediction Result:
(None,)
*/