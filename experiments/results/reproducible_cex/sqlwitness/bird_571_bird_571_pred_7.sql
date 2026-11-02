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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (23, 24, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', 'default1', NULL, 0, 1, NULL, 1, 0, 'default1'), (1, 0, NULL, NULL, NULL, 'default2', 'default1', 'default2', 24, 0, 24, 24, 1, 'default2'), (24, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', 1, 1, 0, 1, 24, 'default2'), (0, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', NULL, 'default1', 23, 24, 25, NULL, NULL, NULL), (25, 23, NULL, NULL, NULL, NULL, 'default1', 'default1', 24, 25, NULL, NULL, 23, NULL), (2, 23, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default2', 25, 24, 0, 0, NULL, 'default2'), (3, 1, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default2', 24, 1, 25, 25, NULL, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 25, 23, 23, NULL, '2023-01-01 01:00:00.000000', 24, 1, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', 25, NULL, 24, '2023-01-01 00:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (23, 2, NULL, 0, 25, '2023-01-01 00:00:00.000000', 1, 0, 'default2', NULL, NULL, NULL, 24, NULL, 23, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 25, NULL, 'default2', 'default2'), (25, 23, 0, 25, 23, '2023-01-01 01:00:00.000000', 24, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'default2', 1, 24, 23, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 01:00:00.000000', NULL, NULL), (0, 3, 0, 1, 24, NULL, 23, 23, NULL, NULL, NULL, NULL, 24, 25, 1, NULL, NULL, 24, '2023-01-01 00:00:00.000000', 'default1', 'default2'), (24, 2, 24, 1, NULL, '2023-01-01 01:00:00.000000', 25, 24, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', 24, 0, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', NULL, NULL, NULL, NULL), (2, 0, NULL, 24, 1, NULL, 23, 24, NULL, NULL, NULL, 'default1', 25, NULL, 0, '2023-01-01 00:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (3, 1, 24, 23, 23, NULL, 23, 1, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 0, NULL, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 24, '2023-01-01 00:00:00.000000', 'default2', 'default1');
INSERT INTO votes (id, postid, userid, votetypeid, creationdate, bountyamount) VALUES (24, NULL, 2, 0, NULL, 0), (23, 24, 2, 0, NULL, NULL), (25, 25, 24, NULL, '2023-01-01', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.Id) AS REAL) / COUNT(DISTINCT T1.Id) FROM votes AS T1 INNER JOIN posts AS T2 ON T1.UserId = T2.OwnerUserId WHERE T1.UserId = 24;

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT p.id) AS REAL) / COUNT(DISTINCT v.id) AS times FROM posts AS p INNER JOIN votes AS v ON p.id = v.postid WHERE p.owneruserid = 24 AND v.userid = 24;

/*
Prediction Result:
(None,)
*/