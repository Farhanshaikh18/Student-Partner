# Student Management System (Academic Java EE Web Application)

A complete CRUD Web Application built purely with **Java, JSP, Servlet, JDBC, and MySQL**.  
No external frameworks (No Spring Boot, No Hibernate, No Maven/Gradle).

---

## 📁 Project Structure

```
studentPartner/
│
├── database.sql                  # MySQL database initialization script
│
├── src/
│   ├── dao/
│   │   └── StudentDAO.java       # Full CRUD JDBC Database Operations
│   ├── model/
│   │   └── Student.java          # Student Entity Model
│   ├── servlet/
│   │   ├── AddStudentServlet.java     # Handles student registration
│   │   ├── UpdateStudentServlet.java  # Handles student record updates
│   │   ├── DeleteStudentServlet.java  # Handles student record deletion
│   │   └── ListStudentServlet.java    # Handles student list retrieval
│   └── util/
│       └── DBConnection.java     # JDBC Connection Manager
│
└── WebContent/
    ├── index.jsp                 # Landing page / Home dashboard
    ├── addStudent.jsp            # Add new student form
    ├── editStudent.jsp           # Edit student details form
    ├── studentList.jsp           # View all students with Edit/Delete
    │
    ├── css/
    │   └── style.css             # Clean modern responsive UI stylesheet
    │
    └── WEB-INF/
        ├── lib/                  # Directory for mysql-connector JAR
        └── web.xml               # Deployment descriptor & servlet mappings
```

---

## 🗄️ Database Setup (MySQL)

1. Open **MySQL Command Line Client** or **MySQL Workbench**.
2. Run the `database.sql` script:

```sql
CREATE DATABASE IF NOT EXISTS sms;
USE sms;

CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL
);

-- Insert sample records
INSERT INTO student (name, email, course) VALUES 
('Farhan Shaikh', 'farhan.shaikh@example.com', 'Computer Science'),
('Sophia Reynolds', 'sophia.reynolds@example.com', 'Information Technology'),
('Alexander Wright', 'alex.wright@example.com', 'Data Science & AI');
```

---

## ⚙️ Database Configuration

Stored in `src/util/DBConnection.java`:
- **URL**: `jdbc:mysql://localhost:3306/sms`
- **Username**: `root`
- **Password**: `root`

*If your MySQL password is not `root`, modify the credentials in `src/util/DBConnection.java`.*

---

## 🚀 How to Run in Eclipse IDE

1. **Import the Project:**
   - Open **Eclipse IDE for Enterprise Java and Web Developers**.
   - Go to `File` -> `Open Projects from File System...` (or `New` -> `Dynamic Web Project`).
   - Select the `studentPartner` directory.
   - Click **Finish**.

2. **Add MySQL Connector JAR:**
   - Download `mysql-connector-j-8.x.x.jar`.
   - Copy the `.jar` file into `WebContent/WEB-INF/lib/`.
   - In Eclipse, right-click the project -> `Build Path` -> `Configure Build Path...` -> `Libraries` tab -> `Add JARs...` -> navigate to `WebContent/WEB-INF/lib/` and select the MySQL JAR.

3. **Configure Apache Tomcat Server:**
   - In Eclipse, open the **Servers** tab (Window -> Show View -> Servers).
   - Right-click in the Servers window -> `New` -> `Server`.
   - Select **Apache** -> **Tomcat v8.5** or **Tomcat v9.0**.
   - Browse to your local Tomcat installation directory.
   - Click `Next`, add `studentPartner` to the configured projects list, and click `Finish`.

4. **Run the Project:**
   - Right-click `studentPartner` (or `index.jsp`).
   - Select `Run As` -> `Run on Server`.
   - Open your browser at:
     `http://localhost:8080/studentPartner/`
