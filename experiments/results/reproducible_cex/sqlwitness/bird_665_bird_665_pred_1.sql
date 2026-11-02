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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (12, 13, '2023-01-01 01:00:00.000000', '%Y', '2023-01-01 00:00:00.000000', 'default1', '%Y', '2010', 3, 13, 12, 3, 3, '2010'), (2, 3, NULL, NULL, NULL, NULL, '2010', NULL, 0, 13, 0, 12, 0, 'default1'), (1, 0, NULL, '2010', '2010-10-27 00:00:00.000000', 'default2', '%Y', '2010', 12, 12, 3, 13, 0, 'default1'), (3, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', '%Y', 12, 2, 12, 11, 12, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 2, NULL, 13, 3, '2023-01-01 00:00:00.000000', NULL, 3, '%Y', '2010-10-27 00:00:00.000000', '2010', NULL, 12, NULL, 3, NULL, NULL, NULL, NULL, '%Y', 'default1'), (11, 2, NULL, 3, NULL, '2023-01-01 00:00:00.000000', 13, 2, 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', 2, 13, 0, '2010-10-27 00:00:00.000000', NULL, 12, NULL, 'default1', '2010'), (12, 2, 1, 1, NULL, '2023-01-01 01:00:00.000000', NULL, 0, '%Y', NULL, 'default2', 'default1', 2, 2, 2, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 2, '2010-10-27 00:00:00.000000', '2010', '%Y'), (3, 3, 12, 0, 13, NULL, 2, 12, '2010', '2010-10-27 00:00:00.000000', '%Y', 'default2', 2, 3, 1, '2010-10-27 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, NULL, '2010', '%Y'), (2, 2, 3, 1, NULL, NULL, 2, 2, 'default1', '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 3, 2, NULL, '2023-01-01 01:00:00.000000', 12, '2023-01-01 00:00:00.000000', 'default1', '2010'), (0, 2, NULL, 12, 0, '2023-01-01 00:00:00.000000', 12, 11, '%Y', '2010-10-27 00:00:00.000000', 'default1', '%Y', 3, 12, 11, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 12, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (13, 2, 2, 0, 11, '2023-01-01 01:00:00.000000', 1, 0, NULL, NULL, NULL, '%Y', 0, 0, 11, '2023-01-01 01:00:00.000000', NULL, 13, '2010-10-27 00:00:00.000000', '%Y', NULL), (4, 1, NULL, 12, 3, '2023-01-01 00:00:00.000000', 11, 11, NULL, NULL, NULL, 'default1', 11, 1, 11, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 11, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (5, 2, 12, 0, 3, '2010-10-27 00:00:00.000000', NULL, 0, '%Y', NULL, '2010', NULL, 12, NULL, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2010-10-27 00:00:00.000000', 'default2', 'default2');
INSERT INTO postlinks (id, postid, relatedpostid, creationdate, linktypeid) VALUES (1, 12, 11, '2023-01-01 00:00:00.000000', 0), (0, 12, 11, '2010-10-27 00:00:00.000000', 12), (12, 11, 11, NULL, 11), (13, 12, 2, NULL, 1), (2, 2, 5, '2010-10-27 00:00:00.000000', 11), (3, 2, 3, '2010-10-27 00:00:00.000000', 1), (11, 0, 4, '2023-01-01 00:00:00.000000', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) / 12 FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.AnswerCount <= 2 AND STRFTIME('%Y', T1.CreationDate) = '2010';

/*
Gold Result:
(0.08333333333333333,)
*/

-- Prediction Query
SELECT COUNT("postlinks"."id") / 12 FROM "postlinks" JOIN "posts" ON "postlinks"."postid" = "posts"."id" WHERE STRFTIME('%Y', "postlinks"."creationdate") = '2010' AND "posts"."answercount" <= 2;

/*
Prediction Result:
(0,)
*/