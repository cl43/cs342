import models.Household;
import models.Person;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;
/**
 * Created by cl43 on 4/29/2017.
 */
/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;


    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Person getPerson(@PathParam("id") long id) {
        return em.find(Person.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Person.class)).getResultList();
    }

    @PUT
    @Path("person/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response putPerson(Person updatePerson, @PathParam("id") long id){
        Person outDatedPerson = em.find(Person.class, id);

        if (updatePerson.getId() != outDatedPerson.getId()){
            return Response.serverError().entity("Person id does not exist!").build();
        }

        outDatedPerson.setFirstname(updatePerson.getFirstname());
        outDatedPerson.setLastname(updatePerson.getLastname());
        outDatedPerson.setBirthdate(updatePerson.getBirthdate());
        outDatedPerson.setGender(updatePerson.getGender());
        outDatedPerson.setHomegrouprole(updatePerson.getHouseholdrole());
        outDatedPerson.setMembershipstatus(updatePerson.getMembershipstatus());
        outDatedPerson.setTitle(updatePerson.getTitle());
        outDatedPerson.setHouseholdrole(updatePerson.getHouseholdrole());
        outDatedPerson.setHouseHold(updatePerson.getHouseHold());

        em.merge(outDatedPerson);
        return  Response.ok(em.find(Person.class,id), MediaType.APPLICATION_JSON).build();
    }

    @POST
    @Path("people")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response postPerson(Person sourcePerson) {
        Person myPerson = new Person();

        myPerson.setFirstname(sourcePerson.getFirstname());
        myPerson.setLastname(sourcePerson.getLastname());
        myPerson.setBirthdate(sourcePerson.getBirthdate());
        myPerson.setGender(sourcePerson.getGender());
        myPerson.setHomegrouprole(sourcePerson.getHouseholdrole());
        myPerson.setMembershipstatus(sourcePerson.getMembershipstatus());
        myPerson.setTitle(sourcePerson.getTitle());
        myPerson.setHouseholdrole(sourcePerson.getHouseholdrole());
        myPerson.setHouseHold(sourcePerson.getHouseHold());

        em.persist(myPerson);
        return  Response.ok(myPerson, MediaType.APPLICATION_JSON).build();
    }

    @DELETE
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deletePerson( @PathParam("id") long id){
        if(em.find(Person.class, id) == null){
            return "Person not found.";
        }
        em.remove(em.find(Person.class, id));
        return "{Person " + id +" has been deleted.";
    }
}