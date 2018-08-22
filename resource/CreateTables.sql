CREATE TABLE Accounts (
  account_id        BIGINT identity,
  account_name      VARCHAR(20),
  first_name        VARCHAR(20),
  last_name         VARCHAR(20),
  email             VARCHAR(100),
  password_hash     CHAR(64),
  portrait_image    VARBINARY,
  hourly_rate       NUMERIC(9,2),
  CONSTRAINT PK_Accounts PRIMARY KEY CLUSTERED (account_id)
);

CREATE TABLE BugStatus (
  status            VARCHAR(20) PRIMARY KEY
);

CREATE TABLE Bugs (
  bug_id			BIGINT identity,
  date_reported     DATE NOT NULL,
  summary           VARCHAR(80),
  description       VARCHAR(1000),
  resolution        VARCHAR(1000),
  reported_by       BIGINT NOT NULL,
  assigned_to       BIGINT,
  verified_by       BIGINT,
  status            VARCHAR(20) NOT NULL DEFAULT 'NEW',
  priority          VARCHAR(20),
  hours             NUMERIC(9,2),

  CONSTRAINT PK_Bugs PRIMARY KEY CLUSTERED (bug_id),

  FOREIGN KEY (reported_by) REFERENCES Accounts(account_id),
  FOREIGN KEY (assigned_to) REFERENCES Accounts(account_id),
  FOREIGN KEY (verified_by) REFERENCES Accounts(account_id),
  FOREIGN KEY (status) REFERENCES BugStatus(status)
);

CREATE TABLE Comments (
  comment_id        BIGINT identity,
  bug_id            BIGINT NOT NULL,
  author            BIGINT NOT NULL,
  comment_date      DATETIME NOT NULL,
  comment           TEXT NOT NULL,

  CONSTRAINT PK_Comments PRIMARY KEY CLUSTERED (comment_id),
  FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id),
  FOREIGN KEY (author) REFERENCES Accounts(account_id),
);

CREATE TABLE Screenshots (
  bug_id            BIGINT NOT NULL,
  image_id          BIGINT NOT NULL,
  screenshot_image  VARBINARY,
  caption           VARCHAR(100),
  CONSTRAINT PK_Screenshots PRIMARY KEY (bug_id, image_id),
  FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

CREATE TABLE Tags (
  bug_id            BIGINT NOT NULL,
  tag               VARCHAR(20) NOT NULL,
  CONSTRAINT PK_Tag PRIMARY KEY (bug_id, tag),
  FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

CREATE TABLE Products (
  product_id        BIGINT identity,
  product_name      VARCHAR(50),
  CONSTRAINT PK_Products PRIMARY KEY (product_id),
);

CREATE TABLE BugsProducts(
  bug_id            BIGINT NOT NULL,
  product_id        BIGINT NOT NULL,
  CONSTRAINT PK_BugsProducts PRIMARY KEY (bug_id, product_id),
  FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
