package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Student;
import util.DBConnection;

/**
 * Data Access Object (DAO) for Student entity.
 * Implements complete CRUD (Create, Read, Update, Delete) operations using JDBC.
 */
public class StudentDAO {

    // SQL Queries
    private static final String INSERT_STUDENT_SQL = "INSERT INTO student (name, email, course) VALUES (?, ?, ?);";
    private static final String SELECT_STUDENT_BY_ID_SQL = "SELECT id, name, email, course FROM student WHERE id = ?;";
    private static final String SELECT_ALL_STUDENTS_SQL = "SELECT id, name, email, course FROM student ORDER BY id DESC;";
    private static final String UPDATE_STUDENT_SQL = "UPDATE student SET name = ?, email = ?, course = ? WHERE id = ?;";
    private static final String DELETE_STUDENT_SQL = "DELETE FROM student WHERE id = ?;";

    /**
     * Inserts a new student record into the database.
     * 
     * @param student Student object containing name, email, and course
     * @return true if insertion was successful, false otherwise
     */
    public boolean insertStudent(Student student) {
        boolean rowInserted = false;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_STUDENT_SQL)) {

            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getEmail());
            preparedStatement.setString(3, student.getCourse());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    /**
     * Retrieves all student records from the database.
     * 
     * @return List of Student objects
     */
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STUDENTS_SQL);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String course = rs.getString("course");
                students.add(new Student(id, name, email, course));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    /**
     * Retrieves a single student by their ID.
     * 
     * @param id Student ID
     * @return Student object if found, null otherwise
     */
    public Student getStudentById(int id) {
        Student student = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_BY_ID_SQL)) {

            preparedStatement.setInt(1, id);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String course = rs.getString("course");
                    student = new Student(id, name, email, course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }

    /**
     * Updates an existing student record in the database.
     * 
     * @param student Student object with updated data and existing ID
     * @return true if update was successful, false otherwise
     */
    public boolean updateStudent(Student student) {
        boolean rowUpdated = false;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STUDENT_SQL)) {

            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getEmail());
            preparedStatement.setString(3, student.getCourse());
            preparedStatement.setInt(4, student.getId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    /**
     * Deletes a student record by ID.
     * 
     * @param id Student ID to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteStudent(int id) {
        boolean rowDeleted = false;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_STUDENT_SQL)) {

            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}
