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
INSERT INTO "alignment" ("id", "alignment") VALUES (1661, 'how');
INSERT INTO "alignment" ("id", "alignment") VALUES (1662, 'industry');
INSERT INTO "alignment" ("id", "alignment") VALUES (1663, 'year');
INSERT INTO "alignment" ("id", "alignment") VALUES (1664, 'senior');
INSERT INTO "colour" ("id", "colour") VALUES (1665, 'decide');
INSERT INTO "colour" ("id", "colour") VALUES (1666, 'bag');
INSERT INTO "colour" ("id", "colour") VALUES (1667, 'person');
INSERT INTO "colour" ("id", "colour") VALUES (1668, 'rock');
INSERT INTO "colour" ("id", "colour") VALUES (1685, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1689, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1669, 'then');
INSERT INTO "gender" ("id", "gender") VALUES (1670, 'product');
INSERT INTO "gender" ("id", "gender") VALUES (1671, 'eight');
INSERT INTO "gender" ("id", "gender") VALUES (1672, 'blue');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1673, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1674, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1675, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1676, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (1677, 'same');
INSERT INTO "race" ("id", "race") VALUES (1678, 'spring');
INSERT INTO "race" ("id", "race") VALUES (1679, 'fish');
INSERT INTO "race" ("id", "race") VALUES (1680, 'to');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1681, 'Renee Hogan', 'Jack Snow', 1669, 1665, 1685, 1689, 1677, 1673, 1661, NULL, 1697);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1682, 'Amanda Patel', 'Christian Thompson', 1669, 1665, 1685, 1689, 1677, 1673, 1661, NULL, 1722.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1683, 'Andrea Holland', 'Marie Gilbert', 1669, 1665, 1685, 1689, 1677, 1673, 1661, NULL, 1747.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1684, 'Jason Henry', 'Patricia Marshall', 1669, 1665, 1685, 1689, 1677, 1673, 1661, NULL, 1772.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Jack Snow',)
*/

-- Prediction Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T2.publisher_name = 'Marvel Comics' AND NOT T1.height_cm IS NULL ORDER BY T1.height_cm DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/