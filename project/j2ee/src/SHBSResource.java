import models.Order1Entity;


import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * Created by cl43 on 4/29/2017.
 * @author chrisLi
 * @version Spring, 2017
 */
/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */

@Stateless
@Path("shbs")
public class SHBSResource {
    @PersistenceContext
    private EntityManager em;

    /*Retrives a specific order by the order id from the order1Entity class via entity manager*/
    @GET
    @Path("order/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Order1Entity getOrder(@PathParam("id") long id) {
        return em.find(Order1Entity.class, id);
    }

    /*Retrives all orders that are entries in the entity and return them as a list.*/
    @GET
    @Path("orders")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Order1Entity> getOrders() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Order1Entity.class)).getResultList();
    }

    /*Updates the values of a specific order designated by the input id. Likewise another order1Entity object is made
    * with the new values for updating. The old object has its values changed to the new one and then EM merges the old one
    * in order to properly perform an update command.*/
    @PUT
    @Path("order/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response putOrder(Order1Entity updateOrder, @PathParam("id") long id){
        Order1Entity outDatedOrder = em.find(Order1Entity.class, id);

        if (updateOrder.getId() != outDatedOrder.getId()){
            return Response.serverError().entity("Customer id does not exist!").build();
        }

        outDatedOrder.setOrderdate(updateOrder.getOrderdate());
        outDatedOrder.setDeliverdate(updateOrder.getDeliverdate());
        outDatedOrder.setDuedate(updateOrder.getDuedate());
        outDatedOrder.setStatus(updateOrder.getStatus());
        outDatedOrder.setPrice(updateOrder.getPrice());

        em.merge(outDatedOrder);
        System.out.println("Order has been updated.");
        return Response.ok(em.find(Order1Entity.class,id), MediaType.APPLICATION_JSON).build();
    }

    /*Creates a new order1Entity by assigning the values through the argument order entity as its values*/
    @POST
    @Path("orders")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response postOrder(Order1Entity sourceOrder) {
        Order1Entity myOrder = new Order1Entity();

        myOrder.setOrderdate(sourceOrder.getOrderdate());
        myOrder.setDeliverdate(sourceOrder.getDeliverdate());
        myOrder.setDuedate(sourceOrder.getDuedate());
        myOrder.setStatus(sourceOrder.getStatus());
        myOrder.setPrice(sourceOrder.getPrice());

        em.persist(myOrder);
        System.out.println("Order has been created.");
        return  Response.ok(myOrder, MediaType.APPLICATION_JSON).build();
    }

    /*Removes a order by the designated id, if the id is null, then returns an error message, else it deletes and
    * returns a confirmation.*/
    @DELETE
    @Path("order/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteOrder( @PathParam("id") long id){
        if(em.find(Order1Entity.class, id) == null){
            return "Order not found.";
        }
        em.remove(em.find(Order1Entity.class, id));
        return "Order " + id +" has been deleted.";
    }
}
