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
INSERT INTO "alignment" ("id", "alignment") VALUES (61, 'George Lucas68');
INSERT INTO "alignment" ("id", "alignment") VALUES (53, 'George Lucas68');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, 'George Lucas68');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (26, 'George Lucas68');
INSERT INTO "colour" ("id", "colour") VALUES (62, 'George Lucas68');
INSERT INTO "colour" ("id", "colour") VALUES (55, 'George Lucas68');
INSERT INTO "gender" ("id", "gender") VALUES (28, 'George Lucas68');
INSERT INTO "gender" ("id", "gender") VALUES (68, 'Female69');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, 'George Lucas68');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (29, 'George Lucas');
INSERT INTO "race" ("id", "race") VALUES (63, 'George Lucas68');
INSERT INTO "race" ("id", "race") VALUES (54, 'George Lucas68');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (52, 53, 55, 68, 55, 29, 54, 55, NULL, 'Female57', 58, 59);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (60, 61, 62, 68, 62, 29, 63, 62, NULL, 'Female65', 66, 67);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 52, 68);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (26, 60, 68);
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'George Lucas68');
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'George Lucas68');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (60, 31);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (52, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.gender = 'Female' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN gender AS T3 ON T1.gender_id = T3.id WHERE T2.publisher_name = 'George Lucas';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.gender = 'Female' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id INNER JOIN publisher AS T3 ON T1.publisher_id = T3.id WHERE T3.publisher_name = 'George Lucas';

/*
Prediction Result:
(None,)
*/