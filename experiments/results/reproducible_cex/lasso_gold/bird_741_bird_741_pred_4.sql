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
INSERT INTO "alignment" ("id", "alignment") VALUES (2017, 'Mr');
INSERT INTO "alignment" ("id", "alignment") VALUES (2061, 'animal');
INSERT INTO "alignment" ("id", "alignment") VALUES (2105, 'method');
INSERT INTO "colour" ("id", "colour") VALUES (2018, 'season');
INSERT INTO "colour" ("id", "colour") VALUES (2062, 'friend');
INSERT INTO "colour" ("id", "colour") VALUES (2106, 'turn');
INSERT INTO "colour" ("id", "colour") VALUES (2036, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2040, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2080, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2084, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2124, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2128, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (2019, 'explain');
INSERT INTO "gender" ("id", "gender") VALUES (2063, 'size');
INSERT INTO "gender" ("id", "gender") VALUES (2107, 'number');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2020, 'John Kennedy');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2064, 'Thomas James');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2108, 'Barry Welch');
INSERT INTO "race" ("id", "race") VALUES (2021, 'loss');
INSERT INTO "race" ("id", "race") VALUES (2065, 'record');
INSERT INTO "race" ("id", "race") VALUES (2109, 'will');
INSERT INTO "superpower" ("id", "power_name") VALUES (2022, 'Janet Weeks');
INSERT INTO "superpower" ("id", "power_name") VALUES (2023, 'Sherry Shields');
INSERT INTO "superpower" ("id", "power_name") VALUES (2024, 'Richard Perry');
INSERT INTO "superpower" ("id", "power_name") VALUES (2025, 'Katie Hoover');
INSERT INTO "superpower" ("id", "power_name") VALUES (2066, 'Marissa Hernandez');
INSERT INTO "superpower" ("id", "power_name") VALUES (2067, 'Beth Sanford');
INSERT INTO "superpower" ("id", "power_name") VALUES (2068, 'Brian Kirk');
INSERT INTO "superpower" ("id", "power_name") VALUES (2069, 'Thomas Smith');
INSERT INTO "superpower" ("id", "power_name") VALUES (2110, 'Darren Davis');
INSERT INTO "superpower" ("id", "power_name") VALUES (2111, 'Paige Padilla');
INSERT INTO "superpower" ("id", "power_name") VALUES (2112, 'Christopher Evans');
INSERT INTO "superpower" ("id", "power_name") VALUES (2113, 'Frederick Brown');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2026, 'Edwin Matthews', 'Mrs. Brittany Ryan MD', 2019, 2018, 2036, 2040, 2021, 2020, 2017, 2053, 2057);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2027, 'Edwin Matthews', 'Kimberly Gibson', 2019, 2018, 2036, 2040, 2021, 2020, 2017, 2076.0, 2082.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2028, 'Edwin Matthews', 'Colin Terry', 2019, 2018, 2036, 2040, 2021, 2020, 2017, 2099.0, 2107.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2029, 'Edwin Matthews', 'Cynthia Rowe', 2019, 2018, 2036, 2040, 2021, 2020, 2017, 2122.0, 2132.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2070, 'Stephanie Marshall', 'Richard Baker', 2063, 2062, 2080, 2084, 2065, 2064, 2061, 2097, 2101);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2071, 'Stephanie Marshall', 'Jennifer Miller', 2063, 2062, 2080, 2084, 2065, 2064, 2061, 2120.0, 2126.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2072, 'Stephanie Marshall', 'Michael Ferguson', 2063, 2062, 2080, 2084, 2065, 2064, 2061, 2143.0, 2151.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2073, 'Stephanie Marshall', 'Lori Clay', 2063, 2062, 2080, 2084, 2065, 2064, 2061, 2166.0, 2176.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2114, 'Stephanie Marshall', 'Michael White', 2107, 2106, 2124, 2128, 2109, 2108, 2105, 2141, 2145);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2115, 'Stephanie Marshall', 'Leon Reyes', 2107, 2106, 2124, 2128, 2109, 2108, 2105, 2164.0, 2170.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2116, 'Stephanie Marshall', 'Kathleen Aguilar', 2107, 2106, 2124, 2128, 2109, 2108, 2105, 2187.0, 2195.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2117, 'Stephanie Marshall', 'Mark Stevens', 2107, 2106, 2124, 2128, 2109, 2108, 2105, 2210.0, 2220.0);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2026, 2022);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2026, 2023);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2026, 2024);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2026, 2025);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2070, 2066);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2070, 2067);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2070, 2068);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2070, 2069);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2114, 2110);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2114, 2111);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2114, 2112);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (2114, 2113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id GROUP BY T1.superhero_name ORDER BY COUNT(T2.hero_id) DESC, T1.superhero_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Stephanie Marshall',)
*/

-- Prediction Query
SELECT superhero_name FROM superhero INNER JOIN hero_power ON superhero.id = hero_power.hero_id GROUP BY superhero.id ORDER BY COUNT(hero_power.hero_id) DESC, superhero_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Edwin Matthews',)
*/