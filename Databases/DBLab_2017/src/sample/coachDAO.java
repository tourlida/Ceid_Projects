package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by alexander on 13/8/2017.
 */
public class coachDAO {

    private static PreparedStatement ps1,ps2;
    private static Connection conn;
    private static ResultSet rs1,rs2,rs3;
    private static LoadConnector lc = new LoadConnector();


    public static ObservableList<Game> searchGames(String teamName, String date) throws SQLException, ClassNotFoundException {
        //Declare a SELECT statement
        String selectStmt = "SELECT Game.time, Game.date, Game.stadium, Game.grounded, Game.guest FROM Game INNER JOIN Team ON Team.name=Game.grounded OR Team.name=Game.guest WHERE Team.name=? AND Game.date>=?";
        try{
        lc.connect();
            conn = lc.getConnection();
            ps1 = conn.prepareStatement(selectStmt);
            ps1.setString(1, teamName);
            ps1.setString(2, date);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs1 = ps1.executeQuery();

        //Send ResultSet to the getEmployeeList method and get employee object
        ObservableList<Game> rfList = getGameList(rs1);
        return rfList;
    }

    private static ObservableList<Game> getGameList(ResultSet rs) throws SQLException, ClassNotFoundException {
        //Declare a observable List which comprises of person objects
        ObservableList<Game> empList = FXCollections.observableArrayList();

        while (rs.next()) {
            empList.add(new Game( rs.getString("grounded"),rs.getString("guest"), rs.getString("stadium"),rs.getDate("date")
                    , rs.getTime("time")));


        }
        //return empList (ObservableList of Employees)
        return empList;
    }

    public static ResultSet showSomeStats(String name, String query) throws ClassNotFoundException, SQLException {

        String selectStmt = query;
        try{
            lc.connect();
            conn = lc.getConnection();
            ps1 = conn.prepareStatement(selectStmt);
            ps1.setString(1, name);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs3 = ps1.executeQuery();
        return rs3;
    }

    public static ObservableList<player> searchPlayers(String name) throws SQLException, ClassNotFoundException {
        //Declare a SELECT statement
        String selectStmt = "SELECT Player.name, Player.lastname, Player.age, Player.goals, Player.pos From Player INNER JOIN Team ON Player.team=Team.name WHERE Team.name=?";
        try{
            lc.connect();
            conn = lc.getConnection();
            ps2 = conn.prepareStatement(selectStmt);
            ps2.setString(1, name);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs2 = ps2.executeQuery();

        //Send ResultSet to the getEmployeeList method and get employee object
        ObservableList<player> rfList = getPlayerList(rs2);
        return rfList;
    }

    private static ObservableList<player> getPlayerList(ResultSet rs) throws SQLException, ClassNotFoundException {
        //Declare a observable List which comprises of player objects
        ObservableList<player> empList = FXCollections.observableArrayList();

        while (rs.next()) {
            empList.add(new player( rs.getString("name"),rs.getString("lastname"),
                    rs.getInt("age"), rs.getString("pos"), rs.getInt("goals")));

        }
        //return empList (ObservableList of players)
        return empList;
    }
}
