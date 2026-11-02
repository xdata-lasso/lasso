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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1001, 1006, '1970-01-01', 'Matt Parker', '1975-06-06', 'http://www.hill.net/', '78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'building', 1011, 1016, 1021, 1026, 1031, 'https://carter.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1002, 1011.0, '1970-01-02', 'Matt Parker', '1975-06-07', 'http://johnson.com/', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'rest', 1030.0, 1037.0, 1044.0, 1051.0, 1058.0, 'http://gill.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1003, 1016.0, '1970-01-03', 'Matt Parker', '1975-06-08', 'http://www.santos.org/', '503 Linda Locks
Carlshire, FM 94599', 'value', 1049.0, 1058.0, 1067.0, 1076.0, 1085.0, 'http://www.farmer-ryan.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1004, 1021.0, '1970-01-04', 'Matt Parker', '1975-06-09', 'https://www.wolfe.com/', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'not', 1068.0, 1079.0, 1090.0, 1101.0, 1112.0, 'http://smith-hickman.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1005, 1026.0, '1970-01-05', 'Matt Parker', '1975-06-10', 'http://www.garcia-james.com/', '22691 James Mountain
Tashatown, TX 94967', 'social', 1087.0, 1100.0, 1113.0, 1126.0, 1139.0, 'http://www.humphrey.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1061, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1036, 1041, 1046, '1980-11-11', 1051, 1056, 'sign', 1061, '1985-05-16', 'Site engineer', 'company', 1066, 1071, 1076, 1001, '1990-10-21', '1995-04-03', 1081, '1971-09-08', 'Daniel Ryan', 'Mark Perez');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1037, 1046.0, 1053.0, '1980-11-12', 1062.0, 1069.0, 'mention', 1061, '1985-05-17', 'Comptroller', 'evidence', 1091.0, 1098.0, 1105.0, 1001, '1990-10-22', '1995-04-04', 1118.0, '1971-09-09', 'Christina Collins', 'Shannon Jones');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1038, 1051.0, 1060.0, '1980-11-13', 1073.0, 1082.0, 'team', 1061, '1985-05-18', 'Conservation officer, historic buildings', 'news', 1116.0, 1125.0, 1134.0, 1001, '1990-10-23', '1995-04-05', 1155.0, '1971-09-10', 'Marie Kim DDS', 'Michael Lewis');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1039, 1056.0, 1067.0, '1980-11-14', 1084.0, 1095.0, 'authority', 1061, '1985-05-19', 'Public relations officer', 'turn', 1141.0, 1152.0, 1163.0, 1001, '1990-10-24', '1995-04-06', 1192.0, '1971-09-11', 'Danny Morgan', 'Timothy Duncan');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1040, 1061.0, 1074.0, '1980-11-15', 1095.0, 1108.0, 'soon', 1061, '1985-05-20', 'Stage manager', 'policy', 1166.0, 1179.0, 1192.0, 1001, '1990-10-25', '1995-04-07', 1229.0, '1971-09-12', 'Crystal Robinson', 'Richard Aguirre');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1086, 1091, 1036, 'a8b317fa-18d0-452b-9825-bc5430beb45f', '1976-03-13', 1001, 'group', 'Couple large instead everything economic.', 'Edward Novak');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1087, 1096.0, 1036, '693dffbc-6c6f-4611-9ab3-3edf6e595ed3', '1976-03-14', 1001, 'such', 'Kitchen technology nearly anything.', 'Kimberly Adkins');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1088, 1101.0, 1036, '0dde29a6-baa4-471a-9d24-67ac778eedb3', '1976-03-15', 1001, 'training', 'Structure why unit support coach magazine degree.', 'Kevin Shaw');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1089, 1106.0, 1036, 'a56c0941-fbf2-4050-a748-dbcfac619e63', '1976-03-16', 1001, 'boy', 'Total clearly able hospital unit size.', 'Brooke Yu');
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1090, 1111.0, 1036, 'ba6c34ab-6712-403a-8f84-4fef1931e9ee', '1976-03-17', 1001, 'energy', 'Institution whatever yet new responsibility.', 'Cody Larson');
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1096, 1036, 1101, '1981-08-18', 1001, 1106);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1097, 1036, 1108.0, '1981-08-19', 1001, 1119.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1098, 1036, 1115.0, '1981-08-20', 1001, 1132.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1099, 1036, 1122.0, '1981-08-21', 1001, 1145.0);
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1100, 1036, 1129.0, '1981-08-22', 1001, 1158.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id INNER JOIN votes AS T4 ON T4.PostId = T3.Id WHERE T1.DisplayName = 'Matt Parker' GROUP BY T2.PostId, T4.Id HAVING COUNT(T4.Id) > 4;

/*
Gold Result:
(5,)
(5,)
(5,)
(5,)
(5,)
*/

-- Prediction Query
SELECT COUNT(T1.Id) FROM posts AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.PostId INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id WHERE T3.DisplayName = 'Matt Parker' AND T2.PostId > 4;

/*
Prediction Result:
(0,)
*/