# SecureMed Database Administration

## Technology Used
- WSL version: 2.4.13.0
- Docker version 28.3.0, build 38b7060
- psql (PostgreSQL) 17.5 (Debian 17.5-1.pgdg120+1)

## Project Set Up
- Create the project folder
  ```bash
  mkdir securemed && cd securemed
- Make .env file
  ```bash
  touch .env
- Edit .env with database credentials
  ```bash
  nano .env
- Add credentials
  ```bash
  POSTGRES_USER = <admin_user>
  POSTGRES_PASSWORD = <admin_password>
  POSTGRES_DB = securemed
- Exit nano with CTRL+O and then CTRL+X
- Make docker-compose.yml
  ```bash
  touch docker-compose.yml
  nano docker-compose.yml
- Open docker-compose
  ```bash
  nano docker-compose.yml
- Edit docker-compose
  ```bash
  version: '3'

  services:
    db:
      image: postgres:15
      restart: unless-stopped
      environment:
        POSTGRES_USER: ${POSTGRES_USER}
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
        POSTGRES_DB: ${POSTGRES_DB}
      volumes:
        - ./initdb:/docker-entrypoint-initdb.d
        - pgdata:/var/lib/postgresql/data
      ports:
        - "5432:5432"

    pgadmin:
      image: dpage/pgadmin4
      environment:
        PGADMIN_DEFAULT_EMAIL: <pgadmin_default_email>
        PGADMIN_DEFAULT_PASSWORD: <pgadmin_Deafult_password>
      ports:
        - "8080:80"
      depends_on:
        - db

  volumes:
    pgdata:

---

## Verify Set Up
- Start Docker containers
  ```bash
  docker-compose up -d
- Open pgAdmin in http://localhost:8080/
- This should open a login screen where you can use the email and password defined in docker-compose.yml to log in
- Once logged in, we must register our server
- The name of the database can be whatever you'd like. I am naming it SecureMed
- Under the connections tab, fill out the forms as follows:
    - Host name/ address: The name defined in docker-compose, in this instance, 'db'
    - port: The port defined in docker-compose, in this instance, '5432'
<img width="1912" height="872" alt="image" src="https://github.com/user-attachments/assets/ba2a76fa-50db-4c4c-a604-6a8e329e604f" />
- Once the server is registered, we are ready to move forward. If you want to turn off the Docker containers, just run:
  ```bash
  docker-compose down

## Designing and Creating ./initdb/

---

***Creating Roles:***

The first script in our initdb will be 01_roles.sql. As a note, the scripts in initdb will be numbered because PostgreSQL will execute the files in alphabetical order when booting up the database for the first time with all of the files. The goal of this file is define the roles of the staff members at the clinic. What exactly each role can view and edit will be defined later. Also, we grant each role to the database admin. This is a design detail meant to reduce redundancy. For example, if the database design changes/ updates, we can update the appropriate roles as needed without having to also update the admin role.

```bash
CREATE ROLE  doctor NOLOGIN;
CREATE ROLE  nurse NOLOGIN;
CREATE ROLE receptionist NOLOGIN;
CREATE ROLE analyst NOLOGIN;
CREATE ROLE admin NOLOGIN;

GRANT doctor TO admin;
GRANT nurse TO admin;
GRANT receptionist TO admin;
GRANT analyst TO admin;
```




  
  



