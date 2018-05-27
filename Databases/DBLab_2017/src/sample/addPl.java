package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by alexander on 15/8/2017.
 */
public class addPl {

    @FXML private TextField nameTF;
    @FXML private TextField lastnameTF;
    @FXML private TextField ageTF;
    @FXML private TextField goalsTF;
    @FXML private TextArea bioTA;
    @FXML private Button addBtn;
    @FXML private TextField posTF;
    @FXML private Button backBtn;

    private PreparedStatement ps1;
    private Connection conn = null;
    private LoadConnector lc = new LoadConnector();

    private String teamName, coachId;

    public void setName(String name){
        this.teamName = name;
    }

    public void setCoachId(String id){this.coachId = id;}

    @FXML private void logOut(ActionEvent event) throws IOException, SQLException, ClassNotFoundException {
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("CoachView.fxml"));
        Parent coachViewP = loader.load();
        //access the controller and call a method
        coachController controller = loader.getController();
        controller.showItems(coachId);
        Scene refViewS = new Scene(coachViewP);

        //This line gets the Stage information
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

        window.setScene(refViewS);
        window.show();
    }

    @FXML public void insertPlayer() throws SQLException {
        String name = nameTF.getText();
        String lastname = lastnameTF.getText();
        String age = ageTF.getText();
        String goals = goalsTF.getText();
        String pos = posTF.getText();
        String bio = bioTA.getText();

        String query = "INSERT INTO Player(name,lastname,goals,bio,age,pos,team) VALUES(?,?,?,?,?,?,?)";

        try {
            lc.connect();
            conn = lc.getConnection();
            ps1 = conn.prepareStatement(query);
            ps1.setString(1, name);
            ps1.setString(2, lastname);
            ps1.setString(3, goals);
            ps1.setString(4, bio);
            ps1.setString(5, age);
            ps1.setString(6, pos);
            ps1.setString(7, teamName);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

         ps1.executeUpdate();
        System.out.println(ps1);

    }

}
