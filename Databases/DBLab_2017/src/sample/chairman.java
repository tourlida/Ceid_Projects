package sample;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

public class chairman {
    private SimpleIntegerProperty fan_id = null;
    private SimpleStringProperty name = null;
    private SimpleStringProperty lastname = null;
    private SimpleStringProperty kind = null;
    private SimpleIntegerProperty profit = null;
    private SimpleIntegerProperty simple = null;
    private SimpleIntegerProperty continuous = null;


    public chairman(int fan_id, String name, String lastname, String kind)
    {   this.fan_id=new SimpleIntegerProperty(fan_id);
        this.name=new SimpleStringProperty(name);
        this.lastname=new SimpleStringProperty(lastname);
        this.kind=new SimpleStringProperty(kind);
    }

    public int getFan_id(){        return this.fan_id.get(); }
    public void setFan_id(int fan_id) {this.fan_id = new SimpleIntegerProperty(fan_id); }


    public String getName(){        return this.name.get(); }
    public void setName(String name) {
        this.name = new SimpleStringProperty(name);
    }

    public String getLastname(){        return this.lastname.get(); }
    public void setLastname(String lastname) {this.lastname = new SimpleStringProperty(lastname); }

    public String getKind(){        return this.kind.get(); }
    public void setKind(String kind) {this.kind = new SimpleStringProperty(kind); }

    public int  getprofit(){        return this.profit.get(); }
    public void setprofit(int profit) {this.profit = new SimpleIntegerProperty(profit); }
    public int getsSimple(){        return this.simple.get(); }
    public void setSimple(int simple) {this.simple= new SimpleIntegerProperty(simple); }
    public int getContinuous(){     return this.continuous.get(); }


}




