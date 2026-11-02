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
INSERT INTO "alignment" ("id", "alignment") VALUES (46, 'Female49');
INSERT INTO "alignment" ("id", "alignment") VALUES (26, 'Female49');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Female49');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, 'Female49');
INSERT INTO "colour" ("id", "colour") VALUES (47, 'Female49');
INSERT INTO "colour" ("id", "colour") VALUES (49, 'Female49');
INSERT INTO "gender" ("id", "gender") VALUES (54, 'Female');
INSERT INTO "gender" ("id", "gender") VALUES (65, 'Marvel Comics66');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (29, NULL);
INSERT INTO "race" ("id", "race") VALUES (48, 'Female49');
INSERT INTO "race" ("id", "race") VALUES (31, 'Female49');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (45, 46, 47, 54, 49, 30, 48, 49, 'Marvel Comics50', 'Female51', 52, 53);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (55, NULL, NULL, 65, NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 55, 49);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 45, 49);
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Female49');
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'Female49');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (55, 32);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (55, 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.gender = 'Female';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS super INNER JOIN gender AS g ON super.gender_id = g.id INNER JOIN publisher AS p ON super.publisher_id = p.id WHERE g.gender = 'Female' AND p.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(1,)
*/