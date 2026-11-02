-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Zorba', 1969, 'Tony Award', 'Best Musical', 'Harold Prince', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Sweet Charity', 1966, 'Tony Award', 'Best Choreography', 'Bob Fosse', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'Chicago', 1976, 'Tony Award', 'Best Director', 'Bob Fosse', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (4, 'Pippin', 1973, 'Tony Award', 'Best Director', 'Bob Fosse', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (5, 'Pippin', 1973, 'Drama Desk Award', 'Outstanding Director', 'Bob Fosse', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (6, 'Cabaret', 1967, 'Tony Award', 'Best Choreography', 'bob fosse', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (7, 'Dancin', 1978, 'Tony Award', 'Best Choreography', 'Bob Fosse Jr.', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (8, 'All That Jazz', 1979, 'Tony Award', 'Best Choreography', NULL, 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Zero Mostel', 'Zorba', '1968-1969', 53);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 2, 'Gwen Verdon', 'Charity', '1966-1967', 41);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "musical" WHERE ("nominee" = 'Bob Fosse') ORDER BY name, musical.musical_id NULLS LAST;

/*
Gold Result:
('Chicago',)
('Pippin',)
('Pippin',)
('Sweet Charity',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE Nominee = 'Bob Fosse';

/*
Prediction Result:
('Sweet Charity',)
('Chicago',)
('Pippin',)
('Pippin',)
*/