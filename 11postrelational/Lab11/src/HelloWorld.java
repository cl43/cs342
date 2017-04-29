/**
 * Created by cl43 on 4/21/2017.
 */
import javax.ws.rs.*;

// The Java class will be hosted at the URI path "/hello"
@Path("/hello")
public class HelloWorld {
    // The Java method will process HTTP GET requests
    @Path("/api")
    @GET
    @Produces("text/plain")
    public String Get() {
        return "Getting...";
    }

    @Path("/api/{put}")
    @PUT
    @Produces("text/plain")
    public String Put(@PathParam("put") Integer x) {
        return "Putting: " + x;
    }

    @Path("/api/{post}")
    @POST
    @Produces("text/plain")
    public String Post(@PathParam("post") String s) {
        return "Putting: " + s;
    }

    @Path("/api/{delete}")
    @DELETE
    @Produces("text/plain")
    public String Delete(@PathParam("delete") Integer x) {
        if(x < 0 || x > 9) {
            return "Insert an integer between 0 and 9!";
        }else{
            return "Deleting: " + x;
        }
    }

    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String getClichedMessage() {
        // Return some cliched textual content
        return "Hello World";
    }
}