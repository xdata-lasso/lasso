-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (10, 'Zoe Bell', 21.0, 160.0, 'Chicago');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (20, 'Yuri Petrov', 25.0, 172.0, 'Moscow');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (30, 'Xavier Woods', 20.0, 169.0, 'Atlanta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (40, 'Will Frost', 27.0, 178.0, 'Dallas');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (30, 10.5, 11.0, 12.0, 13.0, 14.0, 15.0, 75.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (10, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, NULL);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (40, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (20, 13.0, 13.0, 13.0, 13.0, 13.0, 13.0, 88.2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(None,)
(0.0,)
(75.5,)
(88.2,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Floor_Exercise_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(None,)
(88.2,)
(75.5,)
(0.0,)
*/