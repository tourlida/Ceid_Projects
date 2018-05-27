package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.sql.*;
import java.util.ResourceBundle;

public class Controller implements Initializable{

    @FXML private PasswordField passF;
    @FXML private TextField usernF;
    @FXML private TextField userDBTF;
    @FXML private PasswordField userDBPF;
    @FXML private Button lgBtn;
    @FXML private Button DBBtn;
    @FXML private TableView<Game> sqlData;
    @FXML private TableColumn<Game, String> teamAColumn;
    @FXML private TableColumn<Game, String> teamBColumn;
    @FXML private TableColumn<Game, String> stadiumColumn;
    @FXML private TableColumn<Game, Date> dateColumn;


    private PreparedStatement ps;
    private Connection conn;
    private ResultSet rs;
    private LoadConnector lc = new LoadConnector();

    private static String today = "2016-01-25";

    public static String getToday(){return today;}
/*
    @FXML private void LogInDB(){
        lc.setUSER(userDBTF.getText());
        lc.setPASSWORD(userDBPF.getText());
        try {
            lc.connect();
            usernF.setVisible(true);
            passF.setVisible(true);
            lgBtn.setVisible(true);
            this.connected = 1;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("connection to DB failed");
        }

    }*/

    public void Login(ActionEvent event) throws IOException, SQLException, ClassNotFoundException {
        //String query = "Select * From Person Where name=? and id=?";
        String query = null;
        int user = Integer.parseInt(passF.getText()) / 1000;
        if(user == 1){
             query = "Select * From Player Where name=? and id_play=?";
        }
        else if(user == 2){
             query = "Select * From Fan Where name=? and id_fan=?";
        }
        else if(user == 3){
             query = "Select * From Chairman Where name=? and id_chair=?";
        }
        else if(user == 4){
             query = "Select * From Coach Where name=? and id_coach=?";
        }
        else if(user == 5){
             query = "Select * From Refee Where name=? and id_refee=?";}

        try {
            lc.connect();
            conn = lc.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, usernF.getText());
            ps.setString(2, passF.getText());

        }
        catch (Exception e){System.out.println("something is wrong");}
        rs = ps.executeQuery();

        if(rs.next()){
            //if its a fan
              if(user == 2){
                  FXMLLoader loader = new FXMLLoader();
                  loader.setLocation(getClass().getResource("FanView.fxml"));
                  Parent coachViewP = loader.load();
                  //access the controller and call a method
                  fanController controller = loader.getController();
                  controller.showFanData(passF.getText());
                  Scene refViewS = new Scene(coachViewP);

                  //This line gets the Stage information
                  Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
                  window.setTitle("Fan");

                  window.setScene(refViewS);
                  window.show();
            }
            //if its a chairman
            else if(user == 3){
                  FXMLLoader loader = new FXMLLoader();
                  loader.setLocation(getClass().getResource("ChairmanView.fxml"));
                  Parent chairmanViewP = loader.load();
                  //access the controller and call a method
                  chairmanController controller = loader.getController();
                  //controller.Showlabels(passF.getText());//pairnw to id ws orisma sth displayChair_stats()
                  controller.showInfo(passF.getText());

                  Scene chairmanViewS = new Scene(chairmanViewP);

                  //This line gets the Stage information
                  Stage window = (Stage) ((Node) event.getSource()).getScene().getWindow();
                  window.setTitle("Chairman");

                  window.setScene(chairmanViewS);
                  window.show();
            }
            //if its a Coach
            else if(user == 4){
                  FXMLLoader loader = new FXMLLoader();
                  loader.setLocation(getClass().getResource("CoachView.fxml"));
                  Parent coachViewP = loader.load();
                  //access the controller and call a method
                  coachController controller = loader.getController();
                  controller.showItems(passF.getText());
                  Scene refViewS = new Scene(coachViewP, 750, 600);

                  //This line gets the Stage information
                  Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
                  window.setTitle("Coach");


                  window.setScene(refViewS);
                  window.show();
            }
            //if its a referee
            else if(user == 5){

                  FXMLLoader loader = new FXMLLoader();
                  loader.setLocation(getClass().getResource("RefView.fxml"));
                  Parent refViewP = loader.load();
                  //access the controller and call a method
                  refeeController controller = loader.getController();
                  controller.showItems(passF.getText());
                  Scene refViewS = new Scene(refViewP);

                  //This line gets the Stage information
                Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
                  window.setTitle("Referee");
                window.setScene(refViewS);
                window.show();
            }
        }

    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        DBBtn.setVisible(false);
        userDBTF.setVisible(false);
        userDBPF.setVisible(false);

        teamAColumn.setCellValueFactory(new PropertyValueFactory<Game, String>("teamA"));
        teamBColumn.setCellValueFactory(new PropertyValueFactory<Game, String>("teamB"));
        stadiumColumn.setCellValueFactory(new PropertyValueFactory<Game, String>("stadium"));
        dateColumn.setCellValueFactory(new PropertyValueFactory<Game, Date>("date"));

        try {
            sqlData.setItems(GameDAO.searchGames());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    }

