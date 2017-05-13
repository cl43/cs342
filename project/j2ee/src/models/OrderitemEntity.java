package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by cl43 on 5/11/2017.
 */
@Entity
@Table(name = "ORDERITEM", schema = "CL43", catalog = "")
public class OrderitemEntity {
    private Long quantity;

    @Basic
    @Column(name = "QUANTITY")
    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        OrderitemEntity that = (OrderitemEntity) o;

        if (quantity != null ? !quantity.equals(that.quantity) : that.quantity != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return quantity != null ? quantity.hashCode() : 0;
    }
}
