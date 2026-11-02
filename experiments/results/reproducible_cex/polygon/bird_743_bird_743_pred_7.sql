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
INSERT INTO "alignment" ("id", "alignment") VALUES (50, 'Bad48');
INSERT INTO "alignment" ("id", "alignment") VALUES (27, 'Bad60');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Bad60');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Bad60');
INSERT INTO "colour" ("id", "colour") VALUES (60, 'Bad60');
INSERT INTO "colour" ("id", "colour") VALUES (52, 'Bad60');
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Bad60');
INSERT INTO "gender" ("id", "gender") VALUES (51, 'Bad60');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Bad60');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (53, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (61, 'Bad60');
INSERT INTO "race" ("id", "race") VALUES (54, 'Bad60');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (49, 50, 60, 51, 52, 53, 54, 60, 'Marvel Comics55', 'Bad56', 57, 58);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (59, 50, 60, 51, 60, 53, 61, 60, 'Bad62', 'Marvel Comics63', 64, 65);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, 59, 60);
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Bad60');
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'Bad60');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (49, 32);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (49, 33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(COUNT(*) AS REAL) * 100 / (SELECT COUNT(*) FROM superhero)), CAST(SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS REAL) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T3.id = T1.alignment_id WHERE T3.alignment = 'Bad';

/*
Gold Result:
(0.0, None)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.alignment = 'Bad' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.id), SUM(CASE WHEN T1.alignment = 'Bad' THEN 1 ELSE 0 END) FROM alignment AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.alignment_id INNER JOIN publisher AS T3 ON T3.id = T2.publisher_id WHERE T3.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(0.0, 0)
*/