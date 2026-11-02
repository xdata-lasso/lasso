-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Is_Male" TEXT, "Age" INTEGER);

CREATE TABLE "church" ("Church_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Organized_by" TEXT, "Open_Date" INTEGER, "Continuation_of" TEXT);

CREATE TABLE "wedding" ("Church_ID" INTEGER, "Male_ID" INTEGER, "Female_ID" INTEGER, "Year" INTEGER, PRIMARY KEY ("Church_ID", "Male_ID", "Female_ID"), FOREIGN KEY ("Female_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Male_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Church_ID") REFERENCES "church" ("Church_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO church (church_id, name, organized_by, open_date, continuation_of) VALUES (0, 'default2', NULL, 1, 'default2'), (1, NULL, NULL, 1, NULL), (2, 'default1', 'default2', NULL, NULL), (3, NULL, 'default1', 0, 'default1'), (4, 'default1', 'default1', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM church ORDER BY name, church.church_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM church ORDER BY open_date DESC, church.church_id NULLS LAST;

/*
Prediction Result:
('default2',)
(None,)
(None,)
('default1',)
('default1',)
*/