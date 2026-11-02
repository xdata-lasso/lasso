-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alex Rivera', 24.0, 170.5, 'Denver');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Blake Chen', 19.0, 165.0, 'Austin');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Casey Jordan', 28.0, 175.2, 'Seattle');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'Dana Kim', 22.0, 168.0, 'Boston');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (5, 'Eli Vance', 30.0, 180.0, 'Miami');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 14.5, 13.8, 14.2, 15.1, 14.9, 13.5, 86.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 15.2, 14.9, 15.0, 13.2, 15.5, 14.8, 82.4);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (3, 12.1, 15.3, 13.1, 14.8, 12.0, 15.9, 91.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (4, 13.9, 12.5, 14.7, 14.0, 13.8, 14.1, 86.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(82.4,)
(86.0,)
(86.0,)
(91.5,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Total_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(91.5,)
(86.0,)
(86.0,)
(82.4,)
*/