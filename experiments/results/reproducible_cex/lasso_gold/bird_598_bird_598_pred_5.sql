-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1085, 1087, '1992-01-23', 'Sandra Williams', '1994-03-02', 'http://thornton.com/', 'PSC 0533, Box 1586
APO AP 98736', 'idea', 1089, 1091, 1093, 1095, 1097, 'http://gonzalez.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1086, 1092.0, '1992-01-24', 'Carlos Whitney', '1994-03-03', 'http://tran.com/', '26025 Pham Way
West Erik, UT 14669', 'turn', 1108.0, 1112.0, 1116.0, 1120.0, 1124.0, 'https://www.johnson.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1101, 1103, '1996-05-04', 'Sean Rasmussen', '1998-07-06', 'https://www.wiley.com/', '9340 Smith Valley
West Ryan, TN 43780', 'yard', 1105, 1107, 1109, 1111, 1113, 'http://kelley-smith.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1102, 1108.0, '1996-05-05', 'Martin Ross', '1998-07-07', 'https://www.carlson.com/', '484 Nguyen Square
Angelaborough, MT 87654', 'hundred', 1124.0, 1128.0, 1132.0, 1136.0, 1140.0, 'http://lawson.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1117, 1119, '1971-09-08', 'Rebecca Moyer', '1973-11-10', 'https://www.chambers.com/', '6936 Ross Drive
Port Michelleville, WI 56225', 'six', 1121, 1123, 1125, 1127, 1129, 'https://walton-larsen.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1118, 1124.0, '1971-09-09', 'Mary Campbell', '1973-11-11', 'http://www.sanchez.org/', '83172 Contreras Points Suite 798
Rivasside, NV 21362', 'training', 1140.0, 1144.0, 1148.0, 1152.0, 1156.0, 'https://www.gonzales-reeves.com/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1099, 1085, 'Student', '2010-01-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1100, 1085, 'Student', '2011-01-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1115, NULL, 'Student', '2010-01-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1116, NULL, 'Student', '2011-01-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1131, 1117, 'Student', '2010-01-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1132, 1117, 'Student', '2011-01-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1133, NULL, 'Student', '2010-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', Date) = '2010', 1, 0)) AS REAL) * 100 / COUNT(Id) - CAST(SUM(IIF(STRFTIME('%Y', Date) = '2011', 1, 0)) AS REAL) * 100 / COUNT(Id) FROM badges WHERE Name = 'Student';

/*
Gold Result:
(14.285714285714292,)
*/

-- Prediction Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', Date) = '2010' THEN 1 ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', Date) = '2011' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(*) FROM badges WHERE Name = 'Student';

/*
Prediction Result:
(14.285714285714286,)
*/