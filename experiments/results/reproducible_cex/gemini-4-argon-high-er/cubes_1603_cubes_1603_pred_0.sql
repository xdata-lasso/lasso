-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO church (Church_ID, Name, Organized_by, Open_Date, Continuation_of) VALUES (1, 'First Church', 'John Smith', 1800, 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organized_by, name FROM church WHERE (open_date < 1830 OR open_date <= 1840) ORDER BY organized_by, church.church_id NULLS LAST;

/*
Gold Result:
('John Smith', 'First Church')
*/

-- Prediction Query
SELECT organized_by, name FROM church WHERE open_date BETWEEN 1830 AND 1840;

/*
Prediction Result:
*/