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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, -2147483648, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483648, -2147483648, 902887186, '2022-10-25', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483647, -2147483648, 775304493, '2022-11-29', -2147483648, 29);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483646, -2147483648, -921187550, '2020-03-14', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, -2147483648, 328305758, '2023-08-24', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, -2147483648, -1347802441, '2022-10-26', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (4, -2147483648, 1, '2024-06-15', -2147483648, NULL);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (5, -2147483648, 2137741668, '2024-03-26', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (6, -2147483648, 624571013, '2025-02-11', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (7, -2147483648, 90119032, '2021-11-06', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (8, -2147483648, 1055976837, '2024-10-22', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (9, -2147483648, 105869088, '2023-12-17', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (10, -2147483648, 1909986641, '2024-01-01', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (11, -2147483648, -1021749117, '2025-02-23', -2147483648, 30);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (12, -2147483648, 244829661, '2022-01-18', -2147483648, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(id) FROM votes WHERE BountyAmount >= 30;

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT PostId) FROM votes WHERE BountyAmount >= 30;

/*
Prediction Result:
(1,)
*/