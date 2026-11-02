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
-- DATASET 1
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (5, 1, '2020-01-01 00:00:00', 'NullViewsUser', NULL, 0, 0, 1, 18);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (10, 2, '2020-01-02 00:00:00', 'HighViewsUser', 100, 1, 1, 2, 19);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (20, 500, '2020-01-03 00:00:00', 'MinViewsUserA', 20, 50, 25, 200, 45);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (30, 600, '2020-01-04 00:00:00', 'MinViewsUserB', 20, 60, 30, 300, 55);
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 10, 'Student', '2020-01-05 00:00:00');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, Body, OwnerUserId, Title) VALUES (1, 1, 10, 5, 'Body text', 10, 'Post title');
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (1, 1, 1, 'Comment text', '2020-01-06 00:00:00', 10);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId, Text) VALUES (1, 2, 1, '2020-01-06 00:00:00', 10, 'Initial body');
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount) VALUES (1, 1, 2, '2020-01-07', 10, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM users WHERE Views = (SELECT MIN(Views) FROM users);

/*
Gold Result:
(20,)
(30,)
*/

-- Prediction Query
SELECT Id FROM users ORDER BY Views ASC, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5,)
*/