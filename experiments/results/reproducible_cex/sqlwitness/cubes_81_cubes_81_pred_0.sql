-- Schema DDL
CREATE TABLE "museum" ("Museum_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Staff" INTEGER, "Open_Year" TEXT);

CREATE TABLE "visitor" ("ID" INTEGER PRIMARY KEY, "Name" TEXT, "Level_of_membership" INTEGER, "Age" INTEGER);

CREATE TABLE "visit" ("Museum_ID" INTEGER, "visitor_ID" TEXT, "Num_of_Ticket" INTEGER, "Total_spent" REAL, PRIMARY KEY ("Museum_ID", "visitor_ID"), FOREIGN KEY ("visitor_ID") REFERENCES "visitor" ("ID"), FOREIGN KEY ("Museum_ID") REFERENCES "museum" ("Museum_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO visitor (id, name, level_of_membership, age) VALUES (4, NULL, NULL, 4), (1, 'default2', 0, 1), (5, 'default1', 4, NULL), (3, 'default2', 4, 4), (0, 'default2', 5, 1), (2, 'default1', 5, 3), (6, NULL, 4, 3), (7, NULL, NULL, 4), (8, 'default1', 3, 5), (9, NULL, 5, 1), (10, 'default2', 1, 4), (11, NULL, 3, 0), (12, 'default1', 4, 4), (13, 'default1', 4, 3), (14, NULL, 0, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM visitor WHERE (level_of_membership > 4) ORDER BY name, visitor.id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC, visitor.id NULLS LAST;

/*
Prediction Result:
('default2',)
('default1',)
(None,)
*/