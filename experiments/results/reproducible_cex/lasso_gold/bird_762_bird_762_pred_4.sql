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
INSERT INTO "alignment" ("id", "alignment") VALUES (1134, 'on');
INSERT INTO "alignment" ("id", "alignment") VALUES (1178, 'education');
INSERT INTO "alignment" ("id", "alignment") VALUES (1222, 'author');
INSERT INTO "colour" ("id", "colour") VALUES (1135, 'traditional');
INSERT INTO "colour" ("id", "colour") VALUES (1179, 'article');
INSERT INTO "colour" ("id", "colour") VALUES (1223, 'western');
INSERT INTO "colour" ("id", "colour") VALUES (1153, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1157, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1197, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1201, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1241, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1245, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1136, 'yes');
INSERT INTO "gender" ("id", "gender") VALUES (1180, 'effect');
INSERT INTO "gender" ("id", "gender") VALUES (1224, 'almost');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1137, 'Nathan Maldonado');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1181, 'Theresa Miller');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1225, 'Andrea Young');
INSERT INTO "race" ("id", "race") VALUES (1138, 'not');
INSERT INTO "race" ("id", "race") VALUES (1182, 'mention');
INSERT INTO "race" ("id", "race") VALUES (1226, 'relationship');
INSERT INTO "superpower" ("id", "power_name") VALUES (1139, 'Patricia Peterson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1140, 'Patricia Peterson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1141, 'Patricia Peterson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1142, 'Patricia Peterson');
INSERT INTO "superpower" ("id", "power_name") VALUES (1183, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1184, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1185, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1186, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1227, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1228, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1229, 'Vanessa Patel');
INSERT INTO "superpower" ("id", "power_name") VALUES (1230, 'Vanessa Patel');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1143, 'Christopher Smith', 'James Martin', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1170, 1174);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1144, 'Michelle Stanton', 'Tammy Sellers', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1193.0, 1199.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1145, 'Katie Rodriguez', 'Katherine Rodriguez', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1216.0, 1224.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1146, 'Sarah Romero', 'William Roman', 1136, 1135, 1153, 1157, 1138, 1137, 1134, 1239.0, 1249.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1187, 'Matthew Arroyo', 'Jacqueline Lam', 1180, 1179, 1197, 1201, 1182, 1181, 1178, 1214, 1218);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1188, 'Joseph Obrien', 'David Brown', 1180, 1179, 1197, 1201, 1182, 1181, 1178, 1237.0, 1243.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1189, 'Tanya Campos', 'Julian Chapman', 1180, 1179, 1197, 1201, 1182, 1181, 1178, 1260.0, 1268.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1190, 'Michelle Ross', 'Michael Brown', 1180, 1179, 1197, 1201, 1182, 1181, 1178, 1283.0, 1293.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1231, 'Mr. Nathaniel Khan', 'Matthew Lucas', 1224, 1223, 1241, 1245, 1226, 1225, 1222, 1258, 1262);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1232, 'Dana Kennedy', 'Nicholas Mcbride', 1224, 1223, 1241, 1245, 1226, 1225, 1222, 1281.0, 1287.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1233, 'Brandon Hopkins', 'Corey Herrera', 1224, 1223, 1241, 1245, 1226, 1225, 1222, 1304.0, 1312.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1234, 'Jason Shields', 'Clifford Ford', 1224, 1223, 1241, 1245, 1226, 1225, 1222, 1327.0, 1337.0);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1143, 1139);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1143, 1140);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1143, 1141);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1143, 1142);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (NULL, 1183);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (NULL, 1184);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (NULL, 1185);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (NULL, 1186);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1231, 1227);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1231, 1228);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1231, 1229);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1231, 1230);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id GROUP BY T2.power_name ORDER BY COUNT(T1.hero_id) DESC, T2.power_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Patricia Peterson',)
*/

-- Prediction Query
SELECT T1.power_name FROM superpower AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.power_id GROUP BY T1.power_name ORDER BY COUNT(T1.power_name) DESC, T1.power_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Vanessa Patel',)
*/