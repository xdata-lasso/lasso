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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 2137741668, '2024-06-15 00:00:00+00:00', 'ytoo3o9hl7', '2023-10-09 18:36:37+00:00', 'lex', '4ji7zwa', '2dwyrq', -1097120355, 244829661, -1362461264, -904834265, 1, 'b4yp5qi');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1937207087, '2023-09-10 09:37:01+00:00', 'y9uxj4', '2021-01-22 00:53:52+00:00', 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', -1898531797, -1748371085, -1742081330, 894242932, -211209314, 'dqv0gcb9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -512640349, '2021-06-12 16:42:05+00:00', 'n6vck6ah0f', '2024-07-11 21:09:52+00:00', 'sww', 'q7x', '7', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1364429300, '2025-02-07 06:53:31+00:00', 'prmd', '2021-12-31 07:20:26+00:00', 'siie', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, -53231346, -443340271, 'uo4nrqrofqy');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 882961052, '2025-09-22 03:26:15+00:00', 'eutliqa1', '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1649269347, '2025-02-03 05:21:58+00:00', '5qi2', '2022-04-27 23:55:02+00:00', 'f9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', '2020-05-10 07:36:02+00:00', 'rjtu', 'dz79fjg', '8n2f3', 806170397, 513454646, -688216274, 331812443, 1382410067, '9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, -688098735, '2021-05-17 23:21:59+00:00', 'ah0f8jsww', '2021-07-03 08:58:16+00:00', '7xb72', 'xa', '7ryfdrz16n', -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 'rg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, 2107872094, 'http://', '2023-07-13 23:57:06+00:00', 1, '2eutliqa11r');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, -2147483648, -975213201, 'http://', '2020-10-15 10:13:01+00:00', 1, 'vqx58pz0f');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, -2147483648, 172461907, 'http://', '2023-05-31 07:22:36+00:00', 3, '3zb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -2147483648, -1625552518, 'http://', '2021-12-10 17:04:01+00:00', 4, 'rg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, -2147483648, -458359144, 'http://', '2025-06-10 19:01:27+00:00', 4, 'afgogri');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -2147483648, 678047687, 'http://', '2021-04-29 04:39:04+00:00', 4, 'ayxp1q43');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, -2147483648, 1923912467, 'http://', '2024-11-10 21:13:22+00:00', 1, 'jh3den8c68');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, -2147483648, 1774087382, 'http://', '2020-02-13 02:40:04+00:00', 1, 'x');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, -2147483648, 645287482, 'A', '2021-11-22 07:38:31+00:00', 1, 'f77pzo72ctd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, -2147483648, 1, NULL, '2024-06-15 00:00:00+00:00', 2, 'value');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, -2147483648, 2122220075, 'http://', '2022-01-03 02:42:55+00:00', 5, 'luhvdltti');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, -921187550, 'http://', '2020-02-25 10:33:58+00:00', 7, 'p');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, -2147483648, -1362461264, 'http://', '2022-06-17 21:46:26+00:00', 9, '0b4');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, 1581736075, 'http://', '2023-09-26 13:08:37+00:00', 11, 'nd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, -2147483648, 1606439408, 'http://', '2021-05-16 14:38:12+00:00', 13, 'zbilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, -2147483648, -458359144, 'http://', '2025-06-10 19:01:27+00:00', 15, 'afgogri');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreationDate, T2.Age FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.text LIKE '%http://%';

/*
Gold Result:
('2024-06-15 00:00:00+00:00', 1)
('2024-06-15 00:00:00+00:00', 1)
('2023-09-10 09:37:01+00:00', -211209314)
('2021-06-12 16:42:05+00:00', -1888505890)
('2021-06-12 16:42:05+00:00', -1888505890)
('2021-06-12 16:42:05+00:00', -1888505890)
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
SELECT DISTINCT users.creationdate, users.age FROM comments INNER JOIN users ON comments.userid = users.id WHERE comments.text LIKE '%http://%';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00', 1)
('2023-09-10 09:37:01+00:00', -211209314)
('2021-06-12 16:42:05+00:00', -1888505890)
('2024-02-19 01:18:26+00:00', 1268590800)
('2025-02-07 06:53:31+00:00', -443340271)
('2025-09-22 03:26:15+00:00', 1485335077)
('2025-02-03 05:21:58+00:00', -1612443122)
('2021-10-14 08:16:37+00:00', 1382410067)
('2021-05-17 23:21:59+00:00', 1583472758)
*/