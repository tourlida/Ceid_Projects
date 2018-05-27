package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Created by alexander on 10/8/2017.
 */
public class refeeDAO {

    private static PreparedStatement ps;
    private static Connection conn;
    private static ResultSet rs;
    private static LoadConnector lc = new LoadConnector();


    public static ObservableList<refee> searchItems(String id, String date) throws SQLException, ClassNotFoundException {
        //Declare a SELECT statement
        String selectStmt = "SELECT Game.date, Game.grounded, Game.guest, Game.stadium, Game.time, Refee.position FROM Game INNER JOIN Team ON Team.name=Game.grounded INNER JOIN Refee ON Refee.id_refee=Game.refee WHERE id_refee=? AND Game.date>=?";
        try {
            lc.connect();
            conn = lc.getConnection();
            ps = conn.prepareStatement(selectStmt);
            ps.setString(1, id);
            ps.setString(2, date);

        } catch (SQLException e) {
            System.out.println("SQL select operation has been failed: " + e);
            //Return exception
            throw e;
        }
        //Execute SELECT statement
        rs = ps.executeQuery();

            //Send ResultSet to the getEmployeeList method and get employee object
            ObservableList<refee> rfList = getRefeeList(rs);
        return rfList;
    }

    private static ObservableList<refee> getRefeeList(ResultSet rs) throws SQLException, ClassNotFoundException {
        //Declare a observable List which comprises of person objects
        ObservableList<refee> empList = FXCollections.observableArrayList();

        while (rs.next()) {
            empList.add(new refee( rs.getString("guest"),rs.getString("grounded"), rs.getString("stadium"),rs.getDate("date"),
                    rs.getString("position"), rs.getTime("time")));

        }
        //return empList (ObservableList of Employees)
        return empList;
    }
}
