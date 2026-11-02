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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1232, 1236, '1979-09-05', 'Michael Mccarthy', '1983-02-09', 'https://bender.biz/', '2046 Lewis Islands
Kathleenfurt, KY 99068', 'research', 1240, 1244, 1248, 1252, 1256, 'http://www.vaughn.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1233, 1241.0, '1979-09-06', 'Jason Daniels', '1983-02-10', 'https://www.robinson-graham.com/', 'USCGC King
FPO AE 62145', 'whatever', 1259.0, 1265.0, 1271.0, 1277.0, 1283.0, 'http://www.patel-stanley.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1234, 1246.0, '1979-09-07', 'Daniel Fisher', '1983-02-11', 'https://shelton.info/', '3100 James Brooks
East David, TN 15494', 'how', 1278.0, 1286.0, 1294.0, 1302.0, 1310.0, 'https://www.short-garcia.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1235, 1251.0, '1979-09-08', 'Lauren Dominguez', '1983-02-12', 'http://www.vargas-alvarado.com/', '4529 Kimberly Estates
Danieltown, ME 75971', 'industry', 1297.0, 1307.0, 1317.0, 1327.0, 1337.0, 'https://www.thompson-boyd.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1308, 1312, '1982-08-14', 'Bryan Lee', '1986-01-18', 'https://www.phillips.com/', '16719 Edward Valleys Suite 131
Obrienbury, WI 68995', 'leg', 1316, 1320, 1324, 1328, 1332, 'https://mason-snyder.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1309, 1317.0, '1982-08-15', 'Joshua Gill', '1986-01-19', 'https://www.ferguson.net/', '9649 Chelsea Streets Apt. 334
East Johnside, CA 21018', 'capital', 1335.0, 1341.0, 1347.0, 1353.0, 1359.0, 'http://morris.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1310, 1322.0, '1982-08-16', 'Daniel Washington', '1986-01-20', 'https://www.oneill.org/', '974 Jesse Squares Suite 713
Kristinshire, TN 26429', 'management', 1354.0, 1362.0, 1370.0, 1378.0, 1386.0, 'http://williams.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1311, 1327.0, '1982-08-17', 'Vanessa Warren', '1986-01-21', 'https://alexander-lopez.com/', '242 Brian Turnpike
Brookeshire, PW 38329', 'risk', 1373.0, 1383.0, 1393.0, 1403.0, 1413.0, 'https://www.graham.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1292, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1368, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1260, 1264, 1268, '1987-06-13', 1272, 1276, 'power', 1232, '1991-10-17', 'Radio broadcast assistant', 'executive', 1280, 1284, 1288, 1292, '1995-03-21', '1970-07-02', 1296, '1974-11-06', 'Angelica Keith', 'Spencer Haynes');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1261, 1269.0, 1275.0, '1987-06-14', 1283.0, 1289.0, 'system', 1232, '1991-10-18', 'Psychologist, occupational', 'future', 1305.0, 1311.0, 1317.0, 1292, '1995-03-22', '1970-07-03', 1333.0, '1974-11-07', 'John Bishop', 'Adam Vaughan');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1262, 1274.0, 1282.0, '1987-06-15', 1294.0, 1302.0, 'wide', 1232, '1991-10-19', 'Press photographer', 'together', 1330.0, 1338.0, 1346.0, 1292, '1995-03-23', '1970-07-04', 1370.0, '1974-11-08', 'Allen Rosales', 'Nathan Freeman');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1263, 1279.0, 1289.0, '1987-06-16', 1305.0, 1315.0, 'nothing', 1232, '1991-10-20', 'Therapist, drama', 'else', 1355.0, 1365.0, 1375.0, 1292, '1995-03-24', '1970-07-05', 1407.0, '1974-11-09', 'Daniel Salinas', 'Melissa Brewer');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1336, NULL, 1344, '1990-05-22', 1348, 1352, 'happen', 1308, '1994-09-03', 'Civil Service fast streamer', 'rule', 1356, 1360, 1364, 1368, '1998-02-07', '1973-06-11', 1372, '1977-10-15', 'Robin Pierce', 'Isaiah Avila');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1337, NULL, 1351.0, '1990-05-23', 1359.0, 1365.0, 'issue', 1308, '1994-09-04', 'Designer, multimedia', 'mission', 1381.0, 1387.0, 1393.0, 1368, '1998-02-08', '1973-06-12', 1409.0, '1977-10-16', 'Ernest Morris', 'Olivia Harris');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1338, NULL, 1358.0, '1990-05-24', 1370.0, 1378.0, 'goal', 1308, '1994-09-05', 'Landscape architect', 'fight', 1406.0, 1414.0, 1422.0, 1368, '1998-02-09', '1973-06-13', 1446.0, '1977-10-17', 'Jennifer Robertson', 'Tanya Kim');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1339, NULL, 1365.0, '1990-05-25', 1381.0, 1391.0, 'full', 1308, '1994-09-06', 'Paramedic', 'recognize', 1431.0, 1441.0, 1451.0, 1368, '1998-02-10', '1973-06-14', 1483.0, '1977-10-18', 'Mary Daniels MD', 'Barbara Dudley');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1300, 1260, 1304, 'military', '1978-04-10', 1232, 'Daniel Holt');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1301, 1260, 1311.0, 'line', '1978-04-11', 1232, 'Kevin Kennedy');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1302, 1260, 1318.0, 'structure', '1978-04-12', 1232, 'Jessica Reese');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1303, 1260, 1325.0, 'adult', '1978-04-13', 1232, 'Michael Nelson');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1376, 1336, 1380, 'politics', '1981-03-19', 1308, 'Juan Tran');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1377, 1336, 1387.0, 'successful', '1981-03-20', 1308, 'Willie Durham');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1378, 1336, 1394.0, 'education', '1981-03-21', 1308, 'Bruce Collier');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1379, 1336, 1401.0, 'security', '1981-03-22', 1308, 'Dr. Jordan Hill PhD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T3.PostId = T2.Id ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT (SELECT COUNT(Id) FROM posts WHERE OwnerUserId = (SELECT T1.Id FROM users AS T1 WHERE T1.Id IN (SELECT OwnerUserId FROM posts UNION SELECT UserId FROM comments) ORDER BY T1.CreationDate DESC, T1.id NULLS LAST LIMIT 1)), (SELECT COUNT(Id) FROM comments WHERE UserId = (SELECT T1.Id FROM users AS T1 WHERE T1.Id IN (SELECT OwnerUserId FROM posts UNION SELECT UserId FROM comments) ORDER BY T1.CreationDate DESC, T1.id NULLS LAST LIMIT 1));

/*
Prediction Result:
(4, 4)
*/