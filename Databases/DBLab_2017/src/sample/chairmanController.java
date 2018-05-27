package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class chairmanController {
    @FXML private TableView<chairman> chairmanTable;
    @FXML private TableColumn<chairman, Integer> id_fanCol;
    @FXML private TableColumn<chairman, String> nameCol; //Fan_name
    @FXML private TableColumn<chairman, String> lastnameCol; //Fan_lastname
    @FXML private TableColumn<chairman, String> kindCol; //Continuous or Simple?
    @FXML private Label fTeam_profitslb;
    @FXML private Label fsold_continuouslb;
    @FXML private Label fsold_simplelb;
    @FXML private Button buying_offerBtn;
    @FXML private Button reneawlBtn;
    @FXML private TextField fan_id_contF;
    @FXML private TextField fan_id_simpF;
    @FXML private Text txt1;
    @FXML private Text txt2;
    @FXML private Button logOutBtn;


    private int ContinuousSum = 0;
    private int SimpleSum = 0;
    private int profits = 0;
    private  String teamName = null;


    private ResultSet rs1, rs2, rs3,rs4,rs5 = null;
    private String Chairmanteam = null;
    private String chairmanId = null;
    private int inserted_fan_id = 0;
    private int inserted_fan_id_s = 0;
    private String ContFan_id = null;
    private String SimpleFan_id = null;

    private String kind=null;

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

    public void insertFan_id_cont() throws SQLException, ClassNotFoundException
  {
      ContFan_id=fan_id_contF.getText();
      try {
          rs4= chairmanDAO.Reneawl(ContFan_id, teamName);


      } catch (SQLException e) {
          e.printStackTrace();
      } catch (ClassNotFoundException e) {
          e.printStackTrace();
      }

   while (rs4.next()) {
          inserted_fan_id = rs4.getInt("id_fan");
     chairmanDAO.updateCont(inserted_fan_id);
      }

      if (inserted_fan_id==0)
      {
          txt1.setText("This fan id doesnt exist.Please try again:");
      }
      else {txt1.setText("Offer Completed");}

  }

    public void insertFan_id_simple() throws SQLException, ClassNotFoundException {
        SimpleFan_id = fan_id_simpF.getText();

        try {
            rs5 = chairmanDAO.Buying_offer(SimpleFan_id);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        while (rs5.next()) {

            inserted_fan_id_s = rs5.getInt("id_fan");

         System.out.println(inserted_fan_id_s);
            chairmanDAO.updateSimp(inserted_fan_id_s);

        }
        if (inserted_fan_id_s==0)
        {
            txt2.setText("This fan id doesnt exist.Please try again:");
        }
        else
        {
            txt2.setText("Offer Completed");
        }
    }


    public void findTeam() throws SQLException, ClassNotFoundException {
        try {
            rs3 = chairmanDAO.getTeam_name(chairmanId);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        while (rs3.next()) {

            teamName = rs3.getString("Team");

        }
    }

    public void displayChair_stats() throws SQLException, ClassNotFoundException {
        rs3 = chairmanDAO.getSimple(teamName);

        rs2 = chairmanDAO.getContinuous(teamName);


        while (rs2.next()) {
            ContinuousSum = rs2.getInt(("Continuous"));
            fsold_continuouslb.setText(String.valueOf(ContinuousSum));
        }

        while (rs3.next()) {
            SimpleSum = rs3.getInt(("Simple"));
            fsold_simplelb.setText(String.valueOf(SimpleSum));
        }
    }

    private void displayProfits() {
        profits = SimpleSum * 10 + ContinuousSum * 200;
        fTeam_profitslb.setText(String.valueOf(profits));
    }

             /*analoga me to id tou proedrou emfanizei statistika gia thn omada tou  */

    public void showInfo(String chairmanID) throws SQLException, ClassNotFoundException {
        this.chairmanId = chairmanID;
        id_fanCol.setCellValueFactory(new PropertyValueFactory("fan_id")); //class
        nameCol.setCellValueFactory(new PropertyValueFactory("name"));
        lastnameCol.setCellValueFactory(new PropertyValueFactory("lastname"));
        kindCol.setCellValueFactory(new PropertyValueFactory("kind"));

        try {
            findTeam();
            this.chairmanTable.setItems(chairmanDAO.searchInfo(teamName));
        } catch (ClassNotFoundException var3) {
            var3.printStackTrace();
        } catch (SQLException var4) {
            var4.printStackTrace();
        }

        //findTeam();
        displayChair_stats();
        displayProfits();

    }
}



