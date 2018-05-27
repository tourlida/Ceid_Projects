package sample;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

/**
 * Created by alexander on 13/8/2017.
 */
public class player {

    private SimpleStringProperty name = null;
    private SimpleStringProperty lastname = null;
    private SimpleIntegerProperty pl_id = null;
    private SimpleStringProperty position = null;
    private SimpleStringProperty team = null;
    private SimpleIntegerProperty age = null;
    private String bio = "uknown";
    private SimpleIntegerProperty goals = null;



    public player(String name,String lastname,String team, int id, int age, String position) {
        this.name = new SimpleStringProperty(name);
        this.team = new SimpleStringProperty(team);
        this.lastname = new SimpleStringProperty(lastname);
        this.pl_id= new SimpleIntegerProperty(id);
        this.position = new SimpleStringProperty(position);
        this.age = new SimpleIntegerProperty(age);

    }

    public player(String name,String lastname,int age, String position, int goals) {
        this.name = new SimpleStringProperty(name);

        this.lastname = new SimpleStringProperty(lastname);

        this.position = new SimpleStringProperty(position);
        this.age = new SimpleIntegerProperty(age);
        this.goals = new SimpleIntegerProperty(goals);

    }

    // name functions
    public String getName() {
        return name.get();
    }

    public void setName(String name) {
        this.name = new SimpleStringProperty(name);
    }

    // lastname functions
    public String getLastname() {return lastname.get();}

    public void setLastname(String name) {this.lastname = new SimpleStringProperty(name);}

    //pl_id functions
    public int getId() {return pl_id.get();}

    public void setId(int id) {this.pl_id = new SimpleIntegerProperty(id);}

    //position functions
    public String getPosition() {return position.get();}

    public void setPosition(String pos) {this.lastname = new SimpleStringProperty(pos);}

    //age functions
    public int getAge() {return age.get();}

    public void setAge(int age) {this.age = new SimpleIntegerProperty(age);}

    // team functions
    public String getTeam() {
        return team.get();
    }

    public void setTeam(String name) {
        this.team = new SimpleStringProperty(name);
    }

    //goals functions
    public int getGoals() {return goals.get();}

    public void setGoals(int goals) {this.goals = new SimpleIntegerProperty(goals);}




}
