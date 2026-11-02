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
INSERT INTO "alignment" ("id", "alignment") VALUES (1947, 'rather');
INSERT INTO "alignment" ("id", "alignment") VALUES (1948, 'understand');
INSERT INTO "alignment" ("id", "alignment") VALUES (1949, 'specific');
INSERT INTO "alignment" ("id", "alignment") VALUES (1950, 'ok');
INSERT INTO "alignment" ("id", "alignment") VALUES (1987, 'option');
INSERT INTO "alignment" ("id", "alignment") VALUES (1988, 'speak');
INSERT INTO "alignment" ("id", "alignment") VALUES (1989, 'tell');
INSERT INTO "alignment" ("id", "alignment") VALUES (1990, 'pretty');
INSERT INTO "colour" ("id", "colour") VALUES (1951, 'set');
INSERT INTO "colour" ("id", "colour") VALUES (1953, 'tree');
INSERT INTO "colour" ("id", "colour") VALUES (1954, 'dinner');
INSERT INTO "colour" ("id", "colour") VALUES (1991, 'law');
INSERT INTO "colour" ("id", "colour") VALUES (1952, 'positive');
INSERT INTO "colour" ("id", "colour") VALUES (1992, 'Republican');
INSERT INTO "colour" ("id", "colour") VALUES (1993, 'question');
INSERT INTO "colour" ("id", "colour") VALUES (1994, 'onto');
INSERT INTO "colour" ("id", "colour") VALUES (1971, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1975, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2011, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (2015, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1955, 'live');
INSERT INTO "gender" ("id", "gender") VALUES (1956, 'view');
INSERT INTO "gender" ("id", "gender") VALUES (1957, 'drive');
INSERT INTO "gender" ("id", "gender") VALUES (1958, 'job');
INSERT INTO "gender" ("id", "gender") VALUES (1995, 'politics');
INSERT INTO "gender" ("id", "gender") VALUES (1996, 'woman');
INSERT INTO "gender" ("id", "gender") VALUES (1997, 'really');
INSERT INTO "gender" ("id", "gender") VALUES (1998, 'themselves');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1959, 'Jesse Perry');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1960, 'Jeffery Ortega');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1961, 'Christian Leblanc');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1962, 'Ronald Davis');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1999, 'Alyssa Nelson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2000, 'Tammy Bell');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2001, 'Charles Sandoval');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (2002, 'Patrick Bonilla');
INSERT INTO "race" ("id", "race") VALUES (1963, 'big');
INSERT INTO "race" ("id", "race") VALUES (1964, 'single');
INSERT INTO "race" ("id", "race") VALUES (1965, 'hotel');
INSERT INTO "race" ("id", "race") VALUES (1966, 'task');
INSERT INTO "race" ("id", "race") VALUES (2003, 'benefit');
INSERT INTO "race" ("id", "race") VALUES (2004, 'skin');
INSERT INTO "race" ("id", "race") VALUES (2005, 'however');
INSERT INTO "race" ("id", "race") VALUES (2006, 'kind');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1968, 'Anthony Frye', 'Brian Romero', 1955, 1951, 1971, 1975, 1963, 1959, 1947, 1979, 2098.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1969, 'Meagan Jenkins', 'John Boone', 1955, 1951, 1971, 1975, 1963, 1959, 1947, 2002.0, 2008.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1970, 'Teresa Henderson', 'Justin Wilson', 1955, 1951, 1971, 1975, 1963, 1959, 1947, 2025.0, 2033.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2007, 'Amber Roberts', 'Darrell Patterson', 1955, 1951, 1971, 1975, 1963, 1959, 1947, 2048.0, 2058.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1967, 'Christopher Collins', 'Lawrence Perry', 1995, 1952, 2011, 2015, 2003, 1999, 1987, 1980, 2098.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2008, 'Todd Carlson', 'Jose Reed', 1995, 1952, 2011, 2015, 2003, 1999, 1987, 2042.0, 2048.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2009, 'Brittney Webster', 'Michael Watkins', 1995, 1952, 2011, 2015, 2003, 1999, 1987, 2065.0, 2073.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2010, 'Brad Ramos', 'Elizabeth Walker', 1995, 1952, 2011, 2015, 2003, 1999, 1987, 2088.0, 1983);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id ORDER BY T1.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('positive',)
*/

-- Prediction Query
SELECT T1.colour FROM colour AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.eye_colour_id ORDER BY T2.weight_kg DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('set',)
*/