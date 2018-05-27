package sample;

import javafx.collections.ObservableList;
import javafx.collections.FXCollections;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class chairmanDAO extends chairmanController {

    private static PreparedStatement ps, ps3, ps4, ps5,ps6,ps7;
    private static Connection conn;
    private static ResultSet rs, rs3, rs4,rs5;
    private static LoadConnector lc = new LoadConnector();


    /*vriskw ton fan me to id pou dinete an uparxei*/
    public static ResultSet Reneawl(String Fan_id, String TeamName) throws SQLException, ClassNotFoundException {
        //  System.out.println(Fan_id + TeamName);
        String stmnt = "SELECT Fan.id_fan,Fan.name,Fan.lastname,Fan.team,Fan.age,Ticket.kind FROM Fan INNER JOIN Purchased ON  Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code INNER JOIN Team ON Team.name=Ticket.team_tick  WHERE (Team.name=? AND Fan.id_fan=? AND Ticket.kind LIKE '%CONTINUOUS%')";

        lc.connect();
        conn = lc.getConnection();
        ps4 = conn.prepareStatement(stmnt);
        ps4.setString(1, TeamName);
        ps4.setString(2, Fan_id);
        rs4 = ps4.executeQuery();
       // rs5=ps5.executeQuery();

            //update(rs4);
            /*epistrefw to id tou fan an uparxei */


        return rs4;
    }
public static void updateCont(int id) throws SQLException, ClassNotFoundException {

    String query = "UPDATE Fan INNER JOIN Purchased ON Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code SET Fan.reneawl='11' WHERE Fan.id_fan=? AND Ticket.kind LIKE 'CONTINUOUS'" ;

    try {
        lc.connect();
        conn = lc.getConnection();
        ps5 = conn.prepareStatement(query);
        ps5.setInt(1, id);

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }
  ps5.executeUpdate();
System.out.println(ps5);
    }

    public static ResultSet Buying_offer(String Fan_id) throws SQLException, ClassNotFoundException {
        //  System.out.println(Fan_id + TeamName);
        String stmnt = "SELECT Fan.id_fan,Fan.name,Fan.lastname,Fan.team,Fan.age,Ticket.kind FROM Fan INNER JOIN Purchased ON  Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code INNER JOIN Team ON Team.name=Ticket.team_tick  WHERE (Fan.id_fan=? AND Ticket.kind LIKE '%SIMPLE%')";

       lc.connect();
        conn = lc.getConnection();
        ps6 = conn.prepareStatement(stmnt);
        ps6.setString(1,Fan_id);
        //ps6.setString(2, Fan_id);
        rs5= ps6.executeQuery();
         /*epistrefw to id tou fan an uparxei */

        return rs5;
    }

    public static void updateSimp(int id) throws SQLException, ClassNotFoundException {

        String query = "UPDATE Fan INNER JOIN Purchased ON Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code SET Fan.reneawl='01' WHERE Fan.id_fan=? AND Ticket.kind LIKE '%SIMPLE%'" ;

        try {
            lc.connect();
            conn = lc.getConnection();
            ps7 = conn.prepareStatement(query);
            ps7.setInt(1, id);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ps7.executeUpdate();
        System.out.println(ps7);
    }

        public static ObservableList<chairman> searchInfo (String team) throws SQLException, ClassNotFoundException {
            String selectStmt = "SELECT   Fan.id_fan,Fan.name,Fan.lastname,Ticket.kind FROM Fan  INNER JOIN Purchased ON  Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code INNER JOIN Team ON Team.name=Ticket.team_tick  WHERE Team.name=?";


            try {
                lc.connect();
                conn = lc.getConnection();
                ps = conn.prepareStatement(selectStmt);
                ps.setString(1, team);

            } catch (SQLException var3) {
                System.out.println("SQL select operation has been failed: " + var3);
                throw var3;
            }
            //Execute SELECT statement
            rs = ps.executeQuery();

            ObservableList<chairman> ChrList = getChrList(rs);
            return ChrList;
        }

    public static ResultSet getTeam_name(String chairmanID) throws SQLException, ClassNotFoundException {
        //CHAIRMAN Team
        String stmnt3 = "SELECT Chairman.name,Chairman.lastname,Team.name AS Team FROM Chairman INNER JOIN Team ON Team.name=Chairman.team WHERE Chairman.id_chair=?";

        lc.connect();
        conn = lc.getConnection();

        ps3 = conn.prepareStatement(stmnt3);
        ps3.setString(1, chairmanID);
        rs3 = ps3.executeQuery();
        return rs3;

    }

    public static ResultSet getContinuous(String team) throws SQLException, ClassNotFoundException {

        String stmnt1 = "SELECT  COUNT(1) AS Continuous FROM Ticket INNER JOIN Purchased ON Ticket.code=Purchased.ticket_code INNER JOIN Team ON Team.name=Ticket.team_tick WHERE Ticket.price='200'AND Team.name=?";

        lc.connect();
        conn = lc.getConnection();
        ps3 = conn.prepareStatement(stmnt1);
        ps3.setString(1, team);
        rs3 = ps3.executeQuery();
        return rs3;

    }

    public static ResultSet getSimple(String team) throws SQLException, ClassNotFoundException {
        String stmnt2 = "SELECT  COUNT(1) AS Simple FROM Ticket INNER JOIN Purchased ON Ticket.code=Purchased.ticket_code INNER JOIN Team ON Team.name=Ticket.team_tick WHERE Ticket.price='10' AND Team.name=?";


        lc.connect();
        conn = lc.getConnection();

        ps3 = conn.prepareStatement(stmnt2);
        ps3.setString(1, team);
        rs3 = ps3.executeQuery();
        return rs3;
    }

    private static ObservableList<chairman> getChrList(ResultSet rs) throws SQLException, ClassNotFoundException {
        ObservableList empList = FXCollections.observableArrayList();

        while (rs.next()) {
            empList.add(new chairman(rs.getInt("id_fan"), rs.getString("name"), rs.getString("lastname"), (rs.getString("kind"))));//database
            System.out.println(rs.getString("kind"));/* problem with Ticket.kind*/
        }

        return empList;
    }
}

