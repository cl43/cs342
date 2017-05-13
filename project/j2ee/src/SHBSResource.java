import models.Order1Entity;


import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;
/**
 * Created by cl43 on 5/11/2017.
 */
@Stateless
@Path("shbs")
public class SHBSResource {
    @PersistenceContext
    private EntityManager em;

    @GET
    @Path("order/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Order1Entity getOrder(@PathParam("id") long id) {
        return em.find(Order1Entity.class, id);
    }

    @GET
    @Path("orders")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Order1Entity> getOrders() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Order1Entity.class)).getResultList();
    }

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
