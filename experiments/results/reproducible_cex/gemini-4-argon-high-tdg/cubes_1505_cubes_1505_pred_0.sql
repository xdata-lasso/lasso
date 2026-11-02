-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Morning News', 'USA', 2010.0, 'Other Corp');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'Evening Show', 'UK', 2015.0, 'Alpha Media');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (3, 'Late Night', 'Canada', 2018.0, 'Alpha Media');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Ch One', 'Beta Corp', 30.0, 12.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Ch Two', 'Alpha Media', 10.0, 4.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Ch Three', 'Alpha Media', 15.0, 4.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'Ch Four', 'Alpha Media', 20.0, 6.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (5, 'Ch Five', 'Gamma Net', 25.0, 2.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (6, 'Ch Six', 'Gamma Net', 5.0, 3.5);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 1, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 2, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 1, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 2, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 3, 'Afternoon');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 1, '2023-01-01', 14.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 2, '2023-01-02', 16.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (2, 1, '2023-01-01', 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrating_in_percent AS sum_rating_in_percent_, OWNER FROM (SELECT OWNER, SUM(rating_in_percent) AS sumrating_in_percent FROM channel GROUP BY OWNER) ORDER BY sum_rating_in_percent_, OWNER NULLS LAST;

/*
Gold Result:
(6.0, 'Gamma Net')
(12.0, 'Beta Corp')
(15.0, 'Alpha Media')
*/

-- Prediction Query
SELECT SUM(Rating_in_percent), OWNER FROM channel GROUP BY OWNER;

/*
Prediction Result:
(15.0, 'Alpha Media')
(12.0, 'Beta Corp')
(6.0, 'Gamma Net')
*/