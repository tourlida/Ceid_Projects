package sample;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

import java.sql.Date;
import java.sql.Time;

/**
 * Created by alexander on 9/8/2017.
 */
public class Game {
    private SimpleStringProperty teamA = null;
    private SimpleStringProperty teamB = null;
    private SimpleStringProperty stadium = null;
    private SimpleStringProperty gresult = null;
    private Date date = null;
    private Time time = null;
    private SimpleStringProperty refee = null;
    private SimpleStringProperty score = null;



    public Game(String teamA, String teamB, String stadium, Date date, String gresult) {
        this.teamA = new SimpleStringProperty(teamA);
        this.teamB = new SimpleStringProperty(teamB);
        this.stadium = new SimpleStringProperty(stadium);
        this.gresult = new SimpleStringProperty(gresult);
        this.date = date;

    }

    public Game(String teamA, String teamB, String stadium, Date date) {
        this.teamA = new SimpleStringProperty(teamA);
        this.teamB = new SimpleStringProperty(teamB);
        this.stadium = new SimpleStringProperty(stadium);
        this.date = date;
    }

    public Game(String teamA,String teamB, String stadium, Date date, Time time) {
        this.teamA = new SimpleStringProperty(teamA);
        this.teamB = new SimpleStringProperty(teamB);
        this.stadium = new SimpleStringProperty(stadium);
        this.date = date;
        this.time = time;
    }

    public Game(String teamA,String teamB, String stadium, Date date, String name,String result, Time time) {
        this.teamA = new SimpleStringProperty(teamA);
        this.teamB = new SimpleStringProperty(teamB);
        this.stadium = new SimpleStringProperty(stadium);
        this.date = date;
        this.time = time;
        this.refee = new SimpleStringProperty(name);
        this.gresult = new SimpleStringProperty(result);
    }

    public Game(String teamA,String teamB, String stadium, Date date, String name,String result, Time time, String score) {
        this.teamA = new SimpleStringProperty(teamA);
        this.teamB = new SimpleStringProperty(teamB);
        this.stadium = new SimpleStringProperty(stadium);
        this.date = date;
        this.time = time;
        this.refee = new SimpleStringProperty(name);
        this.gresult = new SimpleStringProperty(result);
        this.score = new SimpleStringProperty(score);
    }

    // teamA functions
    public String getTeamA() {
        return teamA.get();
    }

    public void setTeamA(String name) {
        this.teamA = new SimpleStringProperty(name);
    }

    // score functions
    public String getScore() {
        return score.get();
    }

    public void setScore(String score) {
        this.score = new SimpleStringProperty(score);
    }


    // refee functions
    public String getRefee() {
        return refee.get();
    }

    public void setRefee(String name) {
        this.refee = new SimpleStringProperty(name);
    }

    // teamB functions
    public String getTeamB() {
        return teamB.get();
    }

    public void setTeamB(String name) {
        this.teamB = new SimpleStringProperty(name);
    }

    public StringProperty teamBProperty(){return teamB;}

    // date functions
    public void setDate(Date date) {
        this.date = date;
    }
    public Date getDate(){return date;}


    // ground functions
    public String getStadium() {
        return stadium.get();
    }

    public void setStadium(String name) {
        this.stadium = new SimpleStringProperty(name);
    }



    // result functions
    public String getGresult() {
        return gresult.get();
    }

    public void setGresult(String res) {
        this.gresult = new SimpleStringProperty(res);
    }

    public Time getTime() {
        return this.time;
    }

    public void setTime(Time time) {
        this.time = time;
    }
}
