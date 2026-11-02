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
INSERT INTO "alignment" ("id", "alignment") VALUES (1005, 'face');
INSERT INTO "alignment" ("id", "alignment") VALUES (1006, 'election');
INSERT INTO "alignment" ("id", "alignment") VALUES (1007, 'dog');
INSERT INTO "alignment" ("id", "alignment") VALUES (1008, 'chair');
INSERT INTO "colour" ("id", "colour") VALUES (1009, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1010, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1011, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1012, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1013, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1014, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1015, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1016, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (1049, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1057, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1062, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1072, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1075, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1087, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1088, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1102, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1101, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1117, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1114, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1132, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1127, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1147, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1140, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1162, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1017, 'since');
INSERT INTO "gender" ("id", "gender") VALUES (1018, 'blue');
INSERT INTO "gender" ("id", "gender") VALUES (1019, 'require');
INSERT INTO "gender" ("id", "gender") VALUES (1020, 'sit');
INSERT INTO "gender" ("id", "gender") VALUES (1021, 'wait');
INSERT INTO "gender" ("id", "gender") VALUES (1022, 'offer');
INSERT INTO "gender" ("id", "gender") VALUES (1023, 'begin');
INSERT INTO "gender" ("id", "gender") VALUES (1024, 'performance');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1025, 'Allen Robinson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1026, 'Alyssa Gonzalez');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1027, 'Kimberly Robinson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1028, 'Rhonda Smith');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1029, 'Melissa Peterson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1030, 'Tyler Rogers');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1031, 'Brent Abbott');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1032, 'Renee Blair');
INSERT INTO "race" ("id", "race") VALUES (1033, 'not');
INSERT INTO "race" ("id", "race") VALUES (1034, 'capital');
INSERT INTO "race" ("id", "race") VALUES (1035, 'win');
INSERT INTO "race" ("id", "race") VALUES (1036, 'human');
INSERT INTO "race" ("id", "race") VALUES (1037, 'bar');
INSERT INTO "race" ("id", "race") VALUES (1038, 'old');
INSERT INTO "race" ("id", "race") VALUES (1039, 'finally');
INSERT INTO "race" ("id", "race") VALUES (1040, 'themselves');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1041, 'Stacey Ward', 'Melissa Robinson', 1017, 1009, 1049, 1057, 1033, 1025, 1001, 1065, 1073);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1042, 'Benjamin Stanley', 'Randy Brown', 1018, 1010, 1062.0, 1072.0, 1034, 1026, 1002, 1088.0, 1098.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1043, 'Victoria Wyatt', 'Renee Morales', 1019, 1011, 1075.0, 1087.0, 1035, 1027, 1003, 1111.0, 1123.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1044, 'Jamie Chavez', 'Thomas Bradley', 1020, 1012, 1088.0, 1102.0, 1036, 1028, 1004, 1134.0, 1148.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1045, 'Carla Kelly', 'Christy Porter', 1021, 1013, 1101.0, 1117.0, 1037, 1029, 1005, 1157.0, 1173.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1046, 'Mia Sutton', 'Maria Thomas', 1022, 1014, 1114.0, 1132.0, 1038, 1030, 1006, 1180.0, 1198.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1047, 'Mark Ferguson', 'Patrick Ryan', 1023, 1015, 1127.0, 1147.0, 1039, 1031, 1007, 1203.0, 1223.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1048, 'Joel Nelson', 'Jessica Silva', 1024, 1016, 1140.0, 1162.0, 1040, 1032, 1008, 1226.0, 1248.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T2.colour = 'Blue' LIMIT 5;

/*
Gold Result:
('Stacey Ward',)
('Benjamin Stanley',)
('Victoria Wyatt',)
('Jamie Chavez',)
('Carla Kelly',)
*/

-- Prediction Query
SELECT superhero.full_name FROM colour INNER JOIN superhero ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Blue' LIMIT 5;

/*
Prediction Result:
('Melissa Robinson',)
('Randy Brown',)
('Renee Morales',)
('Thomas Bradley',)
('Christy Porter',)
*/