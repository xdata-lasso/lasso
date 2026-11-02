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
INSERT INTO "alignment" ("id", "alignment") VALUES (1001, 'purpose');
INSERT INTO "alignment" ("id", "alignment") VALUES (1002, 'brother');
INSERT INTO "alignment" ("id", "alignment") VALUES (1003, 'ago');
INSERT INTO "alignment" ("id", "alignment") VALUES (1004, 'site');
INSERT INTO "colour" ("id", "colour") VALUES (1005, 'face');
INSERT INTO "colour" ("id", "colour") VALUES (1006, 'election');
INSERT INTO "colour" ("id", "colour") VALUES (1007, 'dog');
INSERT INTO "colour" ("id", "colour") VALUES (1008, 'chair');
INSERT INTO "colour" ("id", "colour") VALUES (1025, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1029, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1009, 'since');
INSERT INTO "gender" ("id", "gender") VALUES (1010, 'blue');
INSERT INTO "gender" ("id", "gender") VALUES (1011, 'require');
INSERT INTO "gender" ("id", "gender") VALUES (1012, 'sit');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1013, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1014, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1015, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1016, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (1017, 'wait');
INSERT INTO "race" ("id", "race") VALUES (1018, 'offer');
INSERT INTO "race" ("id", "race") VALUES (1019, 'begin');
INSERT INTO "race" ("id", "race") VALUES (1020, 'performance');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1021, 'Allen Robinson', 'Melissa Peterson', 1009, 1005, 1025, 1029, 1017, 1013, 1001, 1033, 1037);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1022, 'Alyssa Gonzalez', 'Tyler Rogers', 1009, 1005, 1025, 1029, 1017, 1013, 1001, 1056.0, 1062.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1023, 'Kimberly Robinson', 'Brent Abbott', 1009, 1005, 1025, 1029, 1017, 1013, 1001, 1079.0, 1087.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1024, 'Rhonda Smith', 'Renee Blair', 1009, 1005, 1025, 1029, 1017, 1013, 1001, 1102.0, 1112.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Renee Blair',)
*/

-- Prediction Query
SELECT T1.superhero_name AS name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('Rhonda Smith',)
('Kimberly Robinson',)
('Alyssa Gonzalez',)
('Allen Robinson',)
*/