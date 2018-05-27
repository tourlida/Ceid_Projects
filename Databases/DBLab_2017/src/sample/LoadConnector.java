package sample;

import java.sql.*;

/**
 * Created by alexander on 31/7/2017.
 */
public class LoadConnector {

     static final String URL = "jdbc:mysql://localhost/League?autoReconnect=true&useSSL=false";
     static final String USER = "root";
     static final String PASSWORD = "alexgnu";
     static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";

    /*the query must be flexible
    * so get and set was created*/
    private String myQuery;
    private Connection connection = null;
    private Statement statement;
    private ResultSet resultSet;
    //Connection
    private static Connection conn = null;

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;

    }
/*
    public void setUSER(String user){
        this.USER = user;
    }

    public void setPASSWORD(String password){
        this.PASSWORD = password;
    }*/

    public void connect() throws ClassNotFoundException, SQLException{
        try {
            Class.forName(JDBC_DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("...connected");
        } catch (ClassNotFoundException ex) {
            System.out.println("Could not connect to Driver");
        }
        catch (SQLException ex) {
            System.out.println("SQL exception. >> " + ex.getMessage());
        }
    }

    //Close Connection
    public static void dbDisconnect() throws SQLException {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (Exception e){
            throw e;
        }
    }

    public Statement getStatement() {
        return statement;
    }

    public void setStatement(Statement statement) {
        this.statement = statement;
    }

    public String getMyQuery() {
        return myQuery;
    }

    public void setMyQuery(String myQuery) {
        this.myQuery = myQuery;
    }

    public ResultSet getResultSet() {
        return resultSet;
    }
    public void setResultSet(ResultSet resultSet) {
        this.resultSet = resultSet;
    }

    public void makeStatement(String a){
        try {
            statement = connection.createStatement();
            /*myQuery = "SELECT * FROM USERS";*/
            statement.execute(a);

    }catch (SQLException ex) {
            System.out.println("SQL exception. >> " + ex.getMessage());
        }
    }

    public ResultSet OpenConnectionWithQuery(String a) throws SQLException {

        setMyQuery(a);

        try {
            Class.forName(JDBC_DRIVER).newInstance();
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            statement = connection.createStatement();
            /*myQuery = "SELECT * FROM USERS";*/
            resultSet = statement.executeQuery(myQuery);

            return resultSet;

        } catch (SQLException ex) {
            System.out.println("SQL exception. >> " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("NOT a SQL exception. >> " + ex.getMessage());
        }
        return resultSet;
    }

    public String CloseTheConnection () throws SQLException {
        String message;
        if (connection.isClosed() || connection == null) {
            message = "No need to close any connection.";
        } else {
            resultSet.close();
            statement.close();
            connection.close();
            message = "Connection is now closed.";
        }
        return message;
    }
}