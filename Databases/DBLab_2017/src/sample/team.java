package sample;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

/**
 * Created by alexander on 14/8/2017.
 */
public class team {
    private SimpleStringProperty name = null;
    private SimpleIntegerProperty goals_in = null;
    private SimpleIntegerProperty goals_out = null;
    private SimpleIntegerProperty wins = null;
    private SimpleIntegerProperty losses = null;
    private SimpleIntegerProperty draws = null;
    private SimpleIntegerProperty points = null;

    public team(String name, int in, int out, int wins, int losses, int draws, int points) {
        this.name = new SimpleStringProperty(name);
        this.goals_in = new SimpleIntegerProperty(in);
        this.goals_out = new SimpleIntegerProperty(out);
        this.wins = new SimpleIntegerProperty(wins);
        this.losses = new SimpleIntegerProperty(losses);
        this.draws = new SimpleIntegerProperty(draws);
        this.points = new SimpleIntegerProperty(points);
    }

    // name functions
    public String getName() {
        return name.get();
    }

    public void setName(String name) {
        this.name = new SimpleStringProperty(name);
    }

    // goals in functions
    public int getGoals_in() {
        return goals_in.get();
    }

    public void setGoals_in(int in) {
        this.goals_in = new SimpleIntegerProperty(in);
    }

    // goals out functions
    public int getGoals_out() {
        return goals_out.get();
    }

    public void setGoals_out(int out) {
        this.goals_out = new SimpleIntegerProperty(out);
    }

    // wins functions
    public int getWins() {
        return wins.get();
    }

    public void setWins(int wins) {
        this.wins = new SimpleIntegerProperty(wins);
    }

    // losses functions
    public int getLosses() {
        return losses.get();
    }

    public void setLosses(int losses) {
        this.losses = new SimpleIntegerProperty(losses);
    }

    // draws functions
    public int getDraws() {
        return draws.get();
    }

    public void setDraws(int draws) {
        this.draws = new SimpleIntegerProperty(draws);
    }

    // points functions
    public int getPoints() {
        return points.get();
    }

    public void setPoints(int points) {
        this.points = new SimpleIntegerProperty(points);
    }

}


