-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, date_of_birth) VALUES (0, 'default2', 1.0, NULL, 'default2'), (1, 'default2', 1.0, 1.0, NULL), (2, NULL, NULL, 1.0, NULL), (3, 'default2', 1.0, 0.0, NULL), (4, 'default2', 1.0, 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM People ORDER BY Weight ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default2',)
('default2',)
('default2',)
(None,)
*/