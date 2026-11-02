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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1001, 1005, '1970-01-01', 'Harvey Motulsky', '1974-05-05', 'http://www.hill.net/', '16155 Roman Stream Suite 816
New Kellystad, OK 25704', 'benefit', 1009, 1013, 1017, 1021, 1025, 'http://www.moore.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1002, 1010.0, '1970-01-02', 'Harvey Motulsky', '1974-05-06', 'http://johnson.com/', '341 Michelle Light
Shawnstad, GA 49021', 'someone', 1028.0, 1034.0, 1040.0, 1046.0, 1052.0, 'https://king.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1003, 1015.0, '1970-01-03', 'Harvey Motulsky', '1974-05-07', 'http://www.santos.org/', '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 'anyone', 1047.0, 1055.0, 1063.0, 1071.0, 1079.0, 'https://carter.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1004, 1020.0, '1970-01-04', 'Harvey Motulsky', '1974-05-08', 'https://www.wolfe.com/', '76724 John Points Suite 969
Coxberg, NY 65187', 'traditional', 1066.0, 1076.0, 1086.0, 1096.0, 1106.0, 'http://gill.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1049, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1029, 1033, 1037, '1978-09-09', 1041, 1045, 'thought', 1049, '1982-02-13', 'Engineer, civil (contracting)', 'notice', 1053, 1057, 1061, 1001, '1986-06-17', '1990-10-21', 1065, '1994-03-02', 'Linda Burns', 'Vanessa Patel');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1030, 1038.0, 1044.0, '1978-09-10', 1052.0, 1058.0, 'purpose', 1049, '1982-02-14', 'Designer, ceramics/pottery', 'start', 1078.0, 1084.0, 1090.0, 1001, '1986-06-18', '1990-10-22', 1102.0, '1994-03-03', 'Jack Galloway', 'Matthew Arroyo');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1031, 1043.0, 1051.0, '1978-09-11', 1063.0, 1071.0, 'movement', 1049, '1982-02-15', 'Midwife', 'win', 1103.0, 1111.0, 1119.0, 1001, '1986-06-19', '1990-10-23', 1139.0, '1994-03-04', 'Cynthia Allen', 'Joseph Obrien');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1032, 1048.0, 1058.0, '1978-09-12', 1074.0, 1084.0, 'politics', 1049, '1982-02-16', 'Designer, television/film set', 'nice', 1128.0, 1138.0, 1148.0, 1001, '1986-06-20', '1990-10-24', 1176.0, '1994-03-05', 'Angela Dennis', 'Tanya Campos');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1069, 1073, 1029, '4fcca39a-b683-42e6-b37e-a2dfb09b2a5c', '1998-07-06', 1001, 'attack', 'Discover detail audience piece director town teacher.', 'Scott Wright');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1070, 1078.0, 1029, 'a65e688e-abf3-4d39-bec2-1bbe66245bfa', '1998-07-07', 1001, 'ground', 'Method everything magazine much.', 'Jerry Henderson');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1071, 1083.0, 1029, '847fd9b4-e64d-4bcb-b027-53a15f987c71', '1998-07-08', 1001, 'against', 'Office drug list imagine behind probably great.', 'David Leblanc');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1072, 1088.0, 1029, '3985c3cf-3f76-4e1d-9efa-21977394988f', '1998-07-09', 1001, 'per', 'Level rock pull worker better I.', 'Scott Pierce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Harvey Motulsky' OR T1.DisplayName = 'Noah Snyder' GROUP BY T1.DisplayName ORDER BY SUM(T3.ViewCount) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Harvey Motulsky',)
*/

-- Prediction Query
SELECT DisplayName FROM (SELECT u.DisplayName, SUM(p.ViewCount) AS TotalViewCount FROM users AS u JOIN posts AS p ON u.Id = p.OwnerUserId WHERE u.DisplayName IN ('Harvey Motulsky', 'Noah Snyder') GROUP BY u.DisplayName ORDER BY TotalViewCount DESC, u.DisplayName NULLS LAST LIMIT 1) AS HigherPopularityUser;

/*
Prediction Result:
*/