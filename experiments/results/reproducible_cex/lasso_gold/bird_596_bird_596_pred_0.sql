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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1235, 1239, '1982-01-08', 'Ross Price', '1986-05-12', 'https://www.robinson-graham.com/', '6464 Thomas Summit Apt. 531
Port Anthonybury, ID 03172', 'make', 1243, 1247, 1251, 1255, 1259, 'https://rivas.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1236, 1244.0, '1982-01-09', 'Theresa Smith', '1986-05-13', 'https://shelton.info/', '71937 Wang Expressway
Port Loriport, CT 76350', 'least', 1262.0, 1268.0, 1274.0, 1280.0, 1286.0, 'https://www.hudson-barnett.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1237, 1249.0, '1982-01-10', 'Laura Woods', '1986-05-14', 'http://www.vargas-alvarado.com/', '663 Brittany Village Apt. 149
Port Tonyaton, MI 70328', 'that', 1281.0, 1289.0, 1297.0, 1305.0, 1313.0, 'http://white-lewis.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1238, 1254.0, '1982-01-11', 'Elizabeth Price', '1986-05-15', 'https://www.white-green.com/', '85067 Ryan Lake Suite 262
Christinaside, WI 63873', 'side', 1300.0, 1310.0, 1320.0, 1330.0, 1340.0, 'https://haynes.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1467, 1471, '1994-01-15', 'Andrew Ferrell', '1998-05-19', 'http://garcia.com/', 'Unit 0532 Box 9318
DPO AE 77359', 'where', 1475, 1479, 1483, 1487, 1491, 'http://hernandez.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1468, 1476.0, '1994-01-16', 'David Medina', '1998-05-20', 'http://ramos.com/', '2904 Vanessa Plains
Laurenville, TN 03880', 'life', 1494.0, 1500.0, 1506.0, 1512.0, 1518.0, 'https://schmidt.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1469, 1481.0, '1994-01-17', 'Jacob Avery', '1998-05-21', 'http://winters.com/', '95024 David Manor Apt. 177
Williamville, NV 66540', 'back', 1513.0, 1521.0, 1529.0, 1537.0, 1545.0, 'http://www.hayes-perez.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1470, 1486.0, '1994-01-18', 'Kimberly Matthews', '1998-05-22', 'http://www.davis-lewis.org/', '847 Bruce Neck
Simmonsville, NM 93876', 'way', 1532.0, 1542.0, 1552.0, 1562.0, 1572.0, 'https://blair-edwards.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1284, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1516, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1263, 1235, 'Nathan Freeman', '1990-09-16');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1495, 1467, 'Jacqueline Hernandez', '1973-09-23');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1264, 1268, 1272, '1991-10-17', 1276, 1280, 'son', 1284, '1995-03-21', 'Recycling officer', 'financial', 1288, 1292, 1296, 1235, '1970-07-02', '1974-11-06', 1300, '1978-04-10', 'Matthew Wood', 'Patrick Tapia');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1265, 1273.0, 1279.0, '1991-10-18', 1287.0, 1293.0, 'effect', 1284, '1995-03-22', 'Product/process development scientist', 'do', 1313.0, 1319.0, 1325.0, 1235, '1970-07-03', '1974-11-07', 1337.0, '1978-04-11', 'Hailey Barajas', 'Cheryl Rodgers');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1266, 1278.0, 1286.0, '1991-10-19', 1298.0, 1306.0, 'rock', 1284, '1995-03-23', 'Adult guidance worker', 'interview', 1338.0, 1346.0, 1354.0, 1235, '1970-07-04', '1974-11-08', 1374.0, '1978-04-12', 'Heather Chavez', 'Kevin Wolf');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1267, 1283.0, 1293.0, '1991-10-20', 1309.0, 1319.0, 'maybe', 1284, '1995-03-24', 'Chief Financial Officer', 'role', 1363.0, 1373.0, 1383.0, 1235, '1970-07-05', '1974-11-09', 1411.0, '1978-04-13', 'David Griffith', 'Veronica Wall');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1496, 1500, 1504, '1974-10-01', 1508, 1512, 'wind', 1516, '1978-03-05', 'Chartered certified accountant', 'task', 1520, 1524, 1528, 1467, '1982-07-09', '1986-11-13', 1532, '1990-04-17', 'Kristina Rivera', 'Christy Douglas');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1497, 1505.0, 1511.0, '1974-10-02', 1519.0, 1525.0, 'matter', 1516, '1978-03-06', 'Podiatrist', 'case', 1545.0, 1551.0, 1557.0, 1467, '1982-07-10', '1986-11-14', 1569.0, '1990-04-18', 'Hayden Ortega', 'Brian Bruce');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1498, 1510.0, 1518.0, '1974-10-03', 1530.0, 1538.0, 'audience', 1516, '1978-03-07', 'Chief Operating Officer', 'only', 1570.0, 1578.0, 1586.0, 1467, '1982-07-11', '1986-11-15', 1606.0, '1990-04-19', 'Shawna Griffith', 'Phillip Andrews');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1499, 1515.0, 1525.0, '1974-10-04', 1541.0, 1551.0, 'theory', 1516, '1978-03-08', 'Microbiologist', 'as', 1595.0, 1605.0, 1615.0, 1467, '1982-07-12', '1986-11-16', 1643.0, '1990-04-20', 'Lindsay Bell', 'Sarah Villegas');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1304, 1264, 1308, 'fine', '1982-08-14', 1235, 'Michael Martinez');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1305, 1264, 1315.0, 'dream', '1982-08-15', 1235, 'Anthony Carter');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1306, 1264, 1322.0, 'herself', '1982-08-16', 1235, 'Margaret Mullins');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1307, 1264, 1329.0, 'country', '1982-08-17', 1235, 'Adam Mitchell');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1536, NULL, 1540, 'tell', '1994-08-21', 1467, 'Allison Hickman');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1537, NULL, 1547.0, 'pretty', '1994-08-22', 1467, 'Debra White');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1538, NULL, 1554.0, 'positive', '1994-08-23', 1467, 'Ellen Morgan');
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1539, NULL, 1561.0, 'Republican', '1994-08-24', 1467, 'Sergio Knight');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('Jacqueline Hernandez',)
*/

-- Prediction Query
SELECT T1.UserId, T2.Name FROM comments AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId GROUP BY T1.UserId ORDER BY COUNT(T1.Id) DESC, T1.UserId NULLS LAST, T2.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
(1235, 'Nathan Freeman')
*/