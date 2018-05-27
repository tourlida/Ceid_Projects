package sample;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

import java.sql.Date;
import java.sql.Time;

/**
 * Created by alexander on 10/8/2017.
 */
public class refee {
    private SimpleStringProperty name = null;
    private SimpleStringProperty lastname = null;
    private SimpleIntegerProperty ref_id = null;
    private SimpleStringProperty position = null;
    private SimpleIntegerProperty age = null;
    private SimpleStringProperty stadium = null;
    private SimpleStringProperty grounder = null;
    private SimpleStringProperty guest = null;
    private Date date = null;
    private Time time = null;


    public refee(String guest,String grounder,String stadium,Date date,String position, Time time) {
        this.guest = new SimpleStringProperty(guest);
        this.grounder = new SimpleStringProperty(grounder);
        this.stadium= new SimpleStringProperty(stadium);
        this.date = date;
        this.position = new SimpleStringProperty(position);
        this.time = time;

    }

    public refee(String name, String lastname, int age, int ref_id) {
        this.name = new SimpleStringProperty(name);
        this.lastname = new SimpleStringProperty(lastname);
        this.ref_id = new SimpleIntegerProperty(ref_id);
        this.age = new SimpleIntegerProperty(age);
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

    //ref_id functions
    public int getId() {return ref_id.get();}

    public void setId(int id) {this.ref_id = new SimpleIntegerProperty(id);}

    //position functions
    public String getPosition() {return position.get();}

    public void setPosition(String pos) {this.lastname = new SimpleStringProperty(pos);}

    //age functions
    public int getAge() {return age.get();}

    public void setAge(int age) {this.age = new SimpleIntegerProperty(age);}

    // date functions
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    // name ground
    public String getStadium() {
        return stadium.get();
    }

    public void setStadium(String ground) {
        this.stadium = new SimpleStringProperty(ground);
    }

    // grounder func
    public String getGrounder() {
        return grounder.get();
    }

    public void setGrounder(String grounder) {
        this.grounder = new SimpleStringProperty(grounder);
    }

    // name guest
    public String getGuest() {
        return guest.get();
    }

    public void setGuest(String guest) {
        this.guest = new SimpleStringProperty(guest);
    }


    public Time getTime() {
        return this.time;
    }

    public void setName(Time time) {
        this.time = time;
    }

}


