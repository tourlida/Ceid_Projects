package sample;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by alexander on 14/8/2017.
 */
public class statDisplay {

    @FXML private Label fpoints;
    @FXML private Label fgames;
    @FXML private Label fwins;
    @FXML private Label flosses;
    @FXML private Label fdraws;
    @FXML private Label favgwins;
    @FXML private Label favglos;
    @FXML private Label fgoalsin;
    @FXML private Label fgoalsout;
    @FXML private Label favgin;
    @FXML private Label favgout;

    @FXML private Button closeBtn;

    private static PreparedStatement ps1,ps2,ps3 = null;
    private static Connection conn = null;
    private static ResultSet rs1,rs2,rs3 = null;
    private static LoadConnector lc = new LoadConnector();

    Stage window = new Stage();

    @FXML private void closeScene(){
        closeBtn.setOnAction(e -> window.close());
    }

    public void display(String name) throws SQLException, ClassNotFoundException {


        //Block events to other windows
       // window.initModality(Modality.APPLICATION_MODAL);
        //window.setTitle(name);
        //window.setMinWidth(450);


        String stmnt1 =  "SELECT (wins + losses + draws) AS 'total', wins, losses,draws, points FROM Team WHERE Team.name=?";
        String stmnt2 = "SELECT wins/(wins + losses + draws) AS 'avgW', losses/(wins + losses + draws) AS 'avgL' FROM Team WHERE Team.name=?";
        String stmnt3 = "SELECT (goals_in/(wins + losses + draws)) AS 'avgIn', (goals_out/(wins + losses + draws)) AS 'avgOut',goals_in, goals_out FROM Team WHERE Team.name=?";

        lc.connect();
        conn = lc.getConnection();
        ps1 = conn.prepareStatement(stmnt1);
        ps2 = conn.prepareStatement(stmnt2);
        ps3 = conn.prepareStatement(stmnt3);
        ps1.setString(1, name);
        ps2.setString(1, name);
        ps3.setString(1, name);
        rs1 = ps1.executeQuery();
        rs2 = ps2.executeQuery();
        rs3 = ps3.executeQuery();

        while (rs1.next()){
            fgames.setText(String.valueOf(rs1.getString("total")));
            fwins.setText(String.valueOf(rs1.getInt("wins")));
            flosses.setText(String.valueOf(rs1.getInt("losses")));
            fdraws.setText(String.valueOf(rs1.getInt("draws")));
            fpoints.setText(String.valueOf(rs1.getInt("points")));
        }
        while (rs2.next()){
            favgwins.setText(String.valueOf(rs2.getDouble("avgW")));
            favglos.setText(String.valueOf(rs2.getDouble("avgL")));

        }

        while (rs3.next()){
            favgin.setText(String.valueOf(rs3.getDouble("avgIn")));
            favgout.setText(String.valueOf(rs3.getDouble("avgOut")));
            fgoalsin.setText(String.valueOf(rs3.getInt("goals_in")));
            fgoalsout.setText(String.valueOf(rs3.getInt("goals_out")));
        }
    }
}
