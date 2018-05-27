package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by alexander on 9/8/2017.
 */
public class GameDAO {

    private static PreparedStatement ps;
    private static Connection conn;
    private static ResultSet rs;
    private static LoadConnector lc = new LoadConnector();

    //Search Games
    public static ObservableList<Game> searchGames() throws SQLException, ClassNotFoundException {
        //Declare a SELECT statement
        String selectStmt = "SELECT grounded, guest, stadium, date FROM Game";

        //Execute SELECT statement
        try {
            lc.connect();
            conn = lc.getConnection();
        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
            ps = conn.prepareStatement(selectStmt);
            rs = ps.executeQuery();

            //Send ResultSet to the getEmployeeList method and get employee object
            ObservableList<Game> gmList = getGameList(rs);

            //Return employee object
            return gmList;
        }



    //
    private static ObservableList<Game> getGameList(ResultSet rs) throws SQLException, ClassNotFoundException {
        //Declare a observable List which comprises of person objects
        ObservableList<Game> empList = FXCollections.observableArrayList();

        while (rs.next()) {
            empList.add(new Game(rs.getString("grounded"), rs.getString("guest"),
                    rs.getString("stadium"), rs.getDate(4)));
        }
         return empList;
    }

}
