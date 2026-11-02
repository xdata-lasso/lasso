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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (8, 7, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1', 7, 0, 8, 0, 7, 'default1'), (2, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', 'default1', 'default1', 'default2', 8, 2, 0, 0, 1, 'default1'), (1, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', NULL, NULL, 9, 1, 0, 7, 9, 'default1'), (7, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default1', 2, 9, 0, 8, 1, 'default2'), (9, 8, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', 'default2', 'default1', 9, 7, NULL, 8, NULL, NULL), (0, 1, '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, NULL, NULL, NULL, 8, 8, 0, 7, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 7, NULL, 2, 8, '2023-01-01 01:00:00.000000', NULL, 2, 'default2', '2023-01-01 00:00:00.000000', 'default2', NULL, 9, 9, 2, '2023-01-01 01:00:00.000000', NULL, 1, '2023-01-01 00:00:00.000000', 'default2', 'default2'), (2, NULL, NULL, 7, 1, NULL, 0, 1, 'default2', NULL, 'default2', 'default1', 1, 1, NULL, '2023-01-01 00:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', NULL, 'default2'), (9, 8, 7, 7, 8, '2023-01-01 01:00:00.000000', 7, 8, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default1', 0, 1, 2, NULL, NULL, 8, '2023-01-01 00:00:00.000000', NULL, NULL), (0, NULL, 0, NULL, NULL, '2023-01-01 01:00:00.000000', 1, 0, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 7, 7, 7, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 1, NULL, NULL, 'default1'), (8, NULL, 9, 7, NULL, NULL, 7, 9, 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, 8, 1, 8, '2023-01-01 01:00:00.000000', NULL, 0, '2023-01-01 01:00:00.000000', 'default1', NULL), (7, 2, 7, NULL, 0, NULL, 1, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default1', 2, 1, 8, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', NULL, 'default2'), (3, 8, 8, 7, 9, '2023-01-01 01:00:00.000000', NULL, 7, 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default1', 8, 1, 8, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 01:00:00.000000', NULL, NULL);
INSERT INTO votes (id, postid, userid, votetypeid, creationdate, bountyamount) VALUES (1, 9, 2, 1, '2023-01-01', NULL), (7, 3, 9, 7, '2023-01-02', 0), (8, 8, 8, 1, NULL, 2), (9, 8, 7, 7, '2023-01-02', 7), (0, 3, NULL, 9, NULL, 1), (2, 1, 1, 8, '2023-01-01', NULL), (3, NULL, 9, 1, NULL, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName, WebsiteUrl FROM users WHERE Id = (SELECT UserId FROM votes WHERE VoteTypeId = 8 ORDER BY BountyAmount DESC, votes.id NULLS LAST LIMIT 1);

/*
Gold Result:
(None, 'default1')
*/

-- Prediction Query
SELECT users.DisplayName, users.WebsiteUrl FROM votes INNER JOIN users ON votes.UserId = users.Id WHERE votes.VoteTypeId = 8 AND votes.BountyAmount = (SELECT MAX(BountyAmount) FROM votes WHERE VoteTypeId = 8);

/*
Prediction Result:
*/