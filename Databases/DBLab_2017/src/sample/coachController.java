package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.*;

/**
 * Created by alexander on 13/8/2017.
 */
public class coachController {

    LoadConnector lc = new LoadConnector();
    private PreparedStatement ps;
    private Connection conn;
    private ResultSet rs;
    private String teamName = null;
    private String coachId = null;

    @FXML private Label fgames;
    @FXML private Label fwins;
    @FXML private Label flosses;

    @FXML private Label f1;
    @FXML private Label f2;
    @FXML private Label f3;
    @FXML private Label f4;
    @FXML private Label f5;

    @FXML private Button statsBtn;
    @FXML private Button addPBtn;
    @FXML private Button logOutBtn;

    //lets define  the table that will show the future games
    @FXML private TableView<Game> gameTable;
    @FXML private TableColumn<Game, String> opponentCol;
    @FXML private TableColumn<Game, String> teamBCol;
    @FXML private TableColumn<Game, String> stadiumCol;
    @FXML private TableColumn<Game, Date> dateCol;

    //lets define  the table that will show the players
    @FXML private TableView<player> playerTable;
    @FXML private TableColumn<player, String> nameCol;
    @FXML private TableColumn<player, String> lastnameCol;


    public void setCoachId(String id){
        this.coachId = id;
    }

    @FXML private void logOut(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("sample.fxml"));
        Parent coachViewP = loader.load();
        Scene refViewS = new Scene(coachViewP);

        //This line gets the Stage information
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
        window.setScene(refViewS);
        window.show();
    }

    @FXML private void gamePushed() {

        //this gives us the rows that were selected
        f1.setText(String.valueOf(gameTable.getSelectionModel().getSelectedItem().getDate()));
        f2.setText(String.valueOf(gameTable.getSelectionModel().getSelectedItem().getTime()));
        f3.setText(gameTable.getSelectionModel().getSelectedItem().getTeamA());
        f4.setText(gameTable.getSelectionModel().getSelectedItem().getTeamB());
        f5.setText(gameTable.getSelectionModel().getSelectedItem().getStadium());

    }

    public void setTeamName(String name){
        this.teamName = name;
    }

    @FXML private void statsButton() throws SQLException, ClassNotFoundException, IOException {
        FXMLLoader loader = new FXMLLoader();
        Stage newStage = new Stage();
        loader.setLocation(getClass().getResource("StatsView.fxml"));
        Parent anotherRoot = loader.load();
        Scene anotherScene = new Scene(anotherRoot);
        newStage.setScene(anotherScene);
        newStage.setTitle(teamName);

        newStage.show();
        statDisplay controller = loader.getController();
        controller.display(teamName);

    }

    @FXML public void addTeamPlayer(ActionEvent event) throws IOException, SQLException {
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("addPlayer.fxml"));
        Parent tableViewParent = loader.load();

        Scene addinPlayerS = new Scene(tableViewParent);

        //access the controller and call a method
        addPl controller = loader.getController();
        controller.setName(teamName);
        controller.setCoachId(coachId);

        //This line gets the Stage information
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();

        window.setScene(addinPlayerS);
        window.show();
    }

    @FXML
    private void playerPushed() {

        //this gives us the rows that were selected
        f1.setText(playerTable.getSelectionModel().getSelectedItem().getName());
        f2.setText(playerTable.getSelectionModel().getSelectedItem().getLastname());
        f3.setText(String.valueOf(playerTable.getSelectionModel().getSelectedItem().getAge()));
        f4.setText(playerTable.getSelectionModel().getSelectedItem().getPosition());
        f5.setText(String.valueOf(playerTable.getSelectionModel().getSelectedItem().getGoals()));
    }

    private void showSt(String name) throws SQLException, ClassNotFoundException {
       String stmnt1 =  "SELECT (wins + losses + draws) AS 'total', wins, losses FROM Team WHERE Team.name=?";
       ResultSet rs = coachDAO.showSomeStats(name, stmnt1);
       while (rs.next()){
           fgames.setText(rs.getString("total"));
           fwins.setText(rs.getString("wins"));
           flosses.setText(rs.getString("losses"));
       }

    }

    public void showItems(String coachID) throws SQLException, ClassNotFoundException {
        String teamName = null; //teams name
        String query = "SELECT Team.name From Team INNER JOIN Coach ON Coach.team=Team.name WHERE Coach.id_coach="+coachID;
        rs = lc.OpenConnectionWithQuery(query);
        while(rs.next()){teamName = rs.getString("name");}

        setTeamName(teamName);
        setCoachId(coachID);

        try {
            playerTable.setItems(coachDAO.searchPlayers(teamName));
            gameTable.setItems(coachDAO.searchGames(teamName, Controller.getToday()));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        showSt(teamName);
        nameCol.setCellValueFactory(new PropertyValueFactory<player, String>("name"));
        lastnameCol.setCellValueFactory(new PropertyValueFactory<player, String>("lastname"));

        stadiumCol.setCellValueFactory(new PropertyValueFactory<Game, String>("stadium"));
        dateCol.setCellValueFactory(new PropertyValueFactory<Game, Date>("date"));
        opponentCol.setCellValueFactory(new PropertyValueFactory<Game, String>("teamA"));
        teamBCol.setCellValueFactory(new PropertyValueFactory<Game, String>("teamB"));

        playerTable.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
        gameTable.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);

    }

}
