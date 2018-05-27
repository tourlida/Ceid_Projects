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
import java.sql.Date;
import java.sql.SQLException;
/**
 * Created by alexander on 10/8/2017.
 */
public class refeeController{


    @FXML private Label timelb;
    @FXML private Label fdatelb;
    @FXML private Label fgroundlb;
    @FXML private Label fgrounderlb;
    @FXML private Label fguestlb;
    @FXML private Label fpositionlb;
    @FXML private Label ftimelb;
    @FXML private Button logOutBtn;

    @FXML private TableView<refee> table;
    @FXML private TableColumn<refee, String> grounderCol;
    @FXML private TableColumn<refee, String> guestCol;
    @FXML private TableColumn<refee, String> stadiumCol;
    @FXML private TableColumn<refee, Date> dateCol;
    @FXML private TableColumn<refee, String> positionCol;


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

    @FXML private void rowPushed() {
        //this gives us the rows that were selected
        fgrounderlb.setText(table.getSelectionModel().getSelectedItem().getGrounder());
        fgroundlb.setText(table.getSelectionModel().getSelectedItem().getStadium());
        fdatelb.setText(String.valueOf(table.getSelectionModel().getSelectedItem().getDate()));
        ftimelb.setText(String.valueOf(table.getSelectionModel().getSelectedItem().getTime()));
        fguestlb.setText(table.getSelectionModel().getSelectedItem().getGuest());
        fpositionlb.setText(table.getSelectionModel().getSelectedItem().getPosition());

    }

    public void showItems(String refID) throws SQLException, ClassNotFoundException {
        positionCol.setCellValueFactory(new PropertyValueFactory<refee, String>("position"));
        dateCol.setCellValueFactory(new PropertyValueFactory<refee, Date>("date"));
        stadiumCol.setCellValueFactory(new PropertyValueFactory<refee, String>("stadium"));
        guestCol.setCellValueFactory(new PropertyValueFactory<refee, String>("guest"));
        grounderCol.setCellValueFactory(new PropertyValueFactory<refee, String>("grounder"));

        table.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);

        try {
            table.setItems(refeeDAO.searchItems(refID, Controller.getToday()));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
