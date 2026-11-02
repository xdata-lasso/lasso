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
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 462974032, -1137908826, '2025-04-09 18:22:58+00:00', 2026480202, -1576219117, '5u', 1, '2021-11-09 05:42:50+00:00', '6klfa9', '00t5c4e', 1274489983, -1683203397, 528680845, 1, '2023-12-22 03:17:01+00:00', '2024-05-26 02:52:16+00:00', -1585009206, '2021-08-19 01:10:02+00:00', '52zbuo4nrq', 'rofqyp5s5b');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-06-15 00:00:00+00:00', 'swwqcgsk', '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2122220075, 1, 'p6luhvdlttil');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 2137741668, '2024-06-15 00:00:00+00:00', 'ytoo3o9hl7', '2023-10-09 18:36:37+00:00', 'lex', '4ji7zwa', '2dwyrq', -1097120355, 244829661, -1362461264, -904834265, 1, 'b4yp5qi');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -227162283, '2024-06-15 00:00:00+00:00', 'f9v', '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 'vy9uxj4', -1612443122, -2050247126, -736979194, 2103044118, 1, 'h2gndqwnqcx5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1748371085, '2020-10-20 06:14:04+00:00', '8n2f3', '2025-11-06 14:42:57+00:00', 'q', '0gcb98', 'zk3z', 1686459626, -1554531873, 982314585, 638024588, -688098735, '6ah');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1255343543, '2020-03-06 15:32:29+00:00', '72fxa7ryfd', '2022-05-09 09:35:03+00:00', 'z16nijjai5d', 'h5ogrgjd8yz', '1afgo', -1696173285, 710458518, 678047687, -1478134144, -491938169, '1q43');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1364429300, '2025-02-07 06:53:31+00:00', 'prmd', '2021-12-31 07:20:26+00:00', 'siie', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, -53231346, -443340271, 'uo4nrqrofqy');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 882961052, '2025-09-22 03:26:15+00:00', 'eutliqa1', '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1649269347, '2025-02-03 05:21:58+00:00', '5qi2', '2022-04-27 23:55:02+00:00', 'f9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', '2020-05-10 07:36:02+00:00', 'rjtu', 'dz79fjg', '8n2f3', 806170397, 513454646, -688216274, 331812443, 1382410067, '9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, -688098735, '2021-05-17 23:21:59+00:00', 'ah0f8jsww', '2021-07-03 08:58:16+00:00', '7xb72', 'xa', '7ryfdrz16n', -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 'rg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, 2107872094, 'http://', '2023-07-13 23:57:06+00:00', 1, '2eutliqa11r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, -2147483648, -1245312912, 'http://', '2022-01-23 03:13:33+00:00', 2, 'jtu0d');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, -2147483648, -348113485, 'http://', '2024-07-11 21:09:52+00:00', 3, 'sww');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -2147483648, 1235416111, 'http://', '2023-08-17 20:15:35+00:00', 4, 'jh3den8c68');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, -2147483648, 1774087382, 'http://', '2020-02-13 02:40:04+00:00', 4, 'x');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -2147483648, 2078438287, 'http://', '2022-09-01 11:41:59+00:00', 4, 'w1of77pz');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, -2147483648, 1992637800, 'http://', '2022-08-17 19:55:37+00:00', 1, 'c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, -2147483648, -1284905200, 'http://', '2020-11-14 00:31:21+00:00', 1, '2g0v5q8qd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, -2147483648, 1897687032, 'A', '2023-10-10 11:56:21+00:00', 1, '78507cvt');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, -2147483648, 1, NULL, '2024-06-15 00:00:00+00:00', 5, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, -2147483648, 2122220075, 'http://', '2022-01-03 02:42:55+00:00', 6, 'luhvdltti');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, -921187550, 'http://', '2020-02-25 10:33:58+00:00', 8, 'p');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, -2147483648, -1362461264, 'http://', '2022-06-17 21:46:26+00:00', 10, '0b4');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, 1581736075, 'http://', '2023-09-26 13:08:37+00:00', 12, 'nd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, -2147483648, 1606439408, 'http://', '2021-05-16 14:38:12+00:00', 14, 'zbilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, -2147483648, -458359144, 'http://', '2025-06-10 19:01:27+00:00', 16, 'afgogri');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreationDate, T2.Age FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.text LIKE '%http://%';

/*
Gold Result:
('2024-06-15 00:00:00+00:00', 1)
('2024-06-15 00:00:00+00:00', 1)
('2020-10-20 06:14:04+00:00', -688098735)
('2020-03-06 15:32:29+00:00', -491938169)
('2020-03-06 15:32:29+00:00', -491938169)
('2020-03-06 15:32:29+00:00', -491938169)
('2024-06-15 00:00:00+00:00', 1)
('2024-06-15 00:00:00+00:00', 1)
('2024-02-19 01:18:26+00:00', 1268590800)
('2025-02-07 06:53:31+00:00', -443340271)
('2025-09-22 03:26:15+00:00', 1485335077)
('2025-02-03 05:21:58+00:00', -1612443122)
('2021-10-14 08:16:37+00:00', 1382410067)
('2021-05-17 23:21:59+00:00', 1583472758)
*/

-- Prediction Query
SELECT u.CreationDate, u.Age FROM users AS u JOIN comments AS c ON u.Id = c.UserId WHERE u.WebsiteUrl LIKE '%http://%' AND NOT c.Text IS NULL;

/*
Prediction Result:
*/