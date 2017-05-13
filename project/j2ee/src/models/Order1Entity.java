package models;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import java.sql.Time;
import java.util.List;

/**
 * Created by cl43 on 5/11/2017.
 */
@Entity
@Table(name = "ORDER1", schema = "CL43", catalog = "")
public class Order1Entity {
    private long id;
    private Time orderdate;
    private Time deliverdate;
    private Time duedate;
    private String status;
    private Long price;
    private Integer quantity;
    private EmployeeEntity employee;
    private CustomerEntity customer;
    private VehicleEntity vehicle;
    private List<ItemEntity> items;

    @ManyToOne
    @JoinColumn(name = "EMPLOYEEID", referencedColumnName = "ID")
    public EmployeeEntity getEmployee(){
        return employee;
    }
    public  void setEmployee(EmployeeEntity e){
        this.employee = e;
    }

    @ManyToOne
    @JoinColumn(name = "CUSTOMERID", referencedColumnName = "ID")
    public CustomerEntity getCustomer(){
        return customer;
    }
    public  void setCustomer(CustomerEntity c){
        this.customer = c;
    }

    @ManyToOne
    @JoinColumn(name = "VEHICLEID", referencedColumnName = "ID")
    public VehicleEntity getVehicle(){
        return vehicle;
    }
    public  void setVehicle(VehicleEntity v){
        this.vehicle = v;
    }

    @ManyToMany
    @JoinTable(name = "Item", schema = "SHBS",
            joinColumns = @JoinColumn(name = "ORDERID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "ITEMID", referencedColumnName = "ID", nullable = false))
    public List<ItemEntity> getItems(){
        return items;
    }
    public List<ItemEntity> setItems(List<ItemEntity> i){
        return this.items = i;
    }

    @Id
    @Column(name = "ID")
    @GeneratedValue(generator = "Order1_Sequence")
    @SequenceGenerator(name = "Order1_Sequence", sequenceName = "Order_sequence", allocationSize = 1)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "ORDERDATE")
    public Time getOrderdate() {
        return orderdate;
    }

    public void setOrderdate(Time orderdate) {
        this.orderdate = orderdate;
    }

    @Basic
    @Column(name = "DELIVERDATE")
    public Time getDeliverdate() {
        return deliverdate;
    }

    public void setDeliverdate(Time deliverdate) {
        this.deliverdate = deliverdate;
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
    @Column(name = "STATUS")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Basic
    @Column(name = "PRICE")
    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    @Basic
    @Column(name = "QUANTITY")
    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer q) {
        this.quantity = q;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Order1Entity that = (Order1Entity) o;

        if (id != that.id) return false;
        if (orderdate != null ? !orderdate.equals(that.orderdate) : that.orderdate != null) return false;
        if (deliverdate != null ? !deliverdate.equals(that.deliverdate) : that.deliverdate != null) return false;
        if (duedate != null ? !duedate.equals(that.duedate) : that.duedate != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (price != null ? !price.equals(that.price) : that.price != null) return false;
        if (quantity != null ? !quantity.equals(that.quantity) : that.quantity != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (orderdate != null ? orderdate.hashCode() : 0);
        result = 31 * result + (deliverdate != null ? deliverdate.hashCode() : 0);
        result = 31 * result + (duedate != null ? duedate.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (price != null ? price.hashCode() : 0);
        result = 31 * result + (quantity != null ? quantity.hashCode() : 0);
        return result;
    }
}
