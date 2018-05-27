package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by alexander on 17/8/2017.
 */
public class fanDAO {
    private static PreparedStatement ps1,ps2,ps3,ps4;
    private static Connection conn;
    private static LoadConnector lc = new LoadConnector();
    private static ResultSet rs1,rs2,rs3,rs4;

    public static ResultSet findMyTeam(String id) throws SQLException, ClassNotFoundException {
        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }

        String select = "SELECT Fan.team FROM Fan WHERE Fan.id_fan=?";
        ps1 = conn.prepareStatement(select);
        ps1.setString(1, id);
        System.out.print(ps1);
        rs1 = ps1.executeQuery();
        return rs1;
    }

    public static ResultSet findDate(String teamName,String today) throws SQLException, ClassNotFoundException {
        String findDate = "SELECT Game.date,Game.game_id FROM Game WHERE Game.grounded=? OR Game.guest=? AND Game.date>=? ORDER BY date ASC LIMIT 0,1";

        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        ps1 = conn.prepareStatement(findDate);
        ps1.setString(1, teamName);
        ps1.setString(2, teamName);
        ps1.setString(3, today);
        rs1 = ps1.executeQuery();

        return rs1;
    }


    public static ResultSet premiumSeats(String teamName, String gameDate) throws ClassNotFoundException, SQLException {
        String premiumSeats = "SELECT Count(0) FROM Use_Premium INNER JOIN Game ON Use_Premium.game=Game.game_id INNER JOIN Team ON Team.name=Game.grounded OR Team.name=Game.guest WHERE Team.name=? AND Game.date=?";

        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }

        ps2 = conn.prepareStatement(premiumSeats);
        ps2.setString(1, teamName);
        ps2.setString(2, gameDate);

        rs2 = ps2.executeQuery();
        return rs2;
    }

    public static ResultSet purchasedSeats(String teamName, String gameId) throws ClassNotFoundException, SQLException {

        String purchasedSeats = "SELECT COUNT(0) FROM Purchased INNER JOIN Ticket ON Purchased.ticket_code=Ticket.code INNER JOIN Game ON Game.game_id=Ticket.game WHERE Game.grounded=? OR Game.guest=? AND Game.game_id=? AND Ticket.price='10'";

        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }

        ps2 = conn.prepareStatement(purchasedSeats);
        ps2.setString(1, teamName);
        ps2.setString(2, teamName);
        ps2.setString(3, gameId);

        rs2 = ps2.executeQuery();
        System.out.println(rs2);
        return rs2;
    }

    public static ResultSet checkFan(String id) throws ClassNotFoundException, SQLException {

        String premTicket = "SELECT Ticket.code FROM Ticket INNER JOIN Purchased ON Ticket.code=Purchased.ticket_code INNER JOIN Fan ON Fan.id_fan=Purchased.fan_id WHERE Ticket.price='200' AND Fan.id_fan=?";

        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }

        ps3 = conn.prepareStatement(premTicket);
        ps3.setString(1, id);
        rs3 = ps3.executeQuery();

        return rs3;
    }

    public static void bookSeat(String gameId, String fanId) throws ClassNotFoundException, SQLException {

        String bookIt = "INSERT INTO Use_Premium(game,fan) VALUES(?,?)";

        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }

        ps3 = conn.prepareStatement(bookIt);
        ps3.setString(1, gameId);
        ps3.setString(2, fanId);
        ps3.executeUpdate();

    }

    public static ResultSet checkIfBooked(String gameId,String fanId) throws ClassNotFoundException, SQLException {

        String ifBooked = "SELECT Use_Premium.fan FROM Use_Premium WHERE fan=? AND Use_Premium.game=?";

        try {
            lc.connect();
            conn = lc.getConnection();

        }catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }

        ps3 = conn.prepareStatement(ifBooked);
        ps3.setString(1, fanId);
        ps3.setString(2, gameId);
        rs3 = ps3.executeQuery();
        return rs3;
    }

    public static ResultSet stadiumCapacity(String gameId) throws ClassNotFoundException, SQLException {

        String findCapacity = "SELECT Stadium.capacity, Stadium.name FROM Stadium INNER JOIN Game ON Game.stadium=Stadium.name WHERE Game.game_id=?";

       try {
           lc.connect();
           conn = lc.getConnection();

       }catch (SQLException e) {
           System.out.println("SQL select operation has been failed: " + e);
           //Return exception
           throw e;
       }

        ps3 = conn.prepareStatement(findCapacity);
        ps3.setString(1, gameId);
        rs3 = ps3.executeQuery();

        return rs3;
    }

    public static ObservableList<Game> searchGames(String teamName, String today, String pastOrFuture) throws SQLException, ClassNotFoundException {
        String selectStmt;
        if(pastOrFuture=="past"){
            //Declare a SELECT statement
            selectStmt = "SELECT Game.grounded,Game.guest,Game.date,Game.result, Refee.name,Game.time,Game.stadium FROM Game INNER JOIN Refee ON Game.refee=Refee.id_refee WHERE Game.date<? AND (Game.grounded=? OR Game.guest=?)";

        }
        else {
            //Declare a SELECT statement
             selectStmt = "SELECT Game.grounded,Game.guest,Game.date,Game.result, Refee.name,Game.time,Game.stadium FROM Game INNER JOIN Refee ON Game.refee=Refee.id_refee WHERE Game.date>=? AND (Game.grounded=? OR Game.guest=?)";

        }
          try{
            lc.connect();
            conn = lc.getConnection();
            ps1 = conn.prepareStatement(selectStmt);
            ps1.setString(1, today);
            ps1.setString(2, teamName);
            ps1.setString(3, teamName);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs1 = ps1.executeQuery();

        //Send ResultSet to the getGameList method and get Game object
        ObservableList<Game> rfList = getGameList(rs1);
        return rfList;
    }

    private static ObservableList<Game> getGameList(ResultSet rs) throws SQLException, ClassNotFoundException {
        //Declare a observable List which comprises of person objects
        ObservableList<Game> empList = FXCollections.observableArrayList();

        while (rs.next()) {
             empList.add(new Game( rs.getString("grounded"),rs.getString("guest"), rs.getString("stadium"),rs.getDate("date"),
                   rs.getString("name") ,rs.getString("result"), rs.getTime("time")));
        }
        //return empList (ObservableList of Employees)
        return empList;
    }

    private static ObservableList<Game> getFanGameList(ResultSet rs) throws SQLException, ClassNotFoundException {
        //Declare a observable List which comprises of person objects
        ObservableList<Game> empList = FXCollections.observableArrayList();

        while (rs.next()) {
            empList.add(new Game( rs.getString("grounded"),rs.getString("guest"), rs.getString("stadium"),rs.getDate("date"),
                    "uknown" ,rs.getString("result"), rs.getTime("time"), rs.getString("score1")));

        }
        //return empList (ObservableList of Games)
        return empList;
    }

    public static ObservableList<Game> searchFanGames(String today, String fanId) throws SQLException, ClassNotFoundException {

            //Declare a SELECT statement
          String  selectStmt = "SELECT Game.date,Game.stadium, Game.result,Game.time, Game.score1, Game.grounded,Game.guest FROM Game INNER JOIN Use_Premium ON Game.game_id=Use_Premium.game INNER JOIN Fan ON Use_Premium.fan=Fan.id_fan WHERE Fan.id_fan=? AND Game.date<?";

        try{
            lc.connect();
            conn = lc.getConnection();
            ps1 = conn.prepareStatement(selectStmt);
            ps1.setString(1, fanId);
            ps1.setString(2, today);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs1 = ps1.executeQuery();

        ObservableList<Game> rfList = getFanGameList(rs1);
        return rfList;
    }

    public static ResultSet searchGameStats(String name) throws SQLException, ClassNotFoundException {

        //Declare a SELECT statement
        String  selectStmt = "SELECT goals_out,goals_in,wins,losses,draws,points FROM Team WHERE Team.name=? ";

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
        rs1 = ps1.executeQuery();

        return rs1;
    }

    public static ResultSet myPlayer(String id) throws SQLException, ClassNotFoundException {

        //Declare a SELECT statement
        String  selectStmt = "SELECT Player.goals,Player.name FROM Player INNER JOIN Admires ON Admires.player=Player.id_play WHERE Admires.fan=? ";

        try{
            lc.connect();
            conn = lc.getConnection();
            ps1 = conn.prepareStatement(selectStmt);
            ps1.setString(1, id);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs1 = ps1.executeQuery();

        return rs1;
    }

}
