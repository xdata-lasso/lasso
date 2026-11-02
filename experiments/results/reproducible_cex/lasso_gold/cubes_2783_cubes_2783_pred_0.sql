-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1042, 'Timothy Wong', 1043.5, 1044.5, 'politics');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1047, 'Timothy Watts', 1048.5, 1049.5, 'discuss');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1052, 'Ethan Adams', 1053.5, 1054.5, 'development');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1045, 1042, 'Jackson, Daniel and Martin', 100, 'hundred');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1050, 1047, 'Jackson, Daniel and Martin', -50, 'term');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1055, 1052, 'Ellis, Baker and Wright', 80, 'individual');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('Ellis, Baker and Wright',)
('Jackson, Daniel and Martin',)
('Jackson, Daniel and Martin',)
*/

-- Prediction Query
SELECT Company FROM entrepreneur ORDER BY Money_Requested DESC, entrepreneur.entrepreneur_id NULLS LAST;

/*
Prediction Result:
('Jackson, Daniel and Martin',)
('Ellis, Baker and Wright',)
('Jackson, Daniel and Martin',)
*/