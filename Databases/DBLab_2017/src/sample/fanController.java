package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by alexander on 11/8/2017.
 */
public class fanController
{

    @FXML private TableView<Game> gamesTable;
    @FXML private TableColumn<Game, Date> dateCol;
    @FXML private TableColumn<Game, String> teamACol;
    @FXML private TableColumn<Game, String> teamBCol;

    @FXML private TableView<Game> fanGamesTable;
    @FXML private TableColumn<Game, Date> fanDateCol;

    @FXML private TableColumn<Game, String> fanStadiumCol;

    @FXML private Button futureBtn;
    @FXML private Button pastBtn;
    @FXML private Button bookBtn;
    @FXML private Button infoBtn;
    @FXML private Button logOutBtn;
    @FXML private Label next_gameDate;
    @FXML private Label next_gameStadium;
    @FXML private Label Avseats;
    @FXML private Label bookingInfo;
    @FXML private Label gameDateLb;
    @FXML private Label gameTimeLb;
    @FXML private Label teamALb;
    @FXML private Label teamBLb;
    @FXML private Label gameRefLb;
    @FXML private Label gameStadiumLb;
    @FXML private Label gameResultLb;


    private String fanId;
    private String fanName;
    private int seats;
    private String teamName=null;
    private java.sql.Connection conn=null;
    private java.sql.PreparedStatement ps=null;
    private ResultSet rs, rs1, rs2, rs3 = null;
    private LoadConnector lc = new LoadConnector();
    private String stadium;
    private int hasPremTicket = 0, hasBooked = 0;
    private String showPFGames = "future";//will show if the games are of the past or future

    public String gameDate,gameID;
    private int premSeats, purSeats, stadiumCapacity;

    public void setGameDate(String date){this.gameDate=date;}
    public void setGameID(String gameID){this.gameID=gameID;}


    public void myTeam(String fanId) throws SQLException, ClassNotFoundException {
        rs = fanDAO.findMyTeam(fanId);
        while(rs.next()){this.teamName = rs.getString("team");}
    }

    @FXML private void pastBtnPushed(){
        this.showPFGames = "past";
        changeGameTable(showPFGames);
    }

    @FXML private void futureBtnPushed(){
        this.showPFGames = "future";
        changeGameTable(showPFGames);
    }


    @FXML private void infoBtnPushed() throws SQLException, ClassNotFoundException {
        rs = fanDAO.searchGameStats(teamName);
        String playName=null;
        int in,out,dif,wins,losses,draws, playGoals=0;

        while(rs.next()) {
            in = rs.getInt("goals_in");
            out = rs.getInt("goals_out");
            wins = rs.getInt("wins");
            losses = rs.getInt("losses");
            draws = rs.getInt("draws");

            dif = out - in;

            gameDateLb.setText("Goals Diff:" + String.valueOf(dif));
            gameTimeLb.setText(String.valueOf("Wins = " + wins));
            teamALb.setText(String.valueOf("Losses = " + losses));
            teamBLb.setText(String.valueOf("Draws = " + draws));
        }
            rs = fanDAO.myPlayer(fanId);
            while (rs.next()){
                playGoals = rs.getInt("goals");
                playName = rs.getString("name");
            }

            gameStadiumLb.setText(playName + " " + playGoals + " goals");
            gameResultLb.setText("");
        }



    @FXML private void gamesPushed() {

        //this gives us the rows that were selected
        gameDateLb.setText(String.valueOf(gamesTable.getSelectionModel().getSelectedItem().getDate()));
        gameTimeLb.setText(String.valueOf(gamesTable.getSelectionModel().getSelectedItem().getTime()));
        teamALb.setText(gamesTable.getSelectionModel().getSelectedItem().getTeamA());
        teamBLb.setText(gamesTable.getSelectionModel().getSelectedItem().getTeamB());
        gameStadiumLb.setText(gamesTable.getSelectionModel().getSelectedItem().getStadium());
        gameRefLb.setText(gamesTable.getSelectionModel().getSelectedItem().getRefee());
        gameResultLb.setText("");
        if(showPFGames=="past")
            {gameResultLb.setText(gamesTable.getSelectionModel().getSelectedItem().getGresult());}

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

    @FXML private void fanGamesPushed() {

        //this gives us the rows that were selected
        gameDateLb.setText(String.valueOf(fanGamesTable.getSelectionModel().getSelectedItem().getDate()));
        gameTimeLb.setText(String.valueOf(fanGamesTable.getSelectionModel().getSelectedItem().getTime()));
        teamALb.setText(fanGamesTable.getSelectionModel().getSelectedItem().getTeamA());
        teamBLb.setText(fanGamesTable.getSelectionModel().getSelectedItem().getTeamB());
        gameStadiumLb.setText(fanGamesTable.getSelectionModel().getSelectedItem().getStadium());
        gameResultLb.setText(fanGamesTable.getSelectionModel().getSelectedItem().getScore());
    }



    public void nextGame() throws SQLException, ClassNotFoundException {
    try {
        rs = fanDAO.findDate(teamName, Controller.getToday());
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    while(rs.next()){
        this.gameDate = rs.getString("date");
        this.gameID = rs.getString("game_id");
        }
    }

    public  void countSeats() throws SQLException, ClassNotFoundException {
        myTeam(fanId);
        nextGame();

        rs1 = fanDAO.premiumSeats(teamName, gameDate);
        rs2 = fanDAO.purchasedSeats(teamName, gameID);
        rs3 = fanDAO.stadiumCapacity(gameID);

        while (rs1.next()){premSeats = rs1.getInt("COUNT(0)");}
        while (rs2.next()){purSeats = rs2.getInt("COUNT(0)");}
        while (rs3.next()){
            stadiumCapacity = rs3.getInt("capacity");
            stadium = rs3.getString("name");
        }

        this.seats = stadiumCapacity/2 - premSeats - purSeats;

    }

    private void changeGameTable(String showPFGames){
        try {
            gamesTable.setItems(fanDAO.searchGames(teamName, Controller.getToday(), showPFGames));

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @FXML private void bookSeat() throws SQLException, ClassNotFoundException {
        // check if the fan has a premium ticket
        rs = fanDAO.checkFan(fanId);
        while (rs.next()){hasPremTicket = rs.getInt("code");}

        if(hasPremTicket>0){
            System.out.println("has premium ticket");
            bookBtn.setVisible(true);
            // check whether a seat has already been booked
            rs = fanDAO.checkIfBooked(gameID, fanId);
            while (rs.next()){hasBooked = rs.getInt("fan");}
            if(hasBooked>0){
                bookingInfo.setText("      already booked");

            }
            else{
                fanDAO.bookSeat(gameID, fanId);
                bookingInfo.setText("seat booked successfully");
            }
        }

    }

    public void showFanData(String fanId) throws SQLException, ClassNotFoundException {
        this.fanId = fanId;
        countSeats();
        bookBtn.setVisible(false);
        Avseats.setText(String.valueOf("               " + seats));
        next_gameDate.setText(String.valueOf("            "+gameDate));
        next_gameStadium.setText("            "+stadium);

        teamACol.setCellValueFactory(new PropertyValueFactory<Game, String>("teamA"));
        teamBCol.setCellValueFactory(new PropertyValueFactory<Game, String>("teamB"));
        dateCol.setCellValueFactory(new PropertyValueFactory<Game, Date>("date"));

        fanDateCol.setCellValueFactory(new PropertyValueFactory<Game, Date>("date"));
        fanStadiumCol.setCellValueFactory(new PropertyValueFactory<Game, String>("stadium"));
        try {
            fanGamesTable.setItems(fanDAO.searchFanGames(Controller.getToday(),fanId));
        }catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        changeGameTable(showPFGames);

    }
}
