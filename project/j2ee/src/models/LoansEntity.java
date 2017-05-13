package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by cl43 on 5/11/2017.
 */
@Entity
@Table(name = "LOANS", schema = "CL43", catalog = "")
public class LoansEntity {
    private long id;
    private Long amount;
    private Time createdate;
    private Time duedate;
    private String paid;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "AMOUNT")
    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    @Basic
    @Column(name = "CREATEDATE")
    public Time getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Time createdate) {
        this.createdate = createdate;
    }

    @Basic
    @Column(name = "DUEDATE")
    public Time getDuedate() {
        return duedate;
    }

    public void setDuedate(Time duedate) {
        this.duedate = duedate;
    }

    @Basic
    @Column(name = "PAID")
    public String getPaid() {
        return paid;
    }

    public void setPaid(String paid) {
        this.paid = paid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LoansEntity that = (LoansEntity) o;

        if (id != that.id) return false;
        if (amount != null ? !amount.equals(that.amount) : that.amount != null) return false;
        if (createdate != null ? !createdate.equals(that.createdate) : that.createdate != null) return false;
        if (duedate != null ? !duedate.equals(that.duedate) : that.duedate != null) return false;
        if (paid != null ? !paid.equals(that.paid) : that.paid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (amount != null ? amount.hashCode() : 0);
        result = 31 * result + (createdate != null ? createdate.hashCode() : 0);
        result = 31 * result + (duedate != null ? duedate.hashCode() : 0);
        result = 31 * result + (paid != null ? paid.hashCode() : 0);
        return result;
    }
}
