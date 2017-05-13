package models;

import javax.persistence.*;

/**
 * Created by cl43 on 5/11/2017.
 */
@Entity
@Table(name = "EMPLOYEE", schema = "CL43", catalog = "")
public class EmployeeEntity {
    private long id;
    private String fname;
    private String lname;
    private String position;
    private Long paycheck;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "FNAME")
    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    @Basic
    @Column(name = "LNAME")
    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    @Basic
    @Column(name = "POSITION")
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @Basic
    @Column(name = "PAYCHECK")
    public Long getPaycheck() {
        return paycheck;
    }

    public void setPaycheck(Long paycheck) {
        this.paycheck = paycheck;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        EmployeeEntity that = (EmployeeEntity) o;

        if (id != that.id) return false;
        if (fname != null ? !fname.equals(that.fname) : that.fname != null) return false;
        if (lname != null ? !lname.equals(that.lname) : that.lname != null) return false;
        if (position != null ? !position.equals(that.position) : that.position != null) return false;
        if (paycheck != null ? !paycheck.equals(that.paycheck) : that.paycheck != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (fname != null ? fname.hashCode() : 0);
        result = 31 * result + (lname != null ? lname.hashCode() : 0);
        result = 31 * result + (position != null ? position.hashCode() : 0);
        result = 31 * result + (paycheck != null ? paycheck.hashCode() : 0);
        return result;
    }
}
