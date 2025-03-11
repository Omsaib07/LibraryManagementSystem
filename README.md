# Library Management System

This project is a Spring Boot-based Library Management System. Follow the instructions below to set up the project, configure the database, and create a new branch for your contributions.

## Prerequisites
- Java 21 or higher
- Maven 3.8+ installed
- MySQL installed and running
- Git installed

## Clone the Repository
To clone this project, run the following command:
```bash
git clone https://github.com/Omsaib07/LibraryManagementSystem.git
cd LibraryManagementSystem
```

## Create a New Branch
To create a separate branch for your work:
```bash
git checkout -b <your-branch-name>
```
For example:
```bash
git checkout -b feature/add-book-management
```

## Database Configuration
1. Open the `application.properties` file located in:
```
src/main/resources/application.properties
```
2. Update the database URL to match your MySQL database name. Change the `lmsdb` part to your desired database name:
```
spring.datasource.url=jdbc:mysql://localhost:3306/<your-database-name>?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=<your-password>
```

## Creating a New Database in MySQL
1. Login to MySQL from your terminal:
```bash
mysql -u root -p
```
2. Create a new database:
```sql
CREATE DATABASE <your-database-name>;
```
3. Verify the database creation:
```sql
SHOW DATABASES;
```

## Run the Project
1. After configuring the database, run the following command to build the project:
```bash
mvn clean install
```
2. Start the Spring Boot application:
```bash
mvn spring-boot:run
```
3. Access the application at: [http://localhost:9080](http://localhost:8080)

## Pushing Changes to GitHub
1. Stage your changes:
```bash
git add .
```
2. Commit your changes:
```bash
git commit -m "Add feature: <feature-description>"
```
3. Push your branch to the repository:
```bash
git push origin <your-branch-name>
```

