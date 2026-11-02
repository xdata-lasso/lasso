-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO church (Church_ID, Name, Open_Date) VALUES (1, 'A', 2000);
INSERT INTO church (Church_ID, Name, Open_Date) VALUES (2, 'B', 1990);
INSERT INTO church (Church_ID, Name, Open_Date) VALUES (3, 'C', 1980);
INSERT INTO church (Church_ID, Name, Open_Date) VALUES (4, 'D', 1970);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_date FROM (SELECT * FROM (SELECT * FROM church ORDER BY church_id DESC) LIMIT 3);

/*
Gold Result:
('D', 1970)
('C', 1980)
('B', 1990)
*/

-- Prediction Query
SELECT name, open_date FROM church ORDER BY open_date DESC, church.church_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('A', 2000)
('B', 1990)
('C', 1980)
*/