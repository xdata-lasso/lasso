-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO visitor (id, name, level_of_membership, age) VALUES (4, NULL, 0, NULL), (3, NULL, 0, NULL), (1, 'default2', 1, 5), (0, 'default2', 5, 3), (5, 'default2', 5, NULL), (2, NULL, 4, NULL), (6, 'default2', 1, 3), (7, 'default1', 0, 1), (8, NULL, 3, NULL), (9, 'default1', 5, 0), (10, 'default1', 3, 5), (11, 'default1', 3, 1), (12, 'default2', 4, 4), (13, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, level_of_membership FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
('default1', 5)
('default2', 5)
('default2', 5)
*/

-- Prediction Query
SELECT name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY age DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('default2', 5)
('default1', 5)
('default2', 5)
*/