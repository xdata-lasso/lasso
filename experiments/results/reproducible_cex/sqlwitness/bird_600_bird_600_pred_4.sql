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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (61218, 61218, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 0, 0, 1, 61217, 0, 'default2'), (61217, 61217, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', 'default1', 'default2', 1, 0, 1, 61217, 61218, NULL), (61216, 61217, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default1', NULL, 61217, 61217, 61217, 61217, NULL, 'default2'), (0, NULL, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', 'default2', 0, 61216, 61218, 0, 61218, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (61217, 61218, 61217, 1, 61217, '2023-01-01 01:00:00.000000', 1, 61218, 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default2', 1, 61216, NULL, NULL, NULL, 61218, NULL, NULL, 'default2'), (0, NULL, 0, NULL, NULL, '2023-01-01 00:00:00.000000', 61218, 1, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 61218, NULL, 0, NULL, '2023-01-01 01:00:00.000000', 61216, '2023-01-01 00:00:00.000000', NULL, 'default2'), (1, NULL, 0, 61218, 0, NULL, 0, 0, 'default2', NULL, NULL, NULL, 61217, 61216, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default1'), (61216, NULL, 61217, 61218, NULL, '2023-01-01 01:00:00.000000', NULL, 1, NULL, NULL, NULL, 'default1', 61216, 61216, 61216, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 61218, NULL, 'default1', NULL);
INSERT INTO postlinks (id, postid, relatedpostid, creationdate, linktypeid) VALUES (61218, 1, 61216, NULL, 0), (0, 61216, 61216, '2023-01-01 01:00:00.000000', 1), (61216, 0, 61217, NULL, 61217), (61217, 0, 0, NULL, 61216), (1, 61217, NULL, NULL, 0), (2, 0, 1, '2023-01-01 01:00:00.000000', 61217), (3, 61216, 61216, '2023-01-01 00:00:00.000000', 61218);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ViewCount FROM posts AS T1 INNER JOIN postLinks AS T2 ON T1.Id = T2.PostId WHERE T2.PostId = 61217;

/*
Gold Result:
(61218,)
*/

-- Prediction Query
SELECT p.*, (SELECT ViewCount FROM posts WHERE Id = 61217) AS Popularity FROM postLinks AS pl JOIN posts AS p ON pl.RelatedPostId = p.Id WHERE pl.PostId = 61217;

/*
Prediction Result:
*/