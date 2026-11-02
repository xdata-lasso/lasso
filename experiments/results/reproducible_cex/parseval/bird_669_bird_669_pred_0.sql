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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, -1833165707, 1155439218, '2021-02-10 21:10:52+00:00', -761141909, 283598170, 'zbuo4nrq', 1, '2025-01-30 02:54:07+00:00', 'ofqyp', 's5bbp02e', -751275471, -1347802441, 1673584235, 1, '2020-01-22 05:30:29+00:00', '2023-08-20 20:02:04+00:00', 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', 'l7');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'chl', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1019800248, '2022-11-06 10:19:41+00:00', 'chl', '2020-06-20 11:35:06+00:00', 'tti', 'bnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (1, -2147483648, 1178636309, '2021-12-23', 2, -305670381);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, -2147483648, 105869088, '2023-12-17', 2, 481163439);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, -2147483648, 1909986641, '2024-01-01', 2, -511185946);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (4, -2147483648, -1097120355, '2023-09-01', 2, 176380444);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (5, -2147483648, -1362461264, '2023-03-31', 2, -1372125820);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (6, -2147483648, 1692174491, '2025-07-21', 2, 1255852738);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (7, -2147483648, -227162283, '2021-11-05', 2, -705985602);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (8, -2147483648, 1178000634, '2022-08-22', 2, -461695645);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (9, -2147483648, 176555546, '2020-11-04', 2, 1196308825);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (10, -2147483648, -283454505, '2024-05-17', 2, -792092619);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreationDate FROM users AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'chl' ORDER BY T2.CreationDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('2020-11-04',)
*/

-- Prediction Query
SELECT MIN(CreationDate) FROM votes WHERE UserId = (SELECT Id FROM users WHERE DisplayName = 'chl');

/*
Prediction Result:
(None,)
*/