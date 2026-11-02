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
-- Tests:
-- 1. Tie-breaking for minimum Views (kills ORDER BY Views ASC LIMIT 1).
-- 2. Ordering where minimum Views does not correspond to the first inserted row or lowest Id (kills LIMIT 1 without ORDER BY, or ORDER BY Id).
-- 3. NULL handling in Views (kills IS NULL, or COALESCE(Views, 0) when min > 0).
-- 4. Confusion with other integer columns in 'users' (Reputation, UpVotes, DownVotes, AccountId, Age).
-- 5. Unnecessary INNER JOINs with other tables (User 2 has no related records in posts, badges, etc.; User 3 has related records).
-- 6. Confusion between users.Views and posts.ViewCount.
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (1, 1, 50, 1, 1, 1, 1, 'User1');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (2, 100, 10, 50, 50, 100, 40, 'User2');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (3, 200, 10, 60, 60, 200, 50, 'User3');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (4, 5, NULL, 5, 5, 5, 20, 'User4');
INSERT INTO posts (Id, OwnerUserId, ViewCount, Score) VALUES (101, 1, 5, 10);
INSERT INTO posts (Id, OwnerUserId, ViewCount, Score) VALUES (102, 3, 100, 20);
INSERT INTO badges (Id, UserId, Name) VALUES (201, 3, 'Student');
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (301, 102, 3, 1);
INSERT INTO votes (Id, PostId, UserId, VoteTypeId) VALUES (401, 102, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM users WHERE Views = (SELECT MIN(Views) FROM users);

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT Id FROM users ORDER BY Views ASC, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(4,)
*/