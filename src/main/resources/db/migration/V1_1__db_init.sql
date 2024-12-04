DROP SEQUENCE task_management.users_seq;
DROP TABLE task_management.users;

CREATE SCHEMA task_management;

CREATE SEQUENCE IF NOT EXISTS task_management.users_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.users
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.users_seq'),
    username    VARCHAR(50) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
    );

CREATE SEQUENCE IF NOT EXISTS task_management.projects_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.projects
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.projects_seq'),
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    owner_id    BIGINT REFERENCES task_management.users (id) NOT NULL UNIQUE,
    created_at  TIMESTAMP,
    created_by  BIGINT REFERENCES task_management.users (id) NOT NULL,
    updated_at  TIMESTAMP,
    updated_by  BIGINT REFERENCES task_management.users (id) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.statuses_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.statuses
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.statuses_seq'),
    name        VARCHAR(50) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.priorities_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.priorities
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.priorities_seq'),
    name        VARCHAR(50) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.tasks_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.tasks
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.tasks_seq'),
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    status      BIGINT REFERENCES task_management.statuses (id) NOT NULL,
    priority    BIGINT REFERENCES task_management.priorities (id) NOT NULL,
    due_date    TIMESTAMP,
    project_id  BIGINT REFERENCES task_management.projects (id) NOT NULL,
    assigned_to BIGINT REFERENCES task_management.users (id) NOT NULL,
    created_at  TIMESTAMP,
    created_by  BIGINT REFERENCES task_management.users (id) NOT NULL,
    updated_at  TIMESTAMP,
    updated_by  BIGINT REFERENCES task_management.users (id) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.comments_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.comments
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.comments_seq'),
    content     TEXT NOT NULL,
    task_id     BIGINT REFERENCES task_management.tasks (id) NOT NULL,
    user_id     BIGINT REFERENCES task_management.users (id) NOT NULL,
    created_at  TIMESTAMP,
    created_by  BIGINT REFERENCES task_management.users (id) NOT NULL,
    updated_at  TIMESTAMP,
    updated_by  BIGINT REFERENCES task_management.users (id) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.notifications_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.notifications
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.notifications_seq'),
    message     TEXT NOT NULL,
    task_id     BIGINT REFERENCES task_management.tasks (id) NOT NULL,
    user_id     BIGINT REFERENCES task_management.users (id) NOT NULL,
    created_at  TIMESTAMP,
    created_by  BIGINT REFERENCES task_management.users (id) NOT NULL,
    updated_at  TIMESTAMP,
    updated_by  BIGINT REFERENCES task_management.users (id) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.notifications_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.notifications
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.notifications_seq'),
    message     TEXT NOT NULL,
    task_id     BIGINT REFERENCES task_management.tasks (id) NOT NULL,
    user_id     BIGINT REFERENCES task_management.users (id) NOT NULL,
    created_at  TIMESTAMP,
    created_by  BIGINT REFERENCES task_management.users (id) NOT NULL,
    updated_at  TIMESTAMP,
    updated_by  BIGINT REFERENCES task_management.users (id) NOT NULL
);

CREATE SEQUENCE IF NOT EXISTS task_management.roles_seq START 1;

CREATE TABLE IF NOT EXISTS task_management.roles
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('task_management.roles_seq'),
    role_name   VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS task_management.user_roles
(
    user_id        BIGINT REFERENCES task_management.users (id) NOT NULL,
    project_id     BIGINT REFERENCES task_management.projects (id) NOT NULL,
    role           BIGINT REFERENCES task_management.roles (id) NOT NULL,
    PRIMARY KEY (user_id, project_id)
);