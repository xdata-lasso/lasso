-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1610062532, -106629402, 1871297066, 809183447);

-- Inserting into table: concert --
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (-2147483648, '-2147483648', 'vfe4hria2', 'puzhsrw', 'con_27a24c');

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (2, '-2147483648', 'p', 'luhvdltti', '2014');

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (3, '-2147483648', 'n', 'rmdp', '2015');

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (4, '-2147483648', '5sw', 'qcgsk9', NULL);

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (5, '-2147483648', '8c4pgu7vfe', 'hria2ypu', NULL);

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (6, '-2147483648', 'sr', 'wbbp6luhvdlt', NULL);

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (7, '-2147483648', 'lbn', 'rmdp', NULL);

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (8, '-2147483648', 'siie5unw6k', 'fa9', NULL);

INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (9, '-2147483648', '00t5c4ecigc', 'e376nium52', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT concert_id, concert_name, theme, stadium_id, YEAR, COUNT(*) OVER () AS n FROM concert) WHERE (n <> 2014 OR YEAR <= 2015) ORDER BY count___;

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(*) FROM concert WHERE YEAR = 2014 OR YEAR = 2015;

/*
Prediction Result:
(2,)
*/